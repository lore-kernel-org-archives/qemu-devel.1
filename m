Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB89C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0AB2192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJHG3R23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0AB2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVznp-0000pt-5p
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVzEa-0001as-1u
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVzEX-0003co-Mx
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603467840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lbUP88NTT4nGnLhbE3+UFCBt3Kw+zbtZK7+FwOZd5nU=;
 b=MJHG3R23LJSTGhNCKkE6R/L0VQK6mRn3/Gs8rM9MukV8DAN+UvPQueZINfqsxPOvoW58I+
 GZeewdDrToIxBHN4PC/fP6j8q6Xv+EPYIlO3SGkskSanw7mcGODSbuTBLeQxg+HTC4iQWs
 f70NJWRvmFL3Ue8x5C5TT2+nhpMya0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-zOO4_cC2NS2S5L15763HOA-1; Fri, 23 Oct 2020 11:43:56 -0400
X-MC-Unique: zOO4_cC2NS2S5L15763HOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E4F61074642;
 Fri, 23 Oct 2020 15:43:55 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 594FC60BFA;
 Fri, 23 Oct 2020 15:43:52 +0000 (UTC)
Date: Fri, 23 Oct 2020 17:43:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PULL 25/33] tests/acceptance: Add a test for the N800 and N810
 arm machines
Message-ID: <20201023174351.31838a86@redhat.com>
In-Reply-To: <f2f276a9-a6ad-a2f8-2fbc-f1aca5423f79@amsat.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
 <20200228163840.23585-26-peter.maydell@linaro.org>
 <a049110f-b7cb-52bd-de77-6e1193b5b6de@amsat.org>
 <6ce6a790-c68e-e3ed-962e-ba6f49244315@redhat.com>
 <f02d74fb-af6e-6e04-7ce7-48ab09a20e4f@amsat.org>
 <f2f276a9-a6ad-a2f8-2fbc-f1aca5423f79@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alex =?UTF-8?B?QmVu?= =?UTF-8?B?bsOpZQ==?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 11:43:13 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 10/19/20 11:30 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 10/19/20 8:31 AM, Thomas Huth wrote: =20
> >> On 17/10/2020 19.51, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>> Hi Peter, Igor, Thomas,
> >>>
> >>> On 2/28/20 5:38 PM, Peter Maydell wrote: =20
> >>>> From: Thomas Huth <thuth@redhat.com>
> >>>>
> >>>> Old kernels from the Meego project can be used to check that Linux
> >>>> is at least starting on these machines.
> >>>>
> >>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>>> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> >>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>>> Message-id: 20200225172501.29609-2-philmd@redhat.com
> >>>> Message-Id: <20200129131920.22302-1-thuth@redhat.com>
> >>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >>>> ---
> >>>> =C2=A0=C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> >>>> =C2=A0=C2=A0 tests/acceptance/machine_arm_n8x0.py | 49=20
> >>>> ++++++++++++++++++++++++++++
> >>>> =C2=A0=C2=A0 2 files changed, 50 insertions(+)
> >>>> =C2=A0=C2=A0 create mode 100644 tests/acceptance/machine_arm_n8x0.py
> >>>>
> >>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>> index b66c46dcb9f..264374adbe8 100644
> >>>> --- a/MAINTAINERS
> >>>> +++ b/MAINTAINERS
> >>>> @@ -686,6 +686,7 @@ F: hw/rtc/twl92230.c
> >>>> =C2=A0=C2=A0 F: include/hw/display/blizzard.h
> >>>> =C2=A0=C2=A0 F: include/hw/input/tsc2xxx.h
> >>>> =C2=A0=C2=A0 F: include/hw/misc/cbus.h
> >>>> +F: tests/acceptance/machine_arm_n8x0.py
> >>>> =C2=A0=C2=A0 =C2=A0 Palm
> >>>> =C2=A0=C2=A0 M: Andrzej Zaborowski <balrogg@gmail.com>
> >>>> diff --git a/tests/acceptance/machine_arm_n8x0.py
> >>>> b/tests/acceptance/machine_arm_n8x0.py
> >>>> new file mode 100644
> >>>> index 00000000000..e5741f2d8d1
> >>>> --- /dev/null
> >>>> +++ b/tests/acceptance/machine_arm_n8x0.py
> >>>> @@ -0,0 +1,49 @@
> >>>> +# Functional test that boots a Linux kernel and checks the console
> >>>> +#
> >>>> +# Copyright (c) 2020 Red Hat, Inc.
> >>>> +#
> >>>> +# Author:
> >>>> +#=C2=A0 Thomas Huth <thuth@redhat.com>
> >>>> +#
> >>>> +# This work is licensed under the terms of the GNU GPL, version 2 o=
r
> >>>> +# later.=C2=A0 See the COPYING file in the top-level directory.
> >>>> +
> >>>> +import os
> >>>> +
> >>>> +from avocado import skipUnless
> >>>> +from avocado_qemu import Test
> >>>> +from avocado_qemu import wait_for_console_pattern
> >>>> +
> >>>> +class N8x0Machine(Test):
> >>>> +=C2=A0=C2=A0=C2=A0 """Boots the Linux kernel and checks that the co=
nsole is=20
> >>>> operational"""
> >>>> +
> >>>> +=C2=A0=C2=A0=C2=A0 timeout =3D 90
> >>>> +
> >>>> +=C2=A0=C2=A0=C2=A0 def __do_test_n8x0(self):
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_url =3D ('http://=
stskeeps.subnetmask.net/meego-n8x0/'
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'meego-arm-n8x=
0-1.0.80.20100712.1431-'
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'vmlinuz-2.6.3=
5~rc4-129.1-n8x0')
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_hash =3D 'e9d5ab8=
d7548923a0061b6fbf601465e479ed269'
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D self.fet=
ch_asset(kernel_url,=20
> >>>> asset_hash=3Dkernel_hash)
> >>>> +
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.set_console(cons=
ole_index=3D1)
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.add_args('-kerne=
l', kernel_path,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 '-append', 'printk.time=3D0 console=3DttyS1')
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm.launch()
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_for_console_pattern=
(self, 'TSC2005 driver initializing')
> >>>> +
> >>>> +=C2=A0=C2=A0=C2=A0 @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_C=
ODE'),=20
> >>>> 'untrusted code')
> >>>> +=C2=A0=C2=A0=C2=A0 def test_n800(self):
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:ar=
m
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine=
:n800
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.__do_test_n8x0()
> >>>> +
> >>>> +=C2=A0=C2=A0=C2=A0 @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_C=
ODE'),=20
> >>>> 'untrusted code')
> >>>> +=C2=A0=C2=A0=C2=A0 def test_n810(self):
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Darch:ar=
m
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 :avocado: tags=3Dmachine=
:n810
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.__do_test_n8x0()
> >>>> =20
> >>>
> >>> FYI this test is failing:
> >>>
> >>> qemu-system-arm: kernel 'meego-arm-n8x0-1.0.80.20100712.1431-vml
> >>> inuz-2.6.35~rc4-129.1-n8x0' is too large to fit in RAM (kernel size=
=20
> >>> 1964608,
> >>> RAM size 0) =20
> >=20
> > FWIW:
> >=20
> > 7998beb9c2e280f0b7424223747941f106e2e854 is the first bad commit
> > commit 7998beb9c2e280f0b7424223747941f106e2e854
> > Author: Igor Mammedov <imammedo@redhat.com>
> > Date:=C2=A0=C2=A0 Wed Feb 19 11:08:59 2020 -0500
> >=20
> >  =C2=A0=C2=A0=C2=A0 arm/nseries: use memdev for RAM
> >=20
> >  =C2=A0=C2=A0=C2=A0 memory_region_allocate_system_memory() API is going=
 away, so
