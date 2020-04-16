Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C39C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 07:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF6D2076A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 07:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuXPXekg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF6D2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOzLz-0006n4-Pd
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 03:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jOzLI-00068p-9K
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 03:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jOzLG-0006SV-OT
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 03:53:47 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jOzLF-0006Qy-IY; Thu, 16 Apr 2020 03:53:46 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a32so1009423pje.5;
 Thu, 16 Apr 2020 00:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=dUFIerRziQ9hK9uxxbOwfR4QtyqVRP1DvtgmdpUisHA=;
 b=GuXPXekg8ytd8ZGnlf+jP5ZIkhernIeVrq70gpQVtXC++oWhjedcaP8jI+3BXgfrPM
 PIwnrnFtGWFLPAU0itjRSldgXU9SNCSMvouRHjK1sS2xHs+29r7nAzoMbDF+9HFldvPu
 aEPXKlaM3txxTscu44vxhBXvFOnmFPM0FynBHHsv0zRNeNHlgc+LL48g2sp1pXONyAAr
 CvDojGIbRKe5niZVrkwiK9VUt6hAZ5KOdWhjOzC/qzbzXIWj2oPt1yM9BLAL9XRLZa1o
 s5dKAiW7i1j0/R4fujz/LPbvnDwZS9cuLNXdLxxJTRR2vxOsejcqMCmmTDeCMElStBNO
 7lXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=dUFIerRziQ9hK9uxxbOwfR4QtyqVRP1DvtgmdpUisHA=;
 b=k8X7EUbUVdBBfNTMrRrpfdqDJqtEy5jgZEknKWBCchwIbabFtLE5kIMEKwpBcgqiUB
 PIZ7xZkfbgT/QZ/N29z8qgcNKopBTFiLcn9WLPvDxUgBmnZhYkNOZbEqunNVd7UNoBbF
 d61o5KKwSC7R6KsUtCDG5R6GRKIqX8VHIPZAb+0NIMI2bVSW+LK62BHs0k1M4ZBzncvy
 c+EifYmrlXDSCq/p+4qnHY4RmOL3YeQG3W4Cx34mc9a987mEKnicK9wul2iAJXIfkx44
 b8uDcV8KGxD2GP0FiJ31oBQEXx01R1UFDz/By80epvyeLIQkgXxSMiPxZHfgvbiqwKZY
 7jzg==
X-Gm-Message-State: AGi0PuYMKh9ezr7J2u1P/7Q5PXUI189tm8RMTRDvt0swSz6FvUXYJTem
 Dnn+kOf+wy9FapSf78LeREY=
X-Google-Smtp-Source: APiQypJoEIIxKF6uR53iceESDIvJGlh7a52I8MJ/coXBXDPhxkbp/kZ6jFV+ODlsb/9BaYM+or1E+A==
X-Received: by 2002:a17:90a:d3d1:: with SMTP id
 d17mr3546955pjw.191.1587023623081; 
 Thu, 16 Apr 2020 00:53:43 -0700 (PDT)
Received: from localhost ([203.18.28.220])
 by smtp.gmail.com with ESMTPSA id j5sm1744030pjb.36.2020.04.16.00.53.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 00:53:42 -0700 (PDT)
Date: Thu, 16 Apr 2020 17:53:02 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [EXTERNAL] [PATCH] target/ppc: Fix mtmsr(d) L=1 variant that
 loses interrupts
To: =?iso-8859-1?q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
References: <20200414111131.465560-1-npiggin@gmail.com>
 <74e47708-fcc0-d3db-5f6b-2a513722fef9@kaod.org>
In-Reply-To: <74e47708-fcc0-d3db-5f6b-2a513722fef9@kaod.org>
MIME-Version: 1.0
Message-Id: <1587022632.z6w1kmmsze.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: qemu-stable@nongnu.org, qemu-ppc@nongnu.org,
 Nathan Chancellor <natechancellor@gmail.com>,
 Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Excerpts from C=C3=A9dric Le Goater's message of April 15, 2020 4:49 pm:
> On 4/14/20 1:11 PM, Nicholas Piggin wrote:
>>=20
>> The confusion arises from L=3D0 being "context synchronizing" whereas L=
=3D1
>> is "execution synchronizing", which is a weaker semantic. However this
>> is not a relaxation of the requirement that these exceptions cause
>> interrupts when MSR[EE]=3D1 (e.g., when mtmsr executes to completion as
>> TCG is doing here), rather it specifies how a pipelined processor can
>> have multiple instructions in flight where one may influence how another
>> behaves.
>=20
> I was expecting more changes but this looks fine.=20

It _seems_ to just be these, from what I could see, but could quite=20
easily be other issues I missed.

There is at least one other "funny" thing with this synchronization,=20
which is the TLB flushing. I don't think it has a bug, but comments
are a bit suspect. tlbie/l doesn't have anything to do with context
/ execution synchronization, so it's a bit interesting to check them
in isync and rfi etc.

ptesync is required because the page table walkers are not necessarily=20
coherent with the main CPU's memory pipeline, so you store a new value=20
to a PTE then do a tlbiel, you can't have the MMU reload the TLB with=20
the old PTE because the store was sitting in the store queue that=20
doesn't forward to the table walker. This condition can persist after
the store instruction itself has completed so no amount of this
context synchronization would help.

It does kind of make sense to check the tlb flush in rfi, so you catch=20
stray ones that didn't have the right ptesync/tlbsync, but it would=20
almost be a condition you could catch and add a warn for. isync doesn't
make a lot of sense though, as far as I can see.

Thanks,
Nick

> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Sorry I always get your email wrong, phantom address book entry.


