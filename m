Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81083C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A179207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOWwBO4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A179207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0o7b-0005x8-Go
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 11:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0o6m-0005OR-5b; Wed, 29 Jul 2020 11:35:08 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0o6j-0004oZ-8o; Wed, 29 Jul 2020 11:35:07 -0400
Received: by mail-pg1-x543.google.com with SMTP id z5so14441029pgb.6;
 Wed, 29 Jul 2020 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UndLJA+bsTQk/7o1QfsguOHpsH32f45bHWx1+3IN6a8=;
 b=eOWwBO4etz8y/3YJHKMaYr67RT8+itkVlHZ6SwZuW/0gNovP1cwa9e7Iazr63KGL0d
 RfZiJTRiLzObTk+f0Mau3/Vp7vrcUkWQxYPsgtOBkhf6lMHHKZVjJcpMxWzqwIvXo50T
 YRou5cSnXFBny1ltfIcXwFjd9RilreXlvTtCgds7W+ZItB9NMcXuRkSLlRv/T41PIIC1
 eGoauDyBuC8A+ojrqID9q77AH8oAU770JaRolCOPusaQoQqzOXvxalQVPOxr8BZMpUOk
 oxKtl3I9ebjsEkeUMpP1afs2GUjWtGyBCx405yf7UE7C+fbftt2hHqQ82ASfhYtE5pov
 F0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UndLJA+bsTQk/7o1QfsguOHpsH32f45bHWx1+3IN6a8=;
 b=iVnlEoKXzjmfwIoftHIq9eT5cuW9kv16n54dxR+YmltVM+RjcQoI54vguddRYhz8qG
 1MVpyEJTdRf6utT2q+Huq5EHSrvqTWYhtxPf+/HHx7lfSI2Nyza0krhbc6ayx+KEplC9
 bZjy1uOO21tsd6HcBJl/Cyosgs6GpLQak/hjH3Yys43Y4ftLCk4ddhaj1YWd2Q9rum0l
 Cl3lvzQCwiJIIuC7CWj/nG4Ho7rPdhCPp8KKW1DiowODD7gIpezmp7Af6+JF48juNoel
 nVTRnnNY11y4f3buFnRLNeuR5nFzRhWhL97h9F3gBtDwy+mOnsPKH8R4AxiJxDFw08w4
 mAnA==
X-Gm-Message-State: AOAM533d6QdNDq2s1JKbmYKkVhUq6nRezgDvPsA7E3zA03EWVucppH+9
 NbhPEjK+/8wq4geV3pTIrJo=
X-Google-Smtp-Source: ABdhPJxLuyiAMSid8zL/k30Yic8keh7HufSB+YG5zB9n9a0P3zF1KUMqT1HmWhCw8EAvBn7yAwfsTg==
X-Received: by 2002:aa7:9813:: with SMTP id e19mr15503362pfl.285.1596036903079; 
 Wed, 29 Jul 2020 08:35:03 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id j13sm2870598pfa.149.2020.07.29.08.35.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Jul 2020 08:35:02 -0700 (PDT)
Date: Thu, 30 Jul 2020 00:35:00 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 05/16] hw/block/nvme: refactor dma read/write
Message-ID: <20200729153500.GD14876@localhost.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-6-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720113748.322965-6-its@irrelevant.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pg1-x543.google.com
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
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Klaus,

On 20-07-20 13:37:37, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Refactor the nvme_dma_{read,write}_prp functions into a common function
> taking a DMADirection parameter.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

Thanks,

