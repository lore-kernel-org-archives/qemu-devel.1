Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC649C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2916205ED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cam.ac.uk header.i=@cam.ac.uk header.b="blOOxGUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2916205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cl.cam.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38815 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTNAk-0007UP-3L
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 05:04:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hmka2@hermes.cam.ac.uk>) id 1hTN7i-0005b1-9f
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hmka2@hermes.cam.ac.uk>) id 1hTN7d-0004rC-6t
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:01:22 -0400
Received: from ppsw-30.csi.cam.ac.uk ([131.111.8.130]:36190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hmka2@hermes.cam.ac.uk>)
	id 1hTN2D-00082T-DX; Wed, 22 May 2019 04:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cam.ac.uk; 
	s=20180806.ppsw;
	h=Sender:Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hWICYit9ZoZqUVLQIM24sehgVFb9onayhJpo81di9Ig=;
	b=blOOxGUBq9moB/M0Ta7X4tt7Ow
	s7vmMf8syFgyozieQsFWIFgWgVk947PHCQCsJV98CHpa36YLpgxJeXcY73mMBoOS8NC5qX47NU41g
	wmlgyqQ0mEWmKa+lM8zEKYRg36eyDf+Gb64+Y/mGTwkOja6S9BOEjNs/Bb1gn7h6uN5U=; 
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from mail-lj1-f178.google.com ([209.85.208.178]:40845)
	by ppsw-30.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:587)
	with esmtpsa (PLAIN:hmka2) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	id 1hTN2A-000oM0-eS (Exim 4.91)
	(return-path <hmka2@hermes.cam.ac.uk>); Wed, 22 May 2019 09:55:38 +0100
Received: by mail-lj1-f178.google.com with SMTP id q62so1323350ljq.7;
	Wed, 22 May 2019 01:55:38 -0700 (PDT)
X-Gm-Message-State: APjAAAUur6NA7LCDqL/Vw7KLgCaQmwsLoGhNhzNa7Sv3BYvSNFF/aZhr
	WzekODY+QZuegYj9OUoGInNjdVTE/lMl0iFb/q8=
X-Google-Smtp-Source: APXvYqxZPGBeAuL9n6AAygEQn7VRf0yIZaxzq2ga5s1VBUMBcHK6qRlEaY0mpyPrsekkPYOSKwkSEXr9gxSZuC65wCQ=
X-Received: by 2002:a2e:91c6:: with SMTP id u6mr26800701ljg.143.1558515338011; 
	Wed, 22 May 2019 01:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190521104324.12835-1-Hesham.Almatary@cl.cam.ac.uk>
	<20190521104324.12835-5-Hesham.Almatary@cl.cam.ac.uk>
	<CAKmqyKOaPEC=YdbwJkqZJBwTw++_9Cum5HSChtfnx7_uOmZ_HQ@mail.gmail.com>
	<CANnJOVG-fqEsRqOu3e8Jd=OanGwi2eEKPK0_AqGcMV28QzVz+g@mail.gmail.com>
In-Reply-To: <CANnJOVG-fqEsRqOu3e8Jd=OanGwi2eEKPK0_AqGcMV28QzVz+g@mail.gmail.com>
From: Hesham Almatary <hesham.almatary@cl.cam.ac.uk>
Date: Wed, 22 May 2019 09:55:01 +0100
X-Gmail-Original-Message-ID: <CA+wsVCAiJ9i4yDooV3ZsAFM87m75Jx-hLbAMupfJdJvP-S-PGg@mail.gmail.com>
Message-ID: <CA+wsVCAiJ9i4yDooV3ZsAFM87m75Jx-hLbAMupfJdJvP-S-PGg@mail.gmail.com>
To: Jonathan Behrens <fintelia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.111.8.130
Subject: Re: [Qemu-devel] [Qemu-riscv] [PATCHv3 5/5] RISC-V: Fix a PMP check
 with the correct access size
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Palmer Dabbelt <palmer@sifive.com>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Alistair Francis <alistair23@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 at 03:25, Jonathan Behrens <fintelia@gmail.com> wrote:
>
> Hesham,
>
> I don't think this is quite right. If I understand correctly, PMP permiss=
ions are only validated on TLB fills, not on all accesses. (Is anyone able =
to confirm this?) If so, this function can't just validate the range of a s=
ingle access and then place the entire page into the TLB. However, the curr=
ent code is also wrong because an access should succeed/fail based on the p=
ermissions only for the range it actually touches even regardless of the pe=
rmissions on the rest of the page. Now that I think about it, I'd also expe=
ct that somewhere in the PMP logic would flush the TLB every time any of th=
e related control registers change though I can't find anywhere that this i=
s happening...
>
I believe the TLB fill function is called on all accesses, but I might
be wrong. I will wait for someone to confirm otherwise.

It's mentioned in the spec that sfence.vma has to be executed after
changing PMP configs, so it's a SW concern (i.e., not QEMU's).

> Sorry to keep raising complaints about this patch set, the interaction be=
tween physical memory protection and paging is very subtle. Even some real =
hardware has had errata related to it!
>
> Jonathan
>
> On Tue, May 21, 2019 at 6:33 PM Alistair Francis <alistair23@gmail.com> w=
rote:
>>
>> On Tue, May 21, 2019 at 3:45 AM Hesham Almatary
>> <Hesham.Almatary@cl.cam.ac.uk> wrote:
>> >
>> > The PMP check should be of the memory access size rather
>> > than TARGET_PAGE_SIZE.
>> >
>> > Signed-off-by: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
>>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>
>> Alistair
>>
>> > ---
>> >  target/riscv/cpu_helper.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> > index d0b0f9cf88..ce1f47e4e3 100644
>> > --- a/target/riscv/cpu_helper.c
>> > +++ b/target/riscv/cpu_helper.c
>> > @@ -410,7 +410,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr addres=
s, int size,
>> >
>> >      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>> >          (ret =3D=3D TRANSLATE_SUCCESS) &&
>> > -        !pmp_hart_has_privs(env, pa, TARGET_PAGE_SIZE, 1 << access_ty=
pe)) {
>> > +        !pmp_hart_has_privs(env, pa, size, 1 << access_type)) {
>> >          ret =3D TRANSLATE_PMP_FAIL;
>> >      }
>> >      if (ret =3D=3D TRANSLATE_PMP_FAIL) {
>> > --
>> > 2.17.1
>> >
>> >
>>

