Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83966C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:27:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826A420878
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 07:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NphNzzSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826A420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSbBn-0006y4-Gt
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 03:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1kSbAy-0006Xp-A7
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:26:20 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1kSbAw-0003JZ-45
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 03:26:19 -0400
Received: by mail-wr1-x443.google.com with SMTP id s9so2470447wro.8
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 00:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=H/rhMEXsULAjAtKfdqdD7nIkvRchkji/v34jCzUdh5s=;
 b=NphNzzSFQP2cYczM88B0OWO+UnpkrE2Lb/XJbTuqrtdDpbr+v5z1ThwZXy6UH7odtX
 WRQ95urPkuVE9bl30W002yTixc16HnneKqBkZ60gOGtAaz7nuJQZC8uD92ZISrPzRAF9
 tsYkcZITDNRNsFJkc9IOaI09yMLOhOoTmY6v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=H/rhMEXsULAjAtKfdqdD7nIkvRchkji/v34jCzUdh5s=;
 b=nVnBQ5oowV/2cp2TuqVEPk9VsoK/9hxCQU21tZZ9HNu4M2nDEBqrnQ0LOI9K0Px4YG
 XWuPC90S8+IcgnAGAPln09fgFkYaaqF5W6CleC/Zdb6FDtwvt1wyvUmrzAXLdcrDXjcA
 czgKEtUhnbrYF4OnVTfMJhwDoga9z4KOx/0ZVIgEPna4IfWyY5UZ1KdynJslj+pVuPkP
 +8N6ANayyRFF6vIUsOpdlKYEk3+2oktDXSsc5ECtdh9xRnXZ4qWZesYKY+azT8sWqUqO
 tg4FXRtJnByd2xXBCNAt/m0nQNq+E8WcthHs58o3l2KnGLrlJi4/x4SyMM2YrYW1Nli1
 EbJA==
X-Gm-Message-State: AOAM5327jQeAS5Aa1Fak5e0EKDan34oN1LRlQq8XH1H+Gp4LjZ1t924m
 kBRNP09stSD5KD9tFNPc411FfA==
X-Google-Smtp-Source: ABdhPJwRAiJmSYqNdf8a/m2Sis7RXSIx1+psxHFE+kp9QOTJr7xdydUmo6EZW2uigN8ERDPMYvcn8w==
X-Received: by 2002:a5d:480b:: with SMTP id l11mr3816321wrq.225.1602660375811; 
 Wed, 14 Oct 2020 00:26:15 -0700 (PDT)
Received: from
 f.7.c.a.0.7.9.b.6.d.5.e.8.7.d.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa
 (f.7.c.a.0.7.9.b.6.d.5.e.8.7.d.7.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:aba:5f3c:7d78:e5d6:b970:ac7f])
 by smtp.gmail.com with ESMTPSA id a81sm2460591wmf.32.2020.10.14.00.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 00:26:15 -0700 (PDT)
Message-ID: <1780b7f17f7638a019a314dc47ec6a38d26d3205.camel@linuxfoundation.org>
Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a
 CPU property
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Richard Henderson <richard.henderson@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org,
 Victor Kamensky <kamensky@cisco.com>
Date: Wed, 14 Oct 2020 08:26:14 +0100
In-Reply-To: <b4818cf4-4598-b7ac-a640-145eaab57f7f@linaro.org>
References: <20201013132535.3599453-1-f4bug@amsat.org>
 <7b059e2f-b868-82b3-3d96-bd4e93d36368@linaro.org>
 <b4818cf4-4598-b7ac-a640-145eaab57f7f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=richard.purdie@linuxfoundation.org;
 helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Henderson <rth@twiddle.net>, Khem Raj <raj.khem@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-10-13 at 19:22 -0700, Richard Henderson wrote:
> On 10/13/20 4:11 PM, Richard Henderson wrote:
> > On 10/13/20 6:25 AM, Philippe Mathieu-Daudé wrote:
> > > Yocto developers have expressed interest in running MIPS32
> > > CPU with custom number of TLB:
> > > https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html
> > > 
> > > Help them by making the number of TLB entries a CPU property,
> > > keeping our set of CPU definitions in sync with real hardware.
> > 
> > You mean keeping the 34kf model within qemu in sync, rather than
> > creating a
> > nonsense model that doesn't exist.
> > 
> > Question: is this cpu parameter useful for anything else?
> > 
> > Because the ideal solution for a CI loop is to use one of the mips
> > cpu models
> > that has the hw page table walker (CP0C3_PW).  Having qemu being
> > able to refill
> > the tlb itself is massively faster.
> > 
> > We do not currently implement a mips cpu that has the PW.  When I
> > downloaded
> 
> Bah, "mips32 cpu".
> 
> We do have the P5600 that does has it, though the code is wrapped up
> in TARGET_MIPS64.  I'll also note that the code could be better
> placed [*]
> 
> > (1) anyone know if the PW incompatible with mips32?
> 
> I've since found a copy of the mips32-pra in the wayback machine and
> have answered this as "no" -- PW is documented for mips32.
> 
> > (2) if not, was there any mips32 hw built with PW
> >     that we could model?
> 
> But I still don't know about this.
> 
> A further question for the Yocto folks: could you make use of a 64-
> bit kernel in testing a 32-bit userspace?

We run testing of 64 bit kernel with 64 bit userspace and 32 bit kernel
with 32 bit userspace, we've tested that for years. I know some of our
users do use 64 bit kernels with 32 bit userspace and we do limited
testing of that for multilib support.

I think we did try testing an R2 setup but found little performance
change and I think it may have been unreliable so we didn't make the
switch. We did move to 34kf relatively recently as that did perform
marginally better and matched qemu's recommendations.

We've also run into a lot of problems with 32 bit mips in general if we
go over 256MB memory since that seems to trigger highmem and hangs
regularly for us. We're working on infrastructure to save out those
hung VMs to help us debug such issues but don't have that yet. Its not
regular enough and we don't have the expertise to debug it properly as
yet unfortunately.

There is a question of how valid a 32 bit kernel is these days,
particularly given the memory issues we seem to run into there with
larger images.

Cheers,

Richard



