Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073CDC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 23:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76F22054F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 23:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76F22054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1humRz-0008Kp-Sm
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 19:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58004)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1humRd-0007sc-AB
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 19:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1humRc-0004BD-Eu
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 19:31:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1humRc-0004B3-9D
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 19:31:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so74543959wme.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 16:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vMyTapgrO8uSvzVs7nPxfGqfQqU7M06WAKfhHrA9mgg=;
 b=SKKntKqN6oJkZhPpuY1sZ+XADL3uaawp/433vBFjZtKiEQiqAIT3UAJudQzxzq6PZS
 9bOfbpxbnwAavr3CAgXs61WErl5Ap3DROShGPmay6fUKk0E+AvvFN0cOE8W90MzWVckz
 1UKewTchtXIP+3M2/He0faSddurIsij+L8kHmcY64nTJLMiNOG6cE+GamE4fRRtiO1rY
 htoIlr+dMmUam6pGAv4qMtmK8PnQwgTsdgvc5XKaEJfBGjKfzfQzoC7K/Cwa14HiR0qk
 UVYEr2uXyJj4xUrsqmkRYKMzGp8imgTxaSU48Ek/s4faZCAekG2+5jNoO46MYFAqcBKG
 QEcA==
X-Gm-Message-State: APjAAAW9xaDWGRGVm6hOubKBW+25keZz9z5vQZgGAUo4iO3nuVbqDhZn
 3EomZM5lhlrLLWYrdNvbE+AU6Q==
X-Google-Smtp-Source: APXvYqzQNNcNvP8x+01jXf8uj/V32Wjxmm2HFQLkFl/HYkNiR75wfMBWmP2vTaDmrroXgPCZHt1T6w==
X-Received: by 2002:a1c:c742:: with SMTP id x63mr556813wmf.0.1565047871224;
 Mon, 05 Aug 2019 16:31:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810?
 ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id v15sm78184557wrt.25.2019.08.05.16.31.09
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 16:31:10 -0700 (PDT)
To: Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190802185830.74648-1-vsementsov@virtuozzo.com>
 <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c262bc6f-1c8b-1c1c-6dec-13572b7ac69b@redhat.com>
Date: Tue, 6 Aug 2019 01:31:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <815da22c-e88e-e813-d342-9ad14191d052@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] util/hbitmap: fix unaligned reset
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
Cc: fam@euphon.net, kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/08/19 23:19, Max Reitz wrote:
> 
> But I don’t know whether this patch is the best way forward still.  I
> think call hbitmap_reset() with unaligned boundaries generally calls for
> trouble, as John has laid out.  If mirror’s do_sync_target_write() is
> the only offender right now, I’d prefer for hbitmap_reset() to assert
> that the boundaries are aligned

I agree (it's not a bug, it's a feature though a nasty one).

Paolo


