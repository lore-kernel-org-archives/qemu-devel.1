Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7835CC468BC
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5481920B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 12:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5481920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49188 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZDfR-0003FM-Hm
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 08:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60680)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hZDKP-0004EJ-Tu
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hZDKN-0007dY-Lc
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:46:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hZDKF-00070V-8h
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 07:46:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so1745746wme.4
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 04:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gnWFjc+G+xpkyU5e2RNt1AZsFiuo9mdL+PpgvRI2di8=;
 b=nqOXs60bMjLxpUTFPYkEp+F71n5Wisv7ur0Xc0KDn6vxS+IRQiskAx6eO7TKZxpkoe
 o7WpYVVkRgK0jJdjH8zuwa4zhI1nsB7CHRvozYo4urqx2HM8BU2x1BvdEoQKPyF+f0Rb
 VU6ioC7bAfnNJv+MVr4wIhgzyjl3tOwBt11n4MkAl3BMak3Iybow8653ey1LxEfvRdoq
 8+6JNidJpFq+cE1CFiKeB+m1PM6dXxYtuATUnCudLWug11W4wjh8o9sZQvABaF2LFqhC
 pL/M6K5nvNtELqhVqhikY5zN1uhL6jrjQc1MNdYyAAeMtUy9IfiVZblM9dJyjX0zOuTy
 ViMQ==
X-Gm-Message-State: APjAAAXJgvyw2yIFs8tiNu4VIzf3zjvN+fU9yi1U5YjoJhAGvEFCc7UB
 db//HTK24VdP1LZCJ3/zCt3MOw==
X-Google-Smtp-Source: APXvYqwyQtQtUyff6zE+6e1icSYEInlI+knM/+5RFsQArL9ncrcBcFrHvK/n2Dg12cbZhvLtL5qXeA==
X-Received: by 2002:a7b:c251:: with SMTP id b17mr2140022wmj.143.1559907972587; 
 Fri, 07 Jun 2019 04:46:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d43d:6da3:9364:a775?
 ([2001:b07:6468:f312:d43d:6da3:9364:a775])
 by smtp.gmail.com with ESMTPSA id z135sm2111872wmc.45.2019.06.07.04.46.11
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 04:46:12 -0700 (PDT)
To: Yury Kotov <yury-kotov@yandex-team.ru>,
 "open list:Overall" <kvm@vger.kernel.org>
References: <20190607090830.18807-1-yury-kotov@yandex-team.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <99896404-c7d9-d2d0-ab01-ab67dcb0348f@redhat.com>
Date: Fri, 7 Jun 2019 13:46:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190607090830.18807-1-yury-kotov@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] kvm-all: Add/update fprintf's for
 kvm_*_ioeventfd_del
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/06/19 11:08, Yury Kotov wrote:
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
>  accel/kvm/kvm-all.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 524c4ddfbd..e4ac3386cb 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -864,8 +864,8 @@ static void kvm_mem_ioeventfd_add(MemoryListener *listener,
>                                 data, true, int128_get64(section->size),
>                                 match_data);
>      if (r < 0) {
> -        fprintf(stderr, "%s: error adding ioeventfd: %s\n",
> -                __func__, strerror(-r));
> +        fprintf(stderr, "%s: error adding ioeventfd: %s (%d)\n",
> +                __func__, strerror(-r), -r);
>          abort();
>      }
>  }
> @@ -882,6 +882,8 @@ static void kvm_mem_ioeventfd_del(MemoryListener *listener,
>                                 data, false, int128_get64(section->size),
>                                 match_data);
>      if (r < 0) {
> +        fprintf(stderr, "%s: error deleting ioeventfd: %s (%d)\n",
> +                __func__, strerror(-r), -r);
>          abort();
>      }
>  }
> @@ -898,8 +900,8 @@ static void kvm_io_ioeventfd_add(MemoryListener *listener,
>                                data, true, int128_get64(section->size),
>                                match_data);
>      if (r < 0) {
> -        fprintf(stderr, "%s: error adding ioeventfd: %s\n",
> -                __func__, strerror(-r));
> +        fprintf(stderr, "%s: error adding ioeventfd: %s (%d)\n",
> +                __func__, strerror(-r), -r);
>          abort();
>      }
>  }
> @@ -917,6 +919,8 @@ static void kvm_io_ioeventfd_del(MemoryListener *listener,
>                                data, false, int128_get64(section->size),
>                                match_data);
>      if (r < 0) {
> +        fprintf(stderr, "%s: error deleting ioeventfd: %s (%d)\n",
> +                __func__, strerror(-r), -r);
>          abort();
>      }
>  }
> 

Queued, thanks.

Paolo

