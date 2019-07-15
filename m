Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD7AC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C174420665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 11:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C174420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmzXP-0008QS-Vi
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 07:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56033)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hmzXF-00082A-1p
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hmzXE-0005ED-02
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:52:49 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:36585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hmzXD-0005Di-PK
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 07:52:47 -0400
Received: by mail-wm1-f54.google.com with SMTP id g67so10776246wme.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 04:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X5Zp1CgD8ClbnMdeRMQXVuyThgUxcd/r3FZac8hfqmk=;
 b=H6prDYO6bgPgyjADkcRYK32STeiSOtQF6ZyL32V+PHOITWqEJZxDXGoJP5Qkph6dEn
 8FScZdiKd10Xq9EmV36j/hpbvpDBTUpa9iONKuLzqEXF49M9UtpT8tnsdUefMioRvgMp
 8TwjUYV2dMx5rF+ZrIdi3p7QaGdUv8FhRjlhHWdf+anIPiPz7wHCEM8AM+UAG1gEC4EY
 /768FCRW4XZ0ovTthiCB17qiLY/4WcayXKo58T7DNZaxd8umyp5VGkS0aWpqyYNar494
 oHC/4/moz0U0vOfbUEPiQuCyj8lnWiXo1FmPI7FpDUFHAQhRAp0ojGHZMYC6AF2bYeIU
 5ZgQ==
X-Gm-Message-State: APjAAAUQIpbeYxoCJdHQDB5w0uQN0TntMtQ21cq0ULRGdQ+5UOJQNvR7
 cgTnL+UOFkp4NYIGphxXLGVV0Q==
X-Google-Smtp-Source: APXvYqyELJOtwz48GtfvEvBSR2coVZgJxPH53lQGs4CP8qvicPpxRjHjwykvJCX44RRUQCxOP65RZg==
X-Received: by 2002:a1c:be05:: with SMTP id o5mr24845573wmf.52.1563191566761; 
 Mon, 15 Jul 2019 04:52:46 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id v124sm21289919wmf.23.2019.07.15.04.52.45
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jul 2019 04:52:46 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190715113939.3256-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d7f33364-33dc-7b95-473d-b8d91b06395c@redhat.com>
Date: Mon, 15 Jul 2019 13:52:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190715113939.3256-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.54
Subject: Re: [Qemu-devel] [PATCH] include: Make headers more self-contained
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/15/19 1:39 PM, Markus Armbruster wrote:
> Back in 2016, we discussed[1] rules for headers, and these were
> generally liked:
> 
> 1. Have a carefully curated header that's included everywhere first.  We
>    got that already thanks to Peter: osdep.h.
> 
> 2. Headers should normally include everything they need beyond osdep.h.
>    If exceptions are needed for some reason, they must be documented in
>    the header.  If all that's needed from a header is typedefs, put
>    those into qemu/typedefs.h instead of including the header.
> 
> 3. Cyclic inclusion is forbidden.
> 
> This patch gets include/ closer to obeying 2.

A step forward using precompiled headers?

https://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html

> 
> It's actually extracted from my "[RFC] Baby steps towards saner
> headers" series[2], which demonstrates a possible path towards
> checking 2 automatically.  It passes the RFC test there.
> 
> [1] Message-ID: <87h9g8j57d.fsf@blackfin.pond.sub.org>
>     https://lists.nongnu.org/archive/html/qemu-devel/2016-03/msg03345.html
> [2] Message-Id: <20190711122827.18970-1-armbru@redhat.com>
>     https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg02715.html
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

