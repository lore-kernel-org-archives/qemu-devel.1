Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D479C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619882064A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 13:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619882064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsSEE-0002ek-Hr
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 09:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48609)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hsSDf-0001nj-DW
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hsSDe-0003Rv-FZ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:31:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38553)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hsSDe-0003Rf-9k
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 09:31:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id s15so35308040wmj.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 06:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y/AtV0RL5OKVXzo2L+TD1gAq1Xuc7QQ8LWw8JV2gNLg=;
 b=NdfNDn2xTihstHo5PF3RSuz3SLAMKaJNJr17DpZ7PL3RKAkM9PB4JgCiZsVoyZJN68
 b2RT9ea7YiNOwDjSOEM/f3NPfSfTD4Ty5UoIrWI9m8HQLUxOINlSl60b+JKd9Ni8hBr9
 urAlDtcsbPJDoOwYHsowntTNssj3Ehq/x+wHcctpMu/MGm5OfH+kVN0PA3AGUexVnMG8
 I4qzQhXsvW2/nwYKfHqJ8Ij/ba26ouySyjOy2T58chrfTE5wTM0NP3mKUYRh1yPpA28N
 SerFOjadYZVk8EdT8DzI8x+O1ERa3CGntR0Ko+ydNz5fFCyHg+aPRjcVT5rKKTQC+O/P
 Wjag==
X-Gm-Message-State: APjAAAWM4Q6HLJTDyQ7Hl5Nod6h3IHQ50ChBkV8RZflOmntYckzmS9+X
 fZ7C8CqQQ2E7NPUKnU60YlQ+Kg==
X-Google-Smtp-Source: APXvYqw4WvBo1lNwbhcz7Pcy939aHRPW88m9QS+GGsSkWeD/iT2NkR1mBcX/SxpQEubR5/FxPBmV8A==
X-Received: by 2002:a1c:cfc3:: with SMTP id
 f186mr98957702wmg.134.1564493469104; 
 Tue, 30 Jul 2019 06:31:09 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c30sm122594561wrb.15.2019.07.30.06.31.08
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Jul 2019 06:31:08 -0700 (PDT)
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-24-armbru@redhat.com>
 <20190729194414.GG4313@habkost.net> <87d0hreqh3.fsf_-_@dusky.pond.sub.org>
 <8bea0201-f796-d682-22e6-069985b45523@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0eb2518f-147c-2b47-f48c-3af26bf5d264@redhat.com>
Date: Tue, 30 Jul 2019 15:28:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8bea0201-f796-d682-22e6-069985b45523@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] When to use qemu/typedefs.h (was: [PATCH 23/28]
 numa: Don't include hw/boards.h into sysemu/numa.h)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/07/19 15:15, Eric Blake wrote:
>> We occasionally give up and use types directly rather than their typedef
>> names, flouting the coding style.  This patch does.  Trades messing with
>> qemu/typedefs.h for having to write 'struct' a few times.

I think Markus made the right call here.  Using "struct Foo;" in headers
is a null price to pay if all you need is declaring a pointer-typed
field or parameter.  Of course this doesn't apply if you have to embed a
struct directly, but then qemu/typedefs.h wouldn't help either.

In general unless you're adding a new subsystem, qemu/typedefs.h should
only decrease in size, never increase.  (And there are certainly many
cases where typedefs.h are not needed, but cleaning that up is
understandably not high on the todo list).

Paolo

