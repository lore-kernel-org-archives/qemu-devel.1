Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E951AC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 19:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBB420780
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 19:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZj8N1xT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBB420780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW2PO-00089R-DE
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 15:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW2My-0006Oe-3k
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 15:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52684)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kW2Mv-0004zt-L9
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 15:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603479892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSuwQjIMLNSMxxryzABlQsbpGsIvEPyBuf8+viXVy/4=;
 b=NZj8N1xThhuSPgJXUmykW74W5UVp4MRcpozYfeJgpMgLMA/I5oA88ydyTItex3LJ5wtLd0
 UfGoXCkXvhNgKL5WbNQizSezqLEGTJ0N+82pkUzihFAD+KnfnG6PZyiBtg8bsLBI0sYlme
 Cy982wrTTAnundo8LLYHv5Gz9f/odro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-8BqNPDP4O7m2_oPsOHwpUg-1; Fri, 23 Oct 2020 15:04:50 -0400
X-MC-Unique: 8BqNPDP4O7m2_oPsOHwpUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7556D188C135;
 Fri, 23 Oct 2020 19:04:49 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C45135B4A1;
 Fri, 23 Oct 2020 19:04:47 +0000 (UTC)
Date: Fri, 23 Oct 2020 21:04:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PULL 25/33] tests/acceptance: Add a test for the N800 and N810
 arm machines
Message-ID: <20201023210445.2fa72562@redhat.com>
In-Reply-To: <c80350d2-3591-6541-abf3-960b69cedf7d@amsat.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
 <20200228163840.23585-26-peter.maydell@linaro.org>
 <a049110f-b7cb-52bd-de77-6e1193b5b6de@amsat.org>
 <6ce6a790-c68e-e3ed-962e-ba6f49244315@redhat.com>
 <f02d74fb-af6e-6e04-7ce7-48ab09a20e4f@amsat.org>
 <f2f276a9-a6ad-a2f8-2fbc-f1aca5423f79@amsat.org>
 <20201023174351.31838a86@redhat.com>
 <c80350d2-3591-6541-abf3-960b69cedf7d@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 19:39:16 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 10/23/20 5:43 PM, Igor Mammedov wrote:
> > On Mon, 19 Oct 2020 11:43:13 +0200
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote: =20
> >>>>> FYI this test is failing:
> >>>>>
> >>>>> qemu-system-arm: kernel 'meego-arm-n8x0-1.0.80.20100712.1431-vml
> >>>>> inuz-2.6.35~rc4-129.1-n8x0' is too large to fit in RAM (kernel size
> >>>>> 1964608,
> >>>>> RAM size 0) =20
> >>>
> >>> FWIW:
> >>>
> >>> 7998beb9c2e280f0b7424223747941f106e2e854 is the first bad commit
> >>> commit 7998beb9c2e280f0b7424223747941f106e2e854
> >>> Author: Igor Mammedov <imammedo@redhat.com>
> >>> Date:=C2=A0=C2=A0 Wed Feb 19 11:08:59 2020 -0500
> >>>
> >>>   =C2=A0=C2=A0=C2=A0 arm/nseries: use memdev for RAM
> >>>
> >>>   =C2=A0=C2=A0=C2=A0 memory_region_allocate_system_memory() API is go=
ing away, so
> >>>   =C2=A0=C2=A0=C2=A0 replace it with memdev allocated MemoryRegion. T=
he later is
> >>>   =C2=A0=C2=A0=C2=A0 initialized by generic code, so board only needs=
 to opt in
> >>>   =C2=A0=C2=A0=C2=A0 to memdev scheme by providing
> >>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MachineClass::default_ram_id
> >>>   =C2=A0=C2=A0=C2=A0 and using MachineState::ram instead of manually =
initializing
> >>>   =C2=A0=C2=A0=C2=A0 RAM memory region.
> >>>
> >>>   =C2=A0=C2=A0=C2=A0 PS:
> >>>   =C2=A0=C2=A0=C2=A0=C2=A0 while at it add check for user supplied RA=
M size and error
> >>>   =C2=A0=C2=A0=C2=A0=C2=A0 out if it mismatches board expected value.
> >>>
> >>>   =C2=A0=C2=A0=C2=A0 Signed-off-by: Igor Mammedov <imammedo@redhat.co=
m>
> >>>   =C2=A0=C2=A0=C2=A0 Reviewed-by: Andrew Jones <drjones@redhat.com>
> >>>   =C2=A0=C2=A0=C2=A0 Reviewed-by: Richard Henderson <richard.henderso=
n@linaro.org>
> >>>   =C2=A0=C2=A0=C2=A0 Message-Id: <20200219160953.13771-26-imammedo@re=
dhat.com> =20
> >>
> >> This fixes the issue:
> >> =20
> >> -- >8 -- =20
> >> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
> >> index e48092ca047..76fd7fe9854 100644
> >> --- a/hw/arm/nseries.c
> >> +++ b/hw/arm/nseries.c
> >> @@ -1318,6 +1318,7 @@ static void n8x0_init(MachineState *machine,
> >>            g_free(sz);
> >>            exit(EXIT_FAILURE);
> >>        }
> >> +    binfo->ram_size =3D machine->ram_size;
> >>
> >>        memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE,
> >>                                    machine->ram); =20
> >=20
> > we really should replace binfo->ram_size with machine->ram_size to avoi=
d
> > duplicating the same data, but as a quick fix this should fix issue. =
=20
>=20
> Hmm this is the 'ARM kernel loader' API in "arm/boot.h":
>=20
> struct arm_boot_info {
>      uint64_t ram_size;
>      const char *kernel_filename;
>      const char *kernel_cmdline;
>      const char *initrd_filename;
>      const char *dtb_filename;
>=20
> and:
>=20
>    void (*write_secondary_boot)(ARMCPU *cpu,
>                                 const struct arm_boot_info *info);
>    void (*secondary_cpu_reset_hook)(ARMCPU *cpu,
>                                     const struct arm_boot_info *info);
>=20
> Are you saying arm_boot_info should hold a pointer to MachineState*
> instead of duplicating?

yep, some parts of it (fdt related) already use MachineState* so it's
complete rewrite. The same probably applies to the fields you've just
quoted.

>=20


