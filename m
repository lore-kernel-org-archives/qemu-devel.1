Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C67EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C976B20862
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 11:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HrGH2D2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C976B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33726 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlUb-00039m-AD
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 07:02:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTl4y-0006Jd-1P
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTl4w-000126-RV
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:36:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTl4w-00011S-LU
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:36:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id i3so5245523wml.4
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=zL6w8kXp6CZK4DR5DaL+n84SbS1inv0bUdqMtGAXryE=;
	b=HrGH2D2uLMOLB3KiZ7W+DllrHNJxw3Jwr/aqH40AMlCTTa0gcaM6BhVtPKpssD5W4X
	y9NGpfVP+yqYLQuW2L64jDvRYadaUDLI4gZq8/zeSaYvjzlr1k0b1AqvVO2MnsBZKBMt
	549eXazNmJPO48ofuZJy7TSJ+Qbj/mt0wnlkoAv2ph9RwjCV0FoLwxC+kg+j+OGT9VJW
	w7hOASsN9udvxVn57OIjS52oMmsdYiwsSJIdfCSRq1CeuyMkggeOZvWVdqokcYP/XJZm
	QDkzhOkvsnymIpFevpX9/ifAN6U3VZxq5zvn2Fk25+G9ixSxhgoGoFYLiouGos1oUEMq
	eiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=zL6w8kXp6CZK4DR5DaL+n84SbS1inv0bUdqMtGAXryE=;
	b=K9gwXyPPFDE1kDxs9Aea40nujPivVLSYre/Pw3GBJyRa+JjW66nMmzhtGq97EWFxrE
	ADJGXKAlgNpKRFbE+5ZBWdJW0sgP1oFNgmsjT6dAUaDYeL6E3vKWHLIcC5q3DOevoQni
	xKpiwcdVhbqLeVXg86QBOzwocVViuFWbaOgeMJ5RnyrnblZpoKnm4dreQ8TPaCgsRhch
	1icYf9qn7M+0Q5D/XEM7GMfpH4INONqCCbkgZy3g8IB4DXCJWwjEmE4z0vz0bvFjq146
	M2Vh1spZcqISGzvbvWwtk2uXnxgrSCkk8hvWjUY4f23zlCO0qN+4N6P5v4XP4gAAq0X8
	LUSA==
X-Gm-Message-State: APjAAAWWQ8A5wkWCkaEDIgio/2oFuopfdBmBLLaGLYAGFLoJOylRw+Mc
	44yKASwz43lgFTtsKOLSlvKrWUnsC4E=
X-Google-Smtp-Source: APXvYqxHfg0p2sBi7wEOZyduo/lagwmkcUlnEQA4AIBAOrppZEQ66i9Wz6Oc/vGFe1nrr3kGaTlzXQ==
X-Received: by 2002:a05:600c:551:: with SMTP id
	k17mr11018322wmc.35.1558607764492; 
	Thu, 23 May 2019 03:36:04 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	j206sm13393955wma.47.2019.05.23.03.36.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:36:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 3FC841FF87;
	Thu, 23 May 2019 11:36:03 +0100 (BST)
References: <20190521095948.8204-1-arilou@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190521095948.8204-1-arilou@gmail.com>
Date: Thu, 23 May 2019 11:36:03 +0100
Message-ID: <87lfyx1mr0.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v10 00/20] gdbstub: Refactor command
 packets handler
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jon Doron <arilou@gmail.com> writes:

> This patch series refactors the old gdbstub command packets handler
> with a new infrastructure which should ease extending and adding new
> and missing gdb command packets.
>
> version 10 changes:
> - Remove kvm added API as this is not really required and can be
>   accomplished by defining a coprocessor callback with a system
>   specific xml (see: 200bf5b7ffea635079cc05fdfb363372b9544ce7)
> - Remove the new QEMU extended commands to read KVM MSRs
> - Various fixes from Code Review by Alex Bennee
> - Change the QEMU specific command to read physical memory to non-User
> QEMU

You don't seem to have applied an of my Reviewed-by: tags from previous
iterations. It is mentioned in:

  https://wiki.qemu.org/Contribute/SubmitAPatch#Proper_use_of_Reviewed-by:_=
tags_can_aid_review

but admittedly it's a bit buried in a wall of text. Hopefully the
process diagram makes it clearer:

  https://wiki.qemu.org/Contribute/DevelopmentProcess

It's also worth including a list of which patches remain un-reviewed in
your summary cover text. This helps reviewers skip patches that don't
need attention which is important as there are always too many patches
and not enough time...

Could you please re-spin v11 with tags applied to the relevant patches?

>
> version 9 changes:
> - checkpatch fixes
>
> version 8 changes:
> - Add new command to display the Supported qemu generic query/sets
> - kvm: Add API to read/write a MSR
> - Add new commands specific for qemu:
>   * Command to swap the memory GDB sees to be the physical memory
>   * Commands to read and write a MSR
>
> version 7 changes:
> - Fixed few checkpatch complaints
> - Feedback from Alex Bennee
>
> version 4-6 changes:
> - mostly feedback from Richard Henderson
>
> version 3 changes
> - Split the single patch to many individual patches for easier reviewing
>
> version 2 changes
> - Code convention fixes
>
> Jon Doron (20):
>   gdbstub: Add infrastructure to parse cmd packets
>   gdbstub: Implement deatch (D pkt) with new infra
>   gdbstub: Implement thread_alive (T pkt) with new infra
>   gdbstub: Implement continue (c pkt) with new infra
>   gdbstub: Implement continue with signal (C pkt) with new infra
>   gdbstub: Implement set_thread (H pkt) with new infra
>   gdbstub: Implement breakpoint commands (Z/z pkt) with new infra
>   gdbstub: Implement set register (P pkt) with new infra
>   gdbstub: Implement get register (p pkt) with new infra
>   gdbstub: Implement write memory (M pkt) with new infra
>   gdbstub: Implement read memory (m pkt) with new infra
>   gdbstub: Implement write all registers (G pkt) with new infra
>   gdbstub: Implement read all registers (g pkt) with new infra
>   gdbstub: Implement file io (F pkt) with new infra
>   gdbstub: Implement step (s pkt) with new infra
>   gdbstub: Implement v commands with new infra
>   gdbstub: Implement generic set/query (Q/q pkt) with new infra
>   gdbstub: Implement target halted (? pkt) with new infra
>   gdbstub: Clear unused variables in gdb_handle_packet
>   gdbstub: Implement qemu physical memory mode
>
>  gdbstub.c | 1753 ++++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 1262 insertions(+), 491 deletions(-)


--
Alex Benn=C3=A9e

