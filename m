Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E14C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D950206C0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aw4i2JJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D950206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7HR-0006L1-F3
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ7BA-00075p-Rz
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:17:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ7B9-0006ku-Vo
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589437031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndL3btAh9b2XfqUTkTM0/7I8FZdP3MzdNFq0LDbDGso=;
 b=aw4i2JJq0oimpSE/Lnx/y/G3UpFXxtyrS0tTCIQJ1SASfJjkgS4oqNSzQwDphETUBC/a+X
 sDCTOTgtEXsE12RDBfkcGYHkPcbC0DFO70ciUpMMT4RSN0+SnLp7g1F9nXXquL8j2FPSCf
 i5XMdm5hCXDNSJhheVhDHqudB4K0WKw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-PvaTtKPrNHmPWVBfZrTSYw-1; Thu, 14 May 2020 02:17:09 -0400
X-MC-Unique: PvaTtKPrNHmPWVBfZrTSYw-1
Received: by mail-wr1-f72.google.com with SMTP id z10so1037338wrs.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 23:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i7xX2Y+XWRrXFmF9QLHD/y5XDy1PHExfY2ut5vy9a34=;
 b=Q0GGwgGwYt+fo+7im71eA0U+vp9wDI6YariL/q+FLr1WkO2YtfgYJOwOjKECBSoxRU
 W7ZiiByGFxQt90XWRl5IqZ3kqCqT8/lPUF9RLWvBF2CTRk9YSMXTJ5xy2E5EMM1FXV7z
 NogUgQ9jGnHQr6zZfOyq7ZLsANpaWEdo/3g+QLE0TW7i2KdYU0p+5GfWMOYJjhaKnPuK
 DKSJ+40NAIUlkveAgwmwFrP1h7A+ST+sOfuJIxHEVd+soaQ2YC88i/bVjiRWtd5RE4W1
 kSxGdOR7qd+b3+ZxJ1NlDKQX7j7MOdWOtcXxaE2Vp0a8kHukJJYKG5A4y85wry4nao64
 etNQ==
X-Gm-Message-State: AGi0PuaqCgaaf3AAyeCIawoUjSrnttIQ9zmNciB0ar/EES41IVdR4KSW
 jv6zsXJdJIvJscX9x369gHvlC/lL2qAVHFzGcreuvGAVul1p37YFFrDolFUe2/eSDnx6RXEn2xx
 a3AZr2nVjBQp/ySs=
X-Received: by 2002:a1c:5944:: with SMTP id n65mr35886627wmb.73.1589437028479; 
 Wed, 13 May 2020 23:17:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypLXLv5zJh4czAVUXKgT6huuBigaZGJvaK2XIgZ9vvlIlOYQRvg9k00YHf9T7IfoheaRv7ZnVg==
X-Received: by 2002:a1c:5944:: with SMTP id n65mr35886606wmb.73.1589437028290; 
 Wed, 13 May 2020 23:17:08 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 32sm2516582wrg.19.2020.05.13.23.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 23:17:07 -0700 (PDT)
Subject: Re: [PATCH v3 03/10] iotests/283: make executable
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-4-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7c53008d-6cd7-0d4f-76e8-83c0ca8ab25e@redhat.com>
Date: Thu, 14 May 2020 08:17:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200421073601.28710-4-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/21/20 9:35 AM, Vladimir Sementsov-Ogievskiy wrote:
> All other test files are executable, except for this one. Fix that.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/283 | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   mode change 100644 => 100755 tests/qemu-iotests/283
> 
> diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
> old mode 100644
> new mode 100755
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


