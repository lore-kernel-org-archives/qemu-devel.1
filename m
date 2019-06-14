Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCBFC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 19:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F4F21773
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 19:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F4F21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54502 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbreA-0007qR-CF
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 15:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55162)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hbr0G-0001hH-QE
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 14:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hbr0E-0002CU-HY
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 14:32:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58886)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hbr0C-000260-Dt
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 14:32:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B9CC0309B159;
 Fri, 14 Jun 2019 18:32:31 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-141.ams2.redhat.com
 [10.36.116.141])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E859969A20;
 Fri, 14 Jun 2019 18:32:28 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20190311003052.13778-1-philmd@redhat.com>
 <20190311003052.13778-6-philmd@redhat.com>
 <ecd8aaf1-f75e-abd0-48b1-e80a227f01c3@redhat.com>
 <19958c32-2df9-cccf-3f05-c2fa0fe3dec2@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ed5896ab-4bb5-3e60-fb04-e3f535f4caac@redhat.com>
Date: Fri, 14 Jun 2019 20:32:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <19958c32-2df9-cccf-3f05-c2fa0fe3dec2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 14 Jun 2019 18:32:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 5/5] .travis.yml: Build and install EDK2
 roms
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/13/19 18:59, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Laszlo,
>=20
> On 3/12/19 5:29 PM, Laszlo Ersek wrote:
>> On 03/11/19 01:30, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Add a job to build and install the EDK2 platform firmware binaries.
>>>
>>> This job is only triggered if the last commit matches the EDK2
>>> name (case insensitive), or when tag are created (such releases
>>> or release candidates).
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>>  .travis.yml | 21 +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index e942175dd3..628cc52c99 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -258,3 +258,24 @@ matrix:
>>>      - env:
>>>          - CONFIG=3D"--disable-system"
>>>          - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>>> +
>>> +
>>> +    # EDK2 roms builds
>>> +    - if: tag IS present OR commit_message =3D~ /(edk2|EDK2)/
>>> +      env:
>>> +        - CONFIG=3D"--disable-system --disable-user --prefix=3D$PWD/=
dist"
>>> +        - EDK2_BUILD_OPTIONS=3D"--quiet --silent"
>>> +      script:
>>> +        - git submodule update --init roms/edk2
>>> +        - make -j3
>>> +        - make -C roms efi -j2
>>> +        - make install
>>> +      addons:
>>> +        apt:
>>> +          packages:
>>> +            - dos2unix
>>> +            - gcc-aarch64-linux-gnu
>>> +            - gcc-arm-linux-gnueabihf
>>> +            - iasl
>>> +            - nasm
>>> +            - uuid-dev
>>>
>>
>> Regardless of what problem we're trying to address with "--quiet
>> --silent", those options are wrong. You certainly want detailed build
>> logs for the case a CI job fails (at build time or at runtime).
>=20
> On Travis we get:
>=20
> The job exceeded the maximum log length, and has been terminated.
> (https://travis-ci.org/philmd/qemu/jobs/545329905)
>=20
> So I moved to GitLab, but we still get:
>=20
> "Job's log exceeded limit of 4194304 bytes."
> (https://gitlab.com/philmd/qemu/-/jobs/230772314)
>=20
> Regarding the options to pass to edk2-build.sh,
>=20
> $ build --help
>   -j LOGFILE, --log=3DLOGFILE
>                    Put log in specified file as well as on console.
>   -s, --silent     Make use of silent mode of (n)make.
>   -q, --quiet      Disable all messages except FATAL ERRORS.
>   -v, --verbose    Turn on verbose output with informational messages
>                    printed, including library instances selected, final
>                    dependency expression, and warning messages, etc.
>=20
> '--log' duplicate the output, and I don't want to reduce the log
> details, so I understand I should use:
>=20
>   ./edk2-build.sh [...] --log=3Dbuild.log >/dev/null || cat build.log
>=20
> Is that correct? But then I'd need to modify Makefile.edk2 to redirect
> stdout.

Would it be possible to invoke the outermost make like this?

  make -C roms -j2 efi >make.roms.efi.log 2>&1 \
  || ( tail -c 2M make.roms.efi.log; false )

Thanks
Laszlo

>=20
>> The reason why I only include DEBUG firmware builds in the edk2 bundli=
ng
>> series is similar -- RELEASE builds lack DEBUG messages and ASSERT()s,
>> and as such they are 100% unsupportable in my book. Bugs in software a=
re
>> the norm, not the exception, so we should allow (even force) the user
>> (and remote systems) to provide as much information as they can.
>=20
> Sure, we have the same book here ;)
>=20
> Regards,
>=20
> Phil.
>=20


