Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E74C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1218C21E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1218C21E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvIzX-0006mB-6K
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41481)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hvIzA-0006N7-AL
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hvIz9-0004mc-6c
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:16:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hvIz9-0004lc-0D
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:15:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id g67so75297497wme.1
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=euNNRkXkE1KOD9VEjf8DFNwKddWw9gZD+3DnL5m7pdY=;
 b=nakzMiMjZI4N/pv48zUS+NeTPbA6k9+cJOdGVyzcJ/Wcqj2YV8E9kEDO/NfLiO7uoJ
 QsKxD+n9v3sODy5BYSkkWWHsyrHSXGEUdMdC2d/Xnt+oxac8MX5N3tsLRtM4niIV/voV
 rPBK3R+X/7aB3GhqoQJ3BJ3ijMNxbf5wXcx48eLGYV9ZfmNove+PrHhVuyBDiAaqGuwW
 6VmVPMxsNb3GnGwjdEuGNqC+gsNMslhHEBNuS+AZEOJg6ZrkMbIl6s65JMMecwSu0FoS
 yneEjTr6NH3iMasL29T3lFNL9l8b5kOBU6Lve2p2pmp+n2T0PiqfJr4tZgQwEZJEKaLR
 o/ig==
X-Gm-Message-State: APjAAAWcMQGGtbRo4X0dce9+a8jDaUPR+lv6GGlOWj1P2Hzn2vuDnxNN
 ii1MxHN9TNsI/43MzChqGM2DBrgrTok=
X-Google-Smtp-Source: APXvYqzaSAQwEEDh/3q3W/f949S2YSdveA3FeqvdSs1hhsVQLHLgbq6JFFNKaaLtVg5ekzqtxLt/8g==
X-Received: by 2002:a1c:ac81:: with SMTP id
 v123mr10140662wme.145.1565172957637; 
 Wed, 07 Aug 2019 03:15:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810?
 ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id o3sm79645107wrs.59.2019.08.07.03.15.56
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 03:15:57 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-30-armbru@redhat.com>
 <87o911bnaj.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bb9d837e-d087-f638-82a6-5295a323af34@redhat.com>
Date: Wed, 7 Aug 2019 12:15:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87o911bnaj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 29/29] sysemu: Split sysemu/runstate.h
 off sysemu/sysemu.h
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/19 06:40, Markus Armbruster wrote:
> Paolo, should I add include/sysemu/runstate.h to MAINTAINERS section
> "Main loop"?

Sure, thanks.

Paolo


