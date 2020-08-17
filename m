Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D216BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10E420658
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 08:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNembst3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10E420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7aSo-0000Ua-PJ
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 04:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1k7aS3-0008OI-4f
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:25:07 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <coiby.xu@gmail.com>)
 id 1k7aS1-0001vO-Kx
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 04:25:06 -0400
Received: by mail-pl1-x644.google.com with SMTP id f5so7128171plr.9
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=O7Cy2f0Y8dqZa5yXCEcEX03myZxCJDyEOYrphfHHSRo=;
 b=KNembst3jXK0Ye1PNeX4ca+tD0nu5nIJ6flAN1RXMCjjnJphPrETj7G2np1czCEuCh
 qpKgNiYaKgguanqJeVvDh60jTWjfR+ELhhQHGsC0mpx56pG30SnE44P222iWvmdGS7zo
 39F5lSaE6OACfDggCygDHzs10eHIO3bLjOGyWQRousL3Qf5SiWT7qEl8Af6LpJvUCc9u
 1vR382J6A77O/FbiJ4rmy9H2ZQ1a2+AHGCs4uDjtPOhMO5daDrHrYpV3zSX2sjg+5IZM
 kSltLYT2skjEp6VjOm4vjOfSLPHbvnVoBDILBQLsA3tdUTwz2WcoS4TsY9vBWPUw2g7e
 riSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O7Cy2f0Y8dqZa5yXCEcEX03myZxCJDyEOYrphfHHSRo=;
 b=MbpHYpxo3RgSYRhKGicb0KyfCssxAboFViLqEeCNSG3RYMD1hWZVGKJyQVP3qMtsr0
 ZdYIser7+ZHgWWuHoi3LY4xFQOJoyWwJG3hmWVLKoxn1e71AWyNpPXwaGWxyAPKQNq3P
 xARLgG///GGRB2d8H+uhSIfQjaRVFqGONsMUweHH8971SL24KfOqAePKuyGbFNEQNJ2i
 bT3G5J+xVmrNplBXLEmDqBD+5Rtffg3xy8dj9es0mWWb3ge3NtB1jyY7PlfB64m01lEK
 2k3xiWv2TLvdeQZ2RTO47fWB1Ly1WDhbLekNJwHduqQfEvlokJIsghlc8QDgm36OWcIb
 aOvw==
X-Gm-Message-State: AOAM530jKpxwjwNlVUDRp8PQ+WsqadKgAyWshGzplt99uNrwGecRj9/f
 XRtzeywU+JHEZ8Yh4O2N4Ts=
X-Google-Smtp-Source: ABdhPJyb0X4egcafuBiUOCii+nHEDtF+6rwbcHTF4o8SnARUri4pXZBLJpG94q/3rTtxp/IdBLGlxA==
X-Received: by 2002:a17:90a:4709:: with SMTP id
 h9mr11308383pjg.235.1597652704123; 
 Mon, 17 Aug 2020 01:25:04 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id mp1sm17411539pjb.27.2020.08.17.01.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:25:03 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Mon, 17 Aug 2020 16:24:53 +0800
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v9 2/5] generic vhost user server
Message-ID: <20200817082453.2kd6l6bwy5yld7iu@Rk>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <20200614183907.514282-3-coiby.xu@gmail.com>
 <20200619121300.GB2422025@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200619121300.GB2422025@stefanha-x1.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=coiby.xu@gmail.com; helo=mail-pl1-x644.google.com
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 19, 2020 at 01:13:00PM +0100, Stefan Hajnoczi wrote:
>On Mon, Jun 15, 2020 at 02:39:04AM +0800, Coiby Xu wrote:
>> +/*
>> + * a wrapper for vu_kick_cb
>> + *
>> + * since aio_dispatch can only pass one user data pointer to the
>> + * callback function, pack VuDev and pvt into a struct. Then unpack it
>> + * and pass them to vu_kick_cb
>> + */
>> +static void kick_handler(void *opaque)
>> +{
>> +    KickInfo *kick_info = opaque;
>> +    kick_info->cb(kick_info->vu_dev, 0, (void *) kick_info->index);
>
>Where is kick_info->index assigned? It appears to be NULL in all cases.
>
>> +}
>> +
>> +
>> +static void
>> +set_watch(VuDev *vu_dev, int fd, int vu_evt,
>> +          vu_watch_cb cb, void *pvt)
>> +{
>> +
>> +    VuServer *server = container_of(vu_dev, VuServer, vu_dev);
>> +    g_assert(vu_dev);
>> +    g_assert(fd >= 0);
>> +    long index = (intptr_t) pvt;
>
>The meaning of the pvt argument is not defined in the library interface.
>set_watch() callbacks shouldn't interpret pvt.
>
>You could modify libvhost-user to explicitly pass the virtqueue index
>(or -1 if the fd is not associated with a virtqueue), but it's nice to
>avoid libvhost-user API changes so that existing libvhost-user
>applications don't require modifications.
>
>What I would do here is to change the ->kick_info[] data struct. How
>about a linked list of VuFdWatch objects? That way the code can handle
>any number of fd watches and doesn't make assumptions about virtqueues.
>set_watch() is a generic fd monitoring interface and doesn't need to be
>tied to virtqueues.

A linked list of VuFdWatch objects has been adopted in v10. Thank you!

--
Best regards,
Coiby

