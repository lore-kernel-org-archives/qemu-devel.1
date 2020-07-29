Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AC7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:08:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4050020809
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hmw20eGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4050020809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0odR-00082w-EC
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 12:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0ob5-00054k-Nm; Wed, 29 Jul 2020 12:06:27 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0ob3-0001Qk-RF; Wed, 29 Jul 2020 12:06:27 -0400
Received: by mail-pg1-x542.google.com with SMTP id e8so14462220pgc.5;
 Wed, 29 Jul 2020 09:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3cbkbn0l+Xu0Erc68nuJEb4bSTrEz6kipYsTaY+cCFc=;
 b=Hmw20eGUBQM5s2iiAesNbjeIn83dTdBX4G6sxMZIk5bqjR86EqLiBzCVhYkUzenQC9
 BrS1uHPRyF9f3TdgK1mWeJPnp3W1rtOOG1CfWHe48oO5nPOE4MywtFjSdsZGTUOy4vIv
 4FUrJc6ePjOvvC+ctvf9OrEA6IseP/tt6Omw02MX7lfO3/iugd7gHH24yMDak48gxlol
 lhAvB/2X/pTvJgQP3d1qPamX0rPDrG1t6mOzJ8bFCpOJq5+LPJ9WF6AQde1/5ClNxjL8
 Zr+1v7kojvFdEYp2dOfAgFPy7qzX5o8JF052bTFcxevjyE2HVzxmgLJXxMqCWR1dnhlT
 eXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3cbkbn0l+Xu0Erc68nuJEb4bSTrEz6kipYsTaY+cCFc=;
 b=t2vX9Esor8kCrulTtsp6TQp7YLPMXDj6UGW7Z+yTg0SKkdxF+aar2gnW07VW3/M3xB
 HusaOUMqMSeeXI5hVf6LruAblkVprEXi+S9icT8K67SBOSwn+FxvL0V6sbQsFEMfnTnA
 ml2YUEtFBrZglZcsPuzKgMLYWd6RJeIU/hWpkrS0D8UA6GkBnUVK8f2ADS4xQUX86pMp
 x04Q5EKLUOa9cjaECV+TforcGBQm02ZRAfsy+ayqe0Rm6SCwkXssOktrlrHYhFGcI0G6
 FZs8X/zc6wu0n2Djg82omlQzb4yhnHoz8bAV+kmgtELMk/sUV+KLaF0tUFsgswNUWqpw
 lQ5A==
X-Gm-Message-State: AOAM532kEikaULtMu179V0/5oYKNNKE7dtZvyRBdldt3LcklEnUZvb9D
 2XH/a0zeKgU8YclMLCDT5/k=
X-Google-Smtp-Source: ABdhPJz7V+Sv2utjWQSheztYSMWNzp5kgZFA4fAJoIYw65GhMUjMU02REGfqX4/S66m0kuis/rXwrA==
X-Received: by 2002:a62:aa05:: with SMTP id e5mr4190532pff.70.1596038783580;
 Wed, 29 Jul 2020 09:06:23 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id h131sm2830911pfe.138.2020.07.29.09.06.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Jul 2020 09:06:23 -0700 (PDT)
Date: Thu, 30 Jul 2020 01:06:21 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 13/16] hw/block/nvme: add a namespace reference in
 NvmeRequest
Message-ID: <20200729160621.GL14876@localhost.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-14-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720113748.322965-14-its@irrelevant.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pg1-x542.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20-07-20 13:37:45, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Instead of passing around the NvmeNamespace, add it as a member in the
> NvmeRequest structure.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

