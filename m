Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D174AC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D1920747
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D1920747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM7f5-0002IA-SM
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 06:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cfontana@suse.de>) id 1jM7eV-0001mX-2V
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cfontana@suse.de>) id 1jM7eT-0008PV-Iu
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:09:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:38494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cfontana@suse.de>) id 1jM7eT-0008Ov-D0
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:09:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id F0465AF4C;
 Wed,  8 Apr 2020 10:09:42 +0000 (UTC)
Subject: Re: [PATCH] Makefile: libfdt: build only the strict necessary
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <158632959483.16886.907739858138361292@39012742ff91>
 <6b2eca03-8fd0-54de-1622-ba26d4f1a31e@suse.de>
 <20200408090852.GB1073390@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <bc7e5ddf-c765-fcd1-bad3-61b957e14a43@suse.de>
Date: Wed, 8 Apr 2020 12:09:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200408090852.GB1073390@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
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
Cc: peter.maydell@linaro.org, david@gibson.dropbear.id.au,
 alex.bennee@linaro.org, qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/8/20 11:08 AM, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Apr 08, 2020 at 09:49:56AM +0200, Claudio Fontana wrote:
>> Hi,
>>
>> On 4/8/20 9:06 AM, no-reply@patchew.org wrote:
>>> Patchew URL: https://patchew.org/QEMU/20200408070231.20265-1-cfontana=
@suse.de/
>>>
>>>
>>>
>>> Hi,
>>>
>>> This series failed the asan build test. Please find the testing comma=
nds and
>>> their output below. If you have Docker installed, you can probably re=
produce it
>>> locally.
>>
>> I can't reproduce this here running the commands (TEST SCRIPT) below..
>>
>>>
>>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>>> #!/bin/bash
>>> export ARCH=3Dx86_64
>>> make docker-image-fedora V=3D1 NETWORK=3D1
>>> time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D1=
4 NETWORK=3D1
>>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>>
>>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>>> Makefile:532: dtc/libfdt/Makefile.libfdt: No such file or directory
>>
>> hmm this is the include directive
>>
>> include $(LIBFDT_srcdir)/Makefile.libfdt
>>
>> is this test not getting the dtc submodule for some reason?
>=20
> Note that this test script did not even get as far as trying to
> build QEMU itself.
>=20
> Starting from a clean checkout *WITHOUT* having run configure,
> it is trying todo
>=20
>    make docker-image-fedora V=3D1 NETWORK=3D1
>=20
> This should invoke the rules to launch docker, and then run
> configure inside docker. Instead it is trying to build dtc.
>=20
> So something in your changes has broken the ability to run
> the docker make targets.

Thanks, I can reproduce this now, will correct.

>=20
>>
>>> cc -nostdlib  -o dtc/libfdt/Makefile.libfdt.mo=20
>>
>> Hmm..
>>
>>> cc: fatal error: no input files
>>> compilation terminated.
>>> make: *** [dtc/libfdt/Makefile.libfdt.mo] Error 4
>>> Makefile:532: dtc/libfdt/Makefile.libfdt: No such file or directory
>>>   LD      dtc/libfdt/Makefile.libfdt.mo
>>> cc: fatal error: no input files
>>> compilation terminated.
>>> make: *** [dtc/libfdt/Makefile.libfdt.mo] Error 4
>>>
>>> real    0m0.585s
>>> user    0m0.384s
>>>
>>>
>>> The full log is available at
>>> http://patchew.org/logs/20200408070231.20265-1-cfontana@suse.de/testi=
ng.asan/?type=3Dmessage.
>>> ---
>>> Email generated automatically by Patchew [https://patchew.org/].
>>> Please send your feedback to patchew-devel@redhat.com
>>>
>>
>>
>=20
> Regards,
> Daniel
>=20


