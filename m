Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7B3C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387EE2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYAbdibt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387EE2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXrBi-0003Kz-9H
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 13:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iXr9f-0001w6-ST
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iXr9e-00071q-TW
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:26:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35209
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iXr9e-00071g-QC
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574360770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCnEAv9jvRW7O31uZx//FPCRuayf3VJGyk0xR1sZv2c=;
 b=ZYAbdibtEityFs0XQPKjlmgcrsCpNqQjd9+1M1eopLl1thNqKzXji5y+leERMyGDy5DpwN
 pUm4OgeHbpH0cs/x01L26fX5yoqXjiy/9Jpsmrl6Hbd4iNxsVaW2S/ezZeWyTvMiYV7kMG
 SpVGbf8uK6SkGFpF0BdAWBXqF5tywmQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-z2P-vqDCMdm49SL3wq-8Qw-1; Thu, 21 Nov 2019 13:26:08 -0500
Received: by mail-wr1-f70.google.com with SMTP id 92so2510904wro.14
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 10:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=34oNAQXz/6pxw1PPgOm4m2Kc+OfCObwR1wvooQDwhYQ=;
 b=iMpj1DdweWMACM9eRUzT9WWPiD1YFaY+S4ioRBCms475iBF38bLUYoE5s24esk1ifZ
 LL7geQiTCBTcM4Rlhf/fGl9f7r1xv+WhgJzbcjmoJk789FLHHDeJmQn7l0TamsS8h+ws
 fBfBj4NzR6rvwb5jGtfyhftWBpWRuSiafuSZIV9ghy6FIZUnEmokwdqsT4jzeaGetaJI
 pY8vforgJGGTaUtGGZ1ESBeD3bAdvTZQhlOnEKWDAleijdXpL168FaZib2WtSs2qzCMf
 BCwGujnCN39stiIFbwY52JBulasvT4K+CZLTqKr0G2fKgkoG2VZBk9QavBgN/aPR97Qm
 oizw==
X-Gm-Message-State: APjAAAXJ4si7B42CJ6GVfh2STW7RwXoLG1PzNcPRphGTejRpXG8T0gnN
 AE2F1FCkIA33fqwmTwx+bBjRUxbryy8wJfPAraJuWL9iG/rLW2U1NzU6IAw7bMvapgDyyXCtcYt
 FJqQcFCbHC4faauk=
X-Received: by 2002:a1c:3843:: with SMTP id f64mr11356662wma.129.1574360767735; 
 Thu, 21 Nov 2019 10:26:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqhakbNpvgK2YBQRuwUk3smkblsQtYPTGGFLosjpwkFSYNKeD7tFdAJv1AirRZ7puwuIOe/g==
X-Received: by 2002:a1c:3843:: with SMTP id f64mr11356641wma.129.1574360767534; 
 Thu, 21 Nov 2019 10:26:07 -0800 (PST)
Received: from [192.168.43.238] (92.red-95-127-154.staticip.rima-tde.net.
 [95.127.154.92])
 by smtp.gmail.com with ESMTPSA id p15sm495952wmb.10.2019.11.21.10.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2019 10:26:07 -0800 (PST)
Subject: Re: [PATCH v6] Implement backend program convention command for
 vhost-user-blk
To: Micky Yun Chan <chanmickyyun@gmail.com>, qemu-devel@nongnu.org,
 Micky Yun Chan <michan@redhat.com>
References: <20191121015826.4867-1-michan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <57baef24-3fc2-6e41-8654-e9596dd99c6f@redhat.com>
Date: Thu, 21 Nov 2019 19:26:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121015826.4867-1-michan@redhat.com>
Content-Language: en-US
X-MC-Unique: z2P-vqDCMdm49SL3wq-8Qw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 2:58 AM, Micky Yun Chan wrote:
> From: michan <michan@redhat.com>

FYI your email setup is still incorrect.

> This patch is to add standard commands defined in docs/interop/vhost-user=
.rst
> For vhost-user-* program
>=20
> Signed-off-by: Micky Yun Chan (michiboo) <chanmickyyun@gmail.com>
> ---


