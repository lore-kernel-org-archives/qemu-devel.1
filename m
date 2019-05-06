Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67724C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 11:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E0552087F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 11:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0552087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54493 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNbZO-0001RB-I5
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 07:14:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNbYd-00018D-Bm
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNbYc-00037K-Co
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:13:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37711)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNbYc-00036x-6G
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:13:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id a12so6598736wrn.4
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 04:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=RW8i59NStbOsWgXni6u2XAoJDy5vWGTW0dHFn9A576I=;
	b=LawbrrXMtbcmF/yMwi9FwYfRlp+DU05Z0ghZUrTpE0NbQrOH5GVQ0nbtKzV/GrUJbz
	S+49RC1Eu+pJrVBcZ5dOS/R+TT9+NkiP4mfshxMnnSHYEjsoUKQg/mMVK1oWlD+bI3Sf
	Uh5ry2VmWmkE8gWJkITqVacX1fugAf2l5sL8yao3HU2/JBSzE4+LwBm/HMsO0Q0CCZ8d
	N9xhmb3itxL0MoTcAGP0CTB8e6nK28A++I8wag40ByMwKJq6pxGR3lo91BU9dd9M+hRv
	G4TxKDash1pulxSmiOfJ0nnOZHwW0WTGlzhTeyxDVgdoNp21v8EJLoFNn0tLynXF7SPh
	Ri/Q==
X-Gm-Message-State: APjAAAU5gyxwKcKKVqVc198NYw6erAbbM+RP0H09fOXKc+mbNYXc06gx
	wbjcVeDh2++fcT49AWS1v0s6hw==
X-Google-Smtp-Source: APXvYqzKqOkreCi1zoM/DECa2BYpmNeYlVMmXkm7PdUORGW7wu0/mUmVlmYgWuzlV3gtece1hWGgLw==
X-Received: by 2002:adf:e288:: with SMTP id v8mr16905694wri.7.1557141197237;
	Mon, 06 May 2019 04:13:17 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id j3sm9001192wrg.72.2019.05.06.04.13.16
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 04:13:16 -0700 (PDT)
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20190420191425.7d1dab82@luklap>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <612f07b7-7090-8934-ce58-0a65785e9d64@redhat.com>
Date: Mon, 6 May 2019 13:13:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420191425.7d1dab82@luklap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
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

Cc'ing Paolo & Stefan

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

