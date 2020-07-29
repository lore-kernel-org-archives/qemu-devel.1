Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316AEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:50:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A0C207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 15:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkBZNYog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A0C207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0oLW-00061n-Rq
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 11:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0oKt-0005Vh-FQ; Wed, 29 Jul 2020 11:49:43 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1k0oKr-0007MY-TT; Wed, 29 Jul 2020 11:49:43 -0400
Received: by mail-pf1-x443.google.com with SMTP id y206so2848789pfb.10;
 Wed, 29 Jul 2020 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=alkne1QAkPGJT9SL9Y1HfBa4utEtpkzRf0249gtABXw=;
 b=VkBZNYognd6JRCHID2txYoqWTia5lOvI/PzZaDgQZCyGLiZDyh/4MxZW7j86x63udW
 c7QuCooGjqUeB52/6W1QmnFIgyBArNnxTW/eYLkHRWxrEjPFRFyhUOCcShwtoPRYJKPu
 esWMjqz3KvNH5UtvEn3oLpsVZvTnudE1B7sdteKhVM4jJ4MUnD38+UtaWek96gwUMhGK
 YCSS6KugK2kohkWMoDV6iV1rPAd8mjhbZK7aVpiT5B13cR3B1FPmWRz4xYK7nPW62MNW
 g8HtAum+W4KK0eaSXfGGaaYy1aQoOLcwR8t9Ybwv0jSpH+3nWfpY9JshMKvR9bnUOKo5
 549A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=alkne1QAkPGJT9SL9Y1HfBa4utEtpkzRf0249gtABXw=;
 b=Yz9HhoyO3obDchA23Voo0vipn1iqqFBt//oUO6XlUTb3TcNI95aIomG33YTeDRWH+T
 HUNip54ZKmylVi61zo6KbeXIX8Y0uLbJlrZYraurIc+JcRMEQluMQtdCX7ZqviYLO+Fo
 BUHV6yRWlKVCegYbRBwwbByM5ZqF3bgn8R0+uPkiJcoeYgYTZHTzdZ6Ra967u8wNwD9w
 HTtBpMlLZl2C70hJO4KA4axOZOEEsnc4TkEBXqc4Hs/eTpab8lNrl37zLCUPRloFXvBY
 VGzIEPWzO4eagVwWBRSyo982JfQ/9HSAFDb8X5lxDnM+H+HHxxDcq8MYchEMGVrAkT2S
 74gA==
X-Gm-Message-State: AOAM5317zMe/xZeuOsmKiUiZ6A4E/cg1qbhZoy6FEgvIAJLJqCGbExtT
 hBPxHFV9/T0qHFJMv6cOdM0=
X-Google-Smtp-Source: ABdhPJyJDz6vCTYf5QOw7Gyr97Ax7Bt6Vm3Pv/QsOnRGt2PuqayoizN4gXB+U92SUC+/tdWBJKcpew==
X-Received: by 2002:a62:8688:: with SMTP id
 x130mr30294445pfd.280.1596037779302; 
 Wed, 29 Jul 2020 08:49:39 -0700 (PDT)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id b18sm2615205pju.10.2020.07.29.08.49.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 29 Jul 2020 08:49:38 -0700 (PDT)
Date: Thu, 30 Jul 2020 00:49:36 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 06/16] hw/block/nvme: pass request along for tracing
Message-ID: <20200729154936.GE14876@localhost.localdomain>
References: <20200720113748.322965-1-its@irrelevant.dk>
 <20200720113748.322965-7-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720113748.322965-7-its@irrelevant.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pf1-x443.google.com
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

On 20-07-20 13:37:38, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Pass along the NvmeRequest in various functions since it is very useful
> for tracing.

One doubt here.
  This patch has put NvmeRequest argument to the nvme_map_prp() to trace
  the request's command id.  But can we just trace the cid before this
  kind of prp mapping, somewhere like nvme_process_sq() level.  Then we
  can figure out the tracing for the prp mapping is from which request.

Tracing for cid is definitely great, but feels like too much cost to
pass argument to trace 'cid' in the middle of the dma mapping stage.

Thanks,

