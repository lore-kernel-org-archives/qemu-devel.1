Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F56EC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BDF72067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUx8gmC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BDF72067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7iaO-0005Sd-G1
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 13:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7iZQ-0004eG-WE
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 13:05:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47673
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k7iZO-0002Qt-UC
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 13:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597683914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nB31e+RD39iOAda0ORqrujpp5aeaEg2oxZY2poWoQI=;
 b=MUx8gmC/KmlFC2YugKIBjw6OY9iJNgcvVFSJdVGQpxK9EdbTClviWgO7AaA8KV0RPXCrye
 ap/lJVie9FcWdPn7rc9dJ4+kwuRA6FZpcjD5/qQ9dK+wnB0xHd+TIFReaBeqsR6QkxR0CG
 NsJi5Vhp9agBpW55YtfXjPIC+4GQSAE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-yeR2132hO0SuZnbJpVgaSg-1; Mon, 17 Aug 2020 13:05:12 -0400
X-MC-Unique: yeR2132hO0SuZnbJpVgaSg-1
Received: by mail-wm1-f69.google.com with SMTP id s4so4949651wmh.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 10:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8nB31e+RD39iOAda0ORqrujpp5aeaEg2oxZY2poWoQI=;
 b=CxpAdDgJUQ5f3RE7KQWucT/dCebxBFH8PVV/KtRWGFxCQMUYXRxPNI7qi6W0nWBv4N
 /PvD7/G10tBvgYankUC5KNJs2oyhas/I6ZX90FeS/exZKGnZoAssimwALj8At9gzQv1s
 5HPWfV/0pfygB2yX/c2+DKb/fYvF/Ek4rAVYXg0oFKII6XSlIIhLGO8kxwu6DAe+5K2G
 WKwFEbs0iTds8YbgzP2sPORz+bYUKd+ic5rUBJ2WeLV7cEdVSWr0uRv2YF7wKgjZFWir
 UiUNknkiu7qoX7x5CChgSCK8b76ay181/im9SMZFE79aSVHjidsij+42ZNo+jpnZYVIr
 P5OA==
X-Gm-Message-State: AOAM533jlb8uHoU1jF4nuozlz3lndA4BjiYjlv8wSCratW62p2J3GIRJ
 aEk8NjN112u9ZhUbyZNA4OyOjdtHJCz71d4Fc12L0hnJSb34e+M3GHSZLaHr/MQSwam1zwDf9gr
 nWOPAJHIJmMMB8qs=
X-Received: by 2002:a1c:de88:: with SMTP id v130mr14864667wmg.98.1597683908331; 
 Mon, 17 Aug 2020 10:05:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0330blJcD2VOGhiXy3nXlPNgMIA2BqxEtZhoo+hanXmeNOv6pOZRfzhbQbBRYSncpZrc5CQ==
X-Received: by 2002:a1c:de88:: with SMTP id v130mr14864647wmg.98.1597683908034; 
 Mon, 17 Aug 2020 10:05:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0d1:fc42:c610:f977?
 ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id g188sm32738931wma.5.2020.08.17.10.05.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 10:05:07 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix the assert failure in scsi_dma_complete
To: Li Qiang <liq3ea@163.com>, hare@suse.com, fam@euphon.net
References: <20200815141940.44025-1-liq3ea@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <83092d06-25e3-abf8-67b2-8b9bcfb00732@redhat.com>
Date: Mon, 17 Aug 2020 19:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200815141940.44025-1-liq3ea@163.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 03:34:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/08/20 16:19, Li Qiang wrote:
> Currently in 'megasas_map_sgl' when 'iov_count=0' will just return
> success however the 'cmd' doens't contain any iov. This will cause
> the assert in 'scsi_dma_complete' failed. This is because in
> 'dma_blk_cb' the 'dbs->sg_cur_index == dbs->sg->nsg' will be true
> and just call 'dma_complete'. However now there is no aiocb returned.
> 
> This is the LP#1878263:
> 
> -->https://bugs.launchpad.net/qemu/+bug/1878263
> 
> To solve this we will consider the 'iov_count=0' is an error.
> In the first patch, I uses -1 to indicate an error and in the second
> patch I consider 'iov_count=0' is an error.
> 
> Li Qiang (2):
>   hw: megasas: return -1 when 'megasas_map_sgl' fails
>   hw: megasas: consider 'iov_count=0' is an error in megasas_map_sgl
> 
>  hw/scsi/megasas.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Queued, thanks.  But do you have a qtest for this?

Paolo


