Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BD2C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6794E20679
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6794E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK3xw-0001uo-Mr
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 12:44:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hK3x3-0001XR-Q7
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:43:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hK3x2-0004on-Mw
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:43:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>)
	id 1hK3x0-0004iy-1l; Fri, 26 Apr 2019 12:43:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98FFB308B251;
	Fri, 26 Apr 2019 16:43:47 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-104.rdu2.redhat.com
	[10.10.121.104])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 11A99600C5;
	Fri, 26 Apr 2019 16:43:37 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-5-thuth@redhat.com>
	<f9dc291b-7ba2-c6b8-33aa-c8fa3c6d4950@redhat.com>
	<0300c8cc-d73c-b919-13f7-59f3218a609f@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <13ecf357-d43c-ecc6-012e-bed62008677d@redhat.com>
Date: Fri, 26 Apr 2019 18:43:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0300c8cc-d73c-b919-13f7-59f3218a609f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 26 Apr 2019 16:43:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/6] cirrus / travis: Add gnu-sed and bash
 for macOS and FreeBSD
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426164336.e4RLoTN3k0WW5_wAjGf3ZNXucVNzV9dvPUxmjsAIWhc@z>

(+Dan)

On 04/25/19 08:00, Thomas Huth wrote:
> On 24/04/2019 23.29, Wainer dos Santos Moschetta wrote:
>> Hello Thomas,
>>
>> On 04/24/2019 07:37 AM, Thomas Huth wrote:
>>> We are going to enable the qemu-iotests during "make check" again,
>>> and for running the iotests, we need bash and gnu-sed.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>> =C2=A0 .cirrus.yml | 4 ++--
>>> =C2=A0 .travis.yml | 1 +
>>> =C2=A0 2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> It needs to get the Freebsd image [1] updated too, in order to `make
>> BUILD_TARGET=3Dcheck vm-build-freebsd` passes. Here it failed with:
>> ---
>> env: bash: No such file or directory
>> gmake: *** [/var/tmp/qemu-test.6OlDFH/tests/Makefile.include:1101:
>> check-tests/qemu-iotests-quick.sh] Error 1
>> gmake: *** Waiting for unfinished jobs....
>> ---
>>
>> I'm not sure about the netbsd and openbsd images, they might need bash
>> and gnu-sed as well.
>=20
> D'oh! Does anybody know what are the correct steps to update these imag=
es?

(1) make the OPENBSD subsystem maintainer care

(2) update <https://wiki.qemu.org/Hosts/BSD>

(3) download the image from download.patchew.org, boot it and update it

(4) upload the image to download.patchew.org

(5) update the "tests/vm/openbsd" script in the QEMU tree in sync
(checksums, commands etc)


I'm fairly sure (1) is necessary; the rest is more or less guesswork on
my part.

Thanks
Laszlo

