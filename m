Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44A1C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 11:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFE320721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 11:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShV1Czas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFE320721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipsAn-0005YV-Kw
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 06:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipsA8-00050f-B2
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipsA7-0002Wt-7A
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:09:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40754
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipsA6-0002Sz-Vo
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 06:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578654546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Le9wtY+NLWxTc/wkKiRhQg2HGbwvpYuwrgxSkTIU2dw=;
 b=ShV1CzascUYLJ61jmSsZUDFHEg4EVkuJLlW7D8A3qI5pY7gBVM7NYKfGodbIOg5kRjTVA1
 XBMe+QT3t0aV1UHBJU4LltPVfVytPaNOLHzutrUDgb1vP+AuOGIUrnZ5+NVLcwu9fBpx70
 ueHmIcUjSoZtMjepz59agLaeoUbyiuM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-3pFOLO47NxqwbcIHofPXXA-1; Fri, 10 Jan 2020 06:09:04 -0500
Received: by mail-wr1-f70.google.com with SMTP id z14so752992wrs.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 03:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Le9wtY+NLWxTc/wkKiRhQg2HGbwvpYuwrgxSkTIU2dw=;
 b=lvONBb3tzkrR7d23o9s1vRf5Xl4vU1eWq+l2enJJ2pcXFAJgaZlefI27gCvFJZ5qV1
 5aLuEWX+zMZMgGlqX9bE3wEwrFw24xHz4z3BvsMkRBQBVOaZUNcALlJ4iQZ6nBGzpkZ8
 /FBIE27yqIRMn9rw5rHiDOF1d8ZnBoJV4eIzOxWMUIR/iSmxyqACYBs7oJW5Fm627kir
 q1yEvOFXae8Z1M6YKKGBDokaVpC1nTi1vU+y7I4C8OrHPa3JlfTTsCJK5Y87QgiZEgn1
 hZnKU9UCyR8qcF6C6ZgI0xaN64IcmYLK46FoMuJZ6/2JQldidew7OOB10ePgxhdVopBQ
 64Tg==
X-Gm-Message-State: APjAAAU0JeGP0D+iiv8j5k+wRjpe9wyAXPQvvPx7j1kjZ2Xo78a+aqd9
 qQl5OlyweEmESDNJ13dVb3ryYhcEQaVX851ncpLUXM56c5g6tTKI5qUi9F/1NDddP7n8fXKHBSP
 mm7/3vt70PI2R1DI=
X-Received: by 2002:adf:a746:: with SMTP id e6mr3003616wrd.329.1578654542798; 
 Fri, 10 Jan 2020 03:09:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqx1AknANMypGfuMOhT+vu6vcItuxz9ciFtJpKuwIFoo3lrxi8eMNtEPuQitpV5ANitjZgSXjg==
X-Received: by 2002:adf:a746:: with SMTP id e6mr3003585wrd.329.1578654542536; 
 Fri, 10 Jan 2020 03:09:02 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id n187sm1867629wme.28.2020.01.10.03.09.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2020 03:09:01 -0800 (PST)
Subject: Re: [PATCH v2 0/5] aspeed: extensions and fixes
To: qemu-devel@nongnu.org, clg@kaod.org
References: <157865360186.14299.5035230619156976945@37313f22b938>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4da562d6-6f1b-2892-2941-234072fa543b@redhat.com>
Date: Fri, 10 Jan 2020 12:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157865360186.14299.5035230619156976945@37313f22b938>
Content-Language: en-US
X-MC-Unique: 3pFOLO47NxqwbcIHofPXXA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: andrew@aj.id.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/10/20 11:53 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200110102518.4233-1-clg@kaod.org/
> 
> attempt to add duplicate property 'emmc' to object (type 'ast2600-a0')
> Broken pipe
> /tmp/qemu-test/src/tests/libqtest.c:149: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
> ERROR - too few tests run (expected 6, got 5)
> make: *** [check-qtest-aarch64] Error 1

Yay patchew is back \o/

Happy new year patchew!


