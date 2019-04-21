Return-Path: <SRS0=ydMe=SX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CF3C10F14
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 10:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F8CC20869
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 10:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8CC20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hI9Ug-0001yG-BE
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 06:14:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hI9Tp-0001fr-Ik
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hI9Tn-00045C-Qt
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:13:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hI9Tn-00044D-LP
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 06:13:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id v14so11300984wmf.2
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 03:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Uf7905XRM74/3o2X/vuRLvCGAdnVxSEQ5IZw5utLhsI=;
	b=n0WNKrqQvm2Mgx0S9XsNo9TW1j6cv/Z2UneQJJK35cDBrGUdPK9NTyq8Dvzy20Y2ky
	htijFDAURfpn9ZfspLgOoRIfaU97cKUwOtF448Jvqd4IdBAW8mXLnnn6z1ZJhF0B1lSZ
	YSWxI0iu6pKgwOLRndQ67vGbnki39LvQm77q0ZQNrCfXSgDz7tW/i5i1PC0KjOQNlEQo
	0I1BBaE5BV69GEqZM0linnlbCJmTsp/MEWhV6N3N1rb7UE2NxYe0SyQJiQmSkE3MLczm
	Ehq7FdzqVLM/hgp8naG+lyOiq6CDQICZ86Lhyc9mqBS9yMRPMTrFR9n3LE53Jbqq6ZGw
	az9g==
X-Gm-Message-State: APjAAAXA+pkN1+Gz7UlL8ZaZi4WruE2p3SMtt/So0uqOMdVuxBpQLw8G
	wAueJY0kSiszFaX0MJpF8lt8hw==
X-Google-Smtp-Source: APXvYqzCJOAouuuxRIf5HAG/6k6c5lSmQFIl2dHdd99/QkIEacPlpusXzEAxab5r7mBS98ggeTVeiQ==
X-Received: by 2002:a1c:67c4:: with SMTP id b187mr8349154wmc.148.1555841626177;
	Sun, 21 Apr 2019 03:13:46 -0700 (PDT)
Received: from [192.168.1.25] (atoulouse-656-1-803-163.w86-221.abo.wanadoo.fr.
	[86.221.12.163]) by smtp.gmail.com with ESMTPSA id
	z17sm11361985wmc.7.2019.04.21.03.13.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 21 Apr 2019 03:13:45 -0700 (PDT)
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org
References: <20190420191425.7d1dab82@luklap>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0116ac4a-c9e9-e23e-8002-06d9ef4c6819@redhat.com>
Date: Sun, 21 Apr 2019 12:13:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420191425.7d1dab82@luklap>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2] net/colo-compare.c: Fix a crash in COLO
 Primary.
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190421101344.WLoEe3HVBg7vgRx0IoswURC0eUyCceCwcRj9jvWdZ-A@z>

On 4/20/19 7:14 PM, Lukas Straub wrote:
> From: Lukas Straub <lukasstraub2@web.de>
> Because event_unhandled_count may be accessed concurrently, it needs
> to be protected by taking the lock. However the assert is outside the
> lock, probably causing it to read garbage and aborting Qemu erroneously.
> 
> The Bug only happens when running Qemu in COLO mode.
> 
> This Patch fixes the following bug: https://bugs.launchpad.net/qemu/+bug/1824622
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  net/colo-compare.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index bf10526f05..fcb491121b 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -813,9 +813,8 @@ static void colo_compare_handle_event(void *opaque)
>          break;
>      }
> 
> -    assert(event_unhandled_count > 0);
> -
>      qemu_mutex_lock(&event_mtx);
> +    assert(event_unhandled_count > 0);
>      event_unhandled_count--;
>      qemu_cond_broadcast(&event_complete_cond);
>      qemu_mutex_unlock(&event_mtx);
> --
> 2.20.1
> 
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

