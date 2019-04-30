Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D57C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 08:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92D92080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 08:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92D92080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLOSa-000867-0k
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 04:49:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLORl-0007p3-In
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLORk-0004ga-HM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:49:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLORk-0004gJ-BJ
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:49:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so19982518wrs.11
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 01:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Wh+xCZPvQqMlvtKkyHPdopD1+usawjJTDnEl8HkpSCo=;
	b=OAT+3ZU3wbTsL7lkfDtpI2bkaOAi9mgJPRjDxZ4C2qmmLUM/n4Z+WGcQcwemiYfjEq
	iDNqy9fQX2M8DvEQvVi0Cwozd7wswDShfl1DXlMiC0H2GAoyru+Dg+6xFB9RHLo0jQgo
	CXtEXYa5rOLH3Tm0h6tZU2gOZPVT8WRHBmKHdQjyNzJq6lHEelHk7E3Wycf5rWHLbJCf
	o8DU/R1baccC8gE53Y1bENLZMFZhXsFQgVZQCGXrTHHme7e1uj5sHZFQ4bgFIG6QcC1j
	x64DyLInAoqiHaPNUtY6FT1N6A5BM7eeixgKcTlzEly4gop7P61aIClcu4BtX++EPSXo
	Q9xA==
X-Gm-Message-State: APjAAAX2L5Ozn7INZuNcFeSgSstUTaxQOeSVh29m6eoI4cpPcrjcL/4v
	46ATwW1JW8uSYq5ZLHEE37ZVdQ==
X-Google-Smtp-Source: APXvYqxU3owZ+kDRSludjs628V2BkxDEe3InQs73b2ywcvhIxA9KpPL48HWr0HerJndwrPwm3GT9ew==
X-Received: by 2002:a05:6000:11ce:: with SMTP id
	i14mr15866569wrx.37.1556614143347; 
	Tue, 30 Apr 2019 01:49:03 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	h84sm2194012wmf.15.2019.04.30.01.49.02
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 01:49:02 -0700 (PDT)
To: Jie Wang <wangjie88@huawei.com>, qemu-devel@nongnu.org
References: <1556605773-42019-1-git-send-email-wangjie88@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9bacd55b-4333-28fd-18cb-c0dbd771062c@redhat.com>
Date: Tue, 30 Apr 2019 10:48:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556605773-42019-1-git-send-email-wangjie88@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] vhost: fix incorrect print type
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
Cc: mst@redhat.com, wu.wubin@huawei.com, eric.fangyi@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430084856.nj48FZDX9QE0qOmcOMdTMJQzWhP2Vg_gUv1PcMfRh9U@z>

On 4/30/19 8:29 AM, Jie Wang wrote:
> fix incorrect print type in vhost_virtqueue_stop
> 
> Signed-off-by: Jie Wang <wangjie88@huawei.com>
> ---
>  hw/virtio/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 7f61018f2a..286bb27c65 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1081,7 +1081,7 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
>  
>      r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
>      if (r < 0) {
> -        VHOST_OPS_DEBUG("vhost VQ %d ring restore failed: %d", idx, r);
> +        VHOST_OPS_DEBUG("vhost VQ %u ring restore failed: %d", idx, r);

'idx' is indeed unsigned.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>          /* Connection to the backend is broken, so let's sync internal
>           * last avail idx to the device used idx.
>           */
> 

