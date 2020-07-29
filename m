Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:07:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05AFC20809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrAK7UTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AFC20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0obr-0005qQ-9k
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0oW6-0005yu-MF; Wed, 29 Jul 2020 12:01:18 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:38249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0oW4-0000of-Oo; Wed, 29 Jul 2020 12:01:18 -0400
Received: by mail-pj1-x1029.google.com with SMTP id e22so2237760pjt.3;
 Wed, 29 Jul 2020 09:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eQ1OxP1lKc8SGWwbI3pM/V5EqsHqjkegymqwk7prfEw=;
 b=BrAK7UTlgN90IrLfom3FPWuTUCmE/gXNIrb0tRyWdptbVh6lxdwwwV3b+auMoOGcFT
 XRfMkYWaEiZ7BUL0j+yAQ/D8fnuwV0hDcQCWsCQ+iPdEFi+tYuhKh8CCKrHFPjCnOBuA
 VktsHUVZsAF4KSzXFXNeKsjuqVz+KwN9MImX8GO74RLL12T3WreB6Kx/iQf6tkPHtOjn
 IR30pFSi2JMl8E09GBe11qdaeSz2nyL+GOauPtCWRWA8ZfmmfsUmCwPpnufYnpvLF/Qw
 aifzG7OBcnP7OCJJ98pjv6v/3UM3HAXlkCUfAcrmcSC2pa7mwowejoCXePXVzfK7wJ93
 ZsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eQ1OxP1lKc8SGWwbI3pM/V5EqsHqjkegymqwk7prfEw=;
 b=KbGvnZ5ySuprwgx3HQgldfMV/m57l0n8gRlEVtw8u0ineT2zf/Y6ZVWdG3gKhsufpu
 crDP/VrpNVEC80SQQInhmu2YdDixbabsmQTQOxDzOJ94N0vUNdMVedowNvtx3AfVv7on
 UUqi4zwSLOoKNlTlQtndacgOWfjIZXp871ipOD7ohGPkUp4MUHwwM02IYNO3vU78dQqZ
 GuKMNCvatPHjD2KfJm7rODWhTKuj3yMofEV9fn10KUt7RkateiSHT88h2CNW0WLH+XnC
 QxphQuoPNCooNnsM7tgDe0lyUB7unVETXfXAejFPXMNUOkaH7Pf7b5qF4J1IL1+t4xkR
 UAkA==
X-Gm-Message-State: AOAM530T5AiGIKsfeow0SWlqvW/LNh4uyrh8xPj3qeBWjn25WPs6Onlz
 GOJWVPj5JbNUg0TGMHqr+b4=
X-Google-Smtp-Source: ABdhPJwc36ovBMiUwDfwDVUVGbN37arx8mLLW5kO/7hf8mNJWN2j7H5Xu6CwPsi5f63UY4RJ7f+L+Q==
X-Received: by 2002:a17:90b:84:: with SMTP id
 bb4mr2302932pjb.115.1596038474466; 
 Wed, 29 Jul 2020 09:01:14 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id lx16sm2863349pjb.1.2020.07.29.09.01.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Jul 2020 09:01:13 -0700 (PDT)
Date: Thu, 30 Jul 2020 01:01:12 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 11/16] hw/block/nvme: be consistent about zeros vs zeroes
Message-ID: <20200729160112.GJ14876@localhost.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-12-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720113748.322965-12-its@irrelevant.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pj1-x1029.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

Thanks,

