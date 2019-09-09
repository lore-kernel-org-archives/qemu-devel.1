Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABD9C433EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 11:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E789218AF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 11:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E789218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7HtC-0001a9-33
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 07:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i7HrN-0000se-Fy
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 07:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i7HrK-0007hI-Qb
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 07:29:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52076)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i7HrK-0007cf-5W
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 07:29:26 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A65F4E92A
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 11:29:21 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id c1so7217969wrb.12
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 04:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1Ndg4r+d/ul0vwNmoBY0KZL+l0AaB0ZI6lse0qZamss=;
 b=sA5HRdqwOv7zsyXsXTm6TnCvhnnox9DP80i4RkDhq5/G8cjWWMOjbxdZ4GkOM2ibs/
 bLx2fm+XAxZBO0Ymx7jaWJhnOwB1NfRe6ESYD3wSH6wuLFBFGy8FSOQDrmYpQeVKx1gO
 s3HDUitwQm32+RotRlrJxbMpvcAzyZ8rWSf2ulNuY/1TGyNXTRlHM6wxT5rkrh7DsGx9
 E1on7jorE1GgOU1kazxiIvx84zAprc7GbEgQlqmnSKjy1AM4vN77Ybzo0zEtkMAQ69x1
 pFBV1mFpxshTNeWfZunYqQSvd9Zv8jh+lZgx+2cYrGeNc99yc6GFTRlRkTz4bSgDMmHD
 FrOA==
X-Gm-Message-State: APjAAAViBHB3nzthkZx5TVayBsVUO5lMQdvghyPQ6hE2AouR/dsBBhw3
 dL6J7i2ZrITXC+OzGeWKFfGTKyQmIH7Fd40ObEQui4jw+rGHgluMDP0qUrtF6TpAGE0V5nx3NAW
 yJ/uRinUwM9h7GQg=
X-Received: by 2002:a1c:be02:: with SMTP id o2mr17380309wmf.109.1568028560133; 
 Mon, 09 Sep 2019 04:29:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyyygCFr8/Uuw6MTgvTn40Eb+YhR+Ns21fqQvzJz2vw4iapEecLqlGfAnWQLnPNoNzSNeb6Mw==
X-Received: by 2002:a1c:be02:: with SMTP id o2mr17380290wmf.109.1568028559903; 
 Mon, 09 Sep 2019 04:29:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8dc1:ce1e:4b83:3ab7?
 ([2001:b07:6468:f312:8dc1:ce1e:4b83:3ab7])
 by smtp.gmail.com with ESMTPSA id n8sm18812405wma.7.2019.09.09.04.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 04:29:19 -0700 (PDT)
To: Yury Kotov <yury-kotov@yandex-team.ru>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>
References: <20190909104948.30253-1-yury-kotov@yandex-team.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <08fe56ae-7f8c-2223-f3cd-4b4b118586bf@redhat.com>
Date: Mon, 9 Sep 2019 13:29:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909104948.30253-1-yury-kotov@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 0/3] High downtime with 95+ throttle pct
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
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/19 12:49, Yury Kotov wrote:
> Hi,
> 
> V6:
> * Fix "Add qemu_cond_timedwait" patch:
>   - Changed return type for qemu_cond_timedwait (void -> bool)
>   - Added details in commit message
> 
> V5:
> * Updated sleep loop in throttle_thread at the suggestion of Paolo Bonzini
> * Fixed hanging of test
> 
> V4:
> * The test was simplified to prevent false fails.
> 
> V3:
> * Rebase fixes (migrate_set_parameter -> migrate_set_parameter_int)
> 
> V2:
> * Added a test
> * Fixed qemu_cond_timedwait for qsp
> 
> I wrote a test for migration auto converge and found out a strange thing:
> 1. Enable auto converge
> 2. Set max-bandwidth 1Gb/s
> 3. Set downtime-limit 1ms
> 4. Run standard test (just writes a byte per page)
> 5. Wait for converge
> 6. It's converged with 99% throttle percentage
> 7. The result downtime was about 300-600ms   <<<<
> 
> It's much higher than expected 1ms. I figured out that cpu_throttle_thread()
> function sleeps for 100ms+ for high throttle percentage (>=95%) in VCPU thread.
> And it sleeps even after a cpu kick.
> 
> Fixed it by using timedwait for ms part of sleep.
> E.g timedwait(halt_cond, 1ms) + usleep(500).

Queued, thanks.

Paolo