> >  =C2=A0=C2=A0=C2=A0 replace it with memdev allocated MemoryRegion. The =
later is
> >  =C2=A0=C2=A0=C2=A0 initialized by generic code, so board only needs to=
 opt in
> >  =C2=A0=C2=A0=C2=A0 to memdev scheme by providing
> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MachineClass::default_ram_id
> >  =C2=A0=C2=A0=C2=A0 and using MachineState::ram instead of manually ini=
tializing
> >  =C2=A0=C2=A0=C2=A0 RAM memory region.
> >=20
> >  =C2=A0=C2=A0=C2=A0 PS:
> >  =C2=A0=C2=A0=C2=A0=C2=A0 while at it add check for user supplied RAM s=
ize and error
> >  =C2=A0=C2=A0=C2=A0=C2=A0 out if it mismatches board expected value.
> >=20
> >  =C2=A0=C2=A0=C2=A0 Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >  =C2=A0=C2=A0=C2=A0 Reviewed-by: Andrew Jones <drjones@redhat.com>
> >  =C2=A0=C2=A0=C2=A0 Reviewed-by: Richard Henderson <richard.henderson@l=
inaro.org>
> >  =C2=A0=C2=A0=C2=A0 Message-Id: <20200219160953.13771-26-imammedo@redha=
t.com> =20
>=20
> This fixes the issue:
>=20
> -- >8 -- =20
> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
> index e48092ca047..76fd7fe9854 100644
> --- a/hw/arm/nseries.c
> +++ b/hw/arm/nseries.c
> @@ -1318,6 +1318,7 @@ static void n8x0_init(MachineState *machine,
>           g_free(sz);
>           exit(EXIT_FAILURE);
>       }
> +    binfo->ram_size =3D machine->ram_size;
>=20
>       memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE,
>                                   machine->ram);

we really should replace binfo->ram_size with machine->ram_size to avoid
duplicating the same data, but as a quick fix this should fix issue.

Acked-by: Igor Mammedov <imammedo@redhat.com>


> ---
>=20
> >  =20
> >>>
> >>> Alex, Thomas, can we enable AVOCADO_ALLOW_UNTRUSTED_CODE on GitLab
> >>> to avoid such regressions? =20
> >>
> >> Yes, please, if you've got some spare minutes to work on such a patch,=
=20
> >> that
> >> would be great! ... I once already wanted to send such a patch, but II=
RC
> >> there were some other ALLOW_UNTRUSTED_CODE tests failing at that poing=
 in
> >> time, and I never got around to fix them...
> >>
> >> =C2=A0 Thomas
> >>
> >> =20
> >  =20
>=20


