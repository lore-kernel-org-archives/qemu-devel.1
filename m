Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8047DC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E6B20881
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYYNDIjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E6B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38270 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpB5-0006Va-LS
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:58:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hToz5-0006i0-48
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hToz4-0008Vy-5s
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:46:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hToz3-0008T2-Ue
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:46:18 -0400
Received: by mail-wr1-x443.google.com with SMTP id s17so6620096wru.3
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=L3KcFDTQF5WPaHX660zSz14Kz4JLN9K++67bPICZ3co=;
	b=sYYNDIjnIEjx65QmDuINLmMJUCK9KAXKFZOrTjwZS2gPl0iKJEsQthPf/GY6AKOBk3
	qgbz0pQdAqME6VsbudfpY5uUaMG6UeqNG2Y9FynOMR4px9K0OsYj+FOk4V+zomESBf0J
	5uleql8FEilcUkeiSy4cRdBSoAAMGqcViOFGHp8Z+r614wHsZDfx9YWXXRrfOHVAfXvs
	V27Dt43HJ0ewZRJSm/1QX2uaD1WDqzGya8bWjKtoRbLDt6KtdQJABKELtZUFg77DD8OE
	MhYg/6G5JbjVRaAwSVN6jtR7qrudyHyVefSdqhbCFQ/Xg2Io4aALKYWMchoVrtcRiWtX
	w/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=L3KcFDTQF5WPaHX660zSz14Kz4JLN9K++67bPICZ3co=;
	b=Ex/wc/AebU3mm5CbCJtRLRUzWrCJKJszkTaZuaOcD+7xDhdkRmHpeIcok8NYBaAFxj
	3zsguwztadAevwuBUNp1/rzc3NQ5xujTajSYOfkrXIq/obn9LpwTyKMNFRUndR515ATm
	rQtXL2qrer6L2nO3W9Hf2dNe6RRH/ZY1WKwxtyD9YuHDJ4jinDQoE0zALy1rj6vzMMop
	T+zGz0kvFdbXzWxB0UqSi3gog0EsBZYc6KXwY+WD5qIAa2fGWbIY3vvTNxNOJt4LxJ7a
	su9BaPfdXC2A201HfrwfjQ/kngQ3371nohGhk/BH4ql1xDzIXaODNoMYIc9yJbOS0SYv
	5CQw==
X-Gm-Message-State: APjAAAWBy5gL0fSaMC+f2P3HCocKJZFruibNlefSzrQD3dYTYvp0xWp7
	Hoo6dqjDxwcgyrAg3X6drpc=
X-Google-Smtp-Source: APXvYqygOVrSv7Hj/9aIkXMQLktqh7fsXPc+rW4Ald0zzKEp1MABjV3Gi1R6pLW20mYlpHMGZrSHpg==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr14035449wru.183.1558622775845; 
	Thu, 23 May 2019 07:46:15 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id l7sm9806690wmf.8.2019.05.23.07.46.14
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:46:15 -0700 (PDT)
To: qemu-devel@nongnu.org, kraxel@redhat.com
References: <20190513115731.17588-1-marcel.apfelbaum@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <49137f7b-16a7-7b3f-7407-7748ed2614ad@gmail.com>
Date: Thu, 23 May 2019 17:46:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513115731.17588-1-marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH V3 0/3] ramfb improvements
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
Cc: alex.williamson@redhat.com, hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/13/19 2:57 PM, Marcel Apfelbaum wrote:
> Please see the description in each patch.
>
> Qiming, thanks for taking the time to upstream your patches!
> Marcel

Hi Gerd,

Are the patches ready or do you have some comments?

Thanks,
Marcel

> V2 - V3:
>   - rebase to latest master
>   - send as new series
>   - use QEMU coding conventions
>   - fixed malformed patches (maybe I didn't import them right)
>
> Hou Qiming (3):
>    hw/display/ramfb: fix guest memory un-mapping
>    hw/display/ramfb: lock guest resolution after it's set
>    hw/display/ramfb: initialize fw-config space with xres/ yres
>
>   hw/display/ramfb-standalone.c | 12 ++++-
>   hw/display/ramfb.c            | 89 ++++++++++++++++++++++++++++-------
>   hw/vfio/display.c             |  4 +-
>   include/hw/display/ramfb.h    |  2 +-
>   stubs/ramfb.c                 |  2 +-
>   5 files changed, 88 insertions(+), 21 deletions(-)
>


