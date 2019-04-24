Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1CCC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 09:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BB9E218B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 09:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB9E218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38321 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJDvK-00061d-8t
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 05:10:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJDsb-0004Hc-JW
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hJDsZ-0008Fr-Jy
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:07:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hJDsZ-0008Dq-AW
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 05:07:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 505FD8666E;
	Wed, 24 Apr 2019 09:07:46 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-123.rdu2.redhat.com
	[10.10.120.123])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B94AC5C220;
	Wed, 24 Apr 2019 09:07:33 +0000 (UTC)
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20190329210804.22121-1-wainersm@redhat.com>
	<5005fcec-42af-427c-4f68-8415490e9598@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5bf78706-d357-a92d-7065-46a9839c9c2f@redhat.com>
Date: Wed, 24 Apr 2019 11:07:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5005fcec-42af-427c-4f68-8415490e9598@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 24 Apr 2019 09:07:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/5] tests/vm: Python 3,
 improve image caching, and misc
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, peter.maydell@linaro.org, alex.bennee@linaro.org,
	philmd@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424090732.nMTfam0lDzdDniUIqcmESXr5cT_jSNdt2xUMecaOjxw@z>

Hello Wainer,

(answering because I dislike ignoring emails without giving any feedback:=
)

On 04/23/19 21:28, Wainer dos Santos Moschetta wrote:
> Ping. More reviews needed.
>=20
> I've already got Philippe's reviewed-by, thanks!

I'm going to skip this one. According to "scripts/get_maintainer.pl", an
ACK from either Alex or Fam should suffice. (They could also decide to
queue your set with Phil's R-b, who's a designated reviewer on this topic=
.)

Thanks
Laszlo

> On 03/29/2019 06:07 PM, Wainer dos Santos Moschetta wrote:
>> Hi all!
>>
>> This series bundles the support to Python3, improvement to image
>> caching, and miscellaneous changes for the vm-test (`make vm-build-*`)=
.
>>
>> Git tree: http://github.com/wainersm/qemu
>> Branch: vm_test_python3_and_misc
>> Travis: https://travis-ci.org/wainersm/qemu/builds/513220300
>>
>> Below you can find some general comments.
>>
>> Patch 01:
>> Uses python configured at build, although vm-test can be executed from
>> the code tree (see docs/devel/testing.rst) too. In this case $(PYTHON)
>> will be empty and it picks python pointed by the script's shebang, as
>> a result failing on Python 3 only Linux distros.
>>
>> Patch 02:
>> Ported based.py to work with Python 3 (kept Python 2 compatibility).
>> Fixed the follow errors:
>> =C2=A0=C2=A0 - Raising "TypeError: Unicode-objects must be encoded bef=
ore
>> hashing" exception by hashlib.sha1().
>> =C2=A0=C2=A0 - get_default_jobs() is used to set the vm cpus, but it w=
as
>> returning an invalid float number.
>> =C2=A0=C2=A0 - On check_sha256sum(), subprocess.check_output() returns=
 bytes so
>> that string comparison was failing.
>>
>> Patch 03:
>> Implemented a simple mechanism to detect the image file changed on
>> http://download.patchew.org, as discussed in
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg607839.html. I
>> didn't implement the '--force' option that Paolo suggested, because it
>> would require a major refactoring (technically the vm implementation
>> decides whether use the cache or not). My intention is to keep the
>> script as simple as possible, so IMO, if the image file changed on the
>> server then it should equally be updated the checksum on QEMU's side.
>>
>> Patch 04:
>> Default network (NETWORK=3D1) backend is enough to have the docker-bas=
ed
>> tests run properly. Note: `make docker-test-block@centos7` is broken
>> inside the CentOS VM and apparently on my host (Fedora 29 x86_64) too.
>>
>> Wainer dos Santos Moschetta (5):
>> =C2=A0=C2=A0 tests/vm: Use python configured on build
>> =C2=A0=C2=A0 tests/vm: Port basevm to Python 3
>> =C2=A0=C2=A0 tests/vm: Detect the image changed on server
>> =C2=A0=C2=A0 tests/vm: Fix build-centos docker-based tests run
>> =C2=A0=C2=A0 tests/vm: Add missing variables on help
>>
>> =C2=A0 tests/vm/Makefile.include | 12 ++++++++----
>> =C2=A0 tests/vm/basevm.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
39 ++++++++++++++++++++++++++++++++++-----
>> =C2=A0 tests/vm/centos=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 6 +++---
>> =C2=A0 3 files changed, 45 insertions(+), 12 deletions(-)
>>
>=20


