Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DC8C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0DE2081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdaomzGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0DE2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iou1Y-00057U-R1
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 13:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iou0t-0004Rp-6P
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iou0p-0003oY-I2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:55:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49080
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iou0n-0003lu-Td
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578423328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmZRXuDtnEeIEqoRlZMC18TtzT9fykK5v2Wd1H6c3iM=;
 b=bdaomzGPUTZWp9+Jmv8GJ1IK79lyDyeOu4kocHn7kt7IUd8kfy7RxT9XgTX/X7YqP+Ge3z
 OJXMOF5ik9f+xDKmdiZXgMKn+t0r7/zb+yBLNXxH+MolEFeOH+BCVQE9XoJ7E7FIidksNW
 5UVpMiVIlXQ0zLC7zRzwOZCbrM7qOl4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-94p5iUUdP2ad6CTAU8IrIg-1; Tue, 07 Jan 2020 13:55:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8896800A02;
 Tue,  7 Jan 2020 18:55:24 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-126.ams2.redhat.com
 [10.36.117.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06A871000328;
 Tue,  7 Jan 2020 18:55:20 +0000 (UTC)
Subject: Re: [PATCH 2/3] gitlab-ci.yml: Add a job to build EDK2 firmware
 binaries
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200106184601.25453-1-philmd@redhat.com>
 <20200106184601.25453-3-philmd@redhat.com>
 <74b5d03a-c3a3-38b8-68cb-192dd04f1802@redhat.com>
 <505f9ed4-5b40-79d2-ac32-3ffb3d6c6976@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <af8fa8bd-5bf2-05bb-7723-1e2b00a6c63b@redhat.com>
Date: Tue, 7 Jan 2020 19:55:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <505f9ed4-5b40-79d2-ac32-3ffb3d6c6976@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 94p5iUUdP2ad6CTAU8IrIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/07/20 12:35, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/7/20 11:12 AM, Laszlo Ersek wrote:
>> On 01/06/20 19:46, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Add a GitLab job to build the EDK2 firmware binaries.
>>> This job is only built when the roms/edk2/ submodule is updated,
>>> when a git-ref starts with 'edk2' or when the last commit contains
>>> 'EDK2'.
>>
>> keyword "or"; okay.
>>
>>>
>>> GitLab CI generates an artifacts.zip file containing the firmware
>>> binaries.
>>>
>>> With edk2-stable201905, the job took 40 minutes 26 seconds,
>>> the artifacts.zip takes 10MiB.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>> =C2=A0 .gitlab-ci-edk2.yml | 37 +++++++++++++++++++++++++++++++++++++
>>> =C2=A0 .gitlab-ci.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
>>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 ++-
>>> =C2=A0 3 files changed, 42 insertions(+), 1 deletion(-)
>>> =C2=A0 create mode 100644 .gitlab-ci-edk2.yml
>>>
>>> diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci-edk2.yml
>>> new file mode 100644
>>> index 0000000000..abfaf52874
>>> --- /dev/null
>>> +++ b/.gitlab-ci-edk2.yml
>>> @@ -0,0 +1,37 @@
>>> +build-edk2:
>>> + rules: # Only run this job when ...
>>> + - changes: # ... roms/edk2/ is modified (submodule updated)
>>> +=C2=A0=C2=A0 - roms/edk2/*
>>> +=C2=A0=C2=A0 when: always
>>> + - if: '$CI_COMMIT_REF_NAME =3D~ /^edk2/' # ... the branch/tag starts
>>> with 'edk2'
>>
>> (1) can you add "or" in the comment here?
>>
>>> +=C2=A0=C2=A0 when: always
>>> + - if: '$CI_COMMIT_MESSAGE =3D~ /edk2/i' # last commit description
>>> contains 'EDK2'
>>
>> (2) ditto
>>
>>> +=C2=A0=C2=A0 when: always
>>> + artifacts:
>>> +=C2=A0=C2=A0 paths: # 'artifacts.zip' will contains the following file=
s:
>>> +=C2=A0=C2=A0 - pc-bios/edk2*bz2
>>> +=C2=A0=C2=A0 - pc-bios/edk2-licenses.txt
>>> +=C2=A0=C2=A0 - edk2-stdout.log
>>> +=C2=A0=C2=A0 - edk2-stderr.log
>>> + image: ubuntu:16.04 # Use Ubuntu Xenial
>>> + before_script: # Install packages requiered to build EDK2
>>> + - apt-get update --quiet --quiet
>>> + - DEBIAN_FRONTEND=3Dnoninteractive
>>> +=C2=A0=C2=A0 apt-get install --assume-yes --no-install-recommends --qu=
iet --quiet
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 build-essential
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 ca-certificates
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 dos2unix
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 gcc-aarch64-linux-gnu
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 gcc-arm-linux-gnueabi
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 git
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 iasl
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 make
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 nasm
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 python
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 uuid-dev
>>> + script: # Clone the required submodules and build EDK2
>>> + - git submodule update --init roms/edk2
>>
>> yes, this is needed; qemu users are used to updating top-level
>> submodules (which is why we didn't try to automate that away in the edk2
>> build stuff)
>>
>>> + - git -C roms/edk2 submodule update --init
>>
>> (3) but this should not be necessary. See the "submodules" target in
>> "roms/Makefile.edk2".
>=20
> Hmm build fails without it:
> https://gitlab.com/philmd/qemu/-/jobs/395644357#L436
>=20
> The 'test -d edk2/.git' might be not enough?

Huh, possibly a regression from commit f3e330e3c319
("roms/Makefile.edk2: don't pull in submodules when building from
tarball", 2019-10-07)?

Anyway, let me jump forward to your latest posting.

Thanks!
Laszlo

>=20
>>> + - export JOBS=3D$(($(getconf _NPROCESSORS_ONLN) + 1))
>>> + - echo "=3D=3D=3D Using ${JOBS} simultaneous jobs =3D=3D=3D"
>>> + - make -j${JOBS} -C roms efi 1>edk2-stdout.log 2> >(tee -a
>>> edk2-stderr.log >&2)
>>
>> Process substitution is a nifty feature, but perhaps we can do without
>> it, for simplicity. (I realize this is bash-only; I just like to
>> minimize the use of non-portable features if there is a portable
>> replacement that is also simple.)
>>
>> Redirections are processed in the order they appear on the command line
>> [1], *after* stdout/stdin is redirected for pipelining [2]:
>>
>> [1]
>> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.htm=
l#tag_18_07
>>
>>
>> "If more than one redirection operator is specified with a command, the
>> order of evaluation is from beginning to end."
>>
>> [2]
>> https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.htm=
l#tag_18_09_02
>>
>>
>> "The standard input, standard output, or both of a command shall be
>> considered to be assigned by the pipeline before any redirection
>> specified by redirection operators that are part of the command"
>>
>>
>> (4) Therefore, the following should work:
>>
>> =C2=A0=C2=A0 make -j${JOBS} -C roms efi 2>&1 1>edk2-stdout.log \
>> =C2=A0=C2=A0 | tee -a edk2-stderr.log >&2
>>
>> Untested, of course :)
>=20
> This works like charm :>
>=20
>> Looks OK otherwise.
>=20
> Thanks for the review!
>=20
>>
>> Thanks!
>> Laszlo
>=20


