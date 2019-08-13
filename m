Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FCCC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 08:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9703720665
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 08:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9703720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxRis-0004k1-V8
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 04:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38844)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hxRiS-0004Jg-AG
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hxRiR-0006gR-Dm
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:59:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33516)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hxRiR-0006fo-7o
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 03:59:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id p77so484583wme.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 00:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=akAHzqWy1Z7/dwDVGqYFJ7UxVb8I/ELdUBqG7h3GEXY=;
 b=qaoXpBS701tuDzxINgzQsZXxBGTFtGMgmFw1pvfHRBH3y7LqCn+m9ZMJTZ+A0Vj6DX
 ey+RjD1b5tbjwzgdZfDXpoPJ0iWvpE+qoL9gi581oOlr0rkBk/FjlS32ueJ/7omRQ/NV
 ReGBRarwt6idZUZ9QJP0MxLBKVkcKCnex2uLv+JaO+yGGRS7U8darOJbTiExYptKOlV8
 A0pV+4S9NMBWqvLnDgmrNp0cVuGWlVgcY2upK4cI1QUhEVDAK+jzK8ll/tDcjseigdEe
 lvKCzuY3aLhwGxA7y77GrRneSd3Df/JGZ6RJ+0mVXm5fPbGswB87LtQr6LOqnu0PBsgn
 +4/Q==
X-Gm-Message-State: APjAAAWxPgSFzjHGZ1X/RNIXdV4cAHutGdASyxITSTWGCXsLhj3s4hV+
 22hiAnzRJd3lWOHN7YU4Oo6RJg==
X-Google-Smtp-Source: APXvYqzxSUSqGVg/EFnY9TU4akPz0UccoqMTUT5dobZFbr01jNd6YUHWduAevepmk6uB5mW2ayjm8A==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr1585208wmi.137.1565683174237; 
 Tue, 13 Aug 2019 00:59:34 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id 2sm699147wmz.16.2019.08.13.00.59.33
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 00:59:33 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org
References: <20190812234630.22814-1-ehabkost@redhat.com>
 <09e610b6-8082-3434-71b0-b34c09abe295@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <11a6cde3-0e17-cce2-34f8-0ce55fe3f1cf@redhat.com>
Date: Tue, 13 Aug 2019 09:59:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <09e610b6-8082-3434-71b0-b34c09abe295@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2] HACKING: Document 'struct' keyword usage
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/08/19 08:44, Thomas Huth wrote:
> Maybe s/Each struct/Each global struct/ ? Or "non-local" or something
> similar? Sometimes, you also define a struct just within a function, and
> in that case we don't require the typedef, do we?

I changed it to "each named struct" and queued.

Thanks,

Paolo

