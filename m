Return-Path: <SRS0=iAYr=VY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A811BC7618B
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 12:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D6CA2082E
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 12:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6CA2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrLk5-0000CX-Jf
	for qemu-devel@archiver.kernel.org; Sat, 27 Jul 2019 08:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46570)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hrLjv-0008Fa-Vo
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 08:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hrLjt-0006WK-7I
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 08:23:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37713)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hrLjq-0006Tu-EA
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 08:23:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so49705917wme.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jul 2019 05:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UrMXwYLtDwosRUN93psdr7Eb4AO9ycrAb++k6qHD4GM=;
 b=El3BfJvx8qnT+3pe2wgss6+61lZZaTmn3OF/wFY7HB6qTJh2ajFc2aP38OXBnydXG9
 eYHMbWxfPcxdpy8+T/f4dIujRU7MqD5lAMFf6HMfrE2iTFFs5UowmBWeqwtIWqjTEYNd
 F2Raxc7lYqNdDEt3XvRemibwKxgSFu0OPQabTD48zBwnZsSc12XwLtk8hRBrdHxahiQj
 PVQ7pKt2142wUxv07heDvAh9ft3uQZxW7CRlYD2spdQeOYXP68F42mvMl4rCebIPTf0h
 W1Pbt5Yrub5y7BnAlkR6/p7FwYf3h/DF++TUBmrM8CjTasmSs4T5BL5v3mTQGWHAWlH+
 BU8g==
X-Gm-Message-State: APjAAAUJEPZoSDpiZycIQ2ENQM8D7247pLAcsE2DMTqFQbGIf8F0l+jv
 qaPOH6LPtW8kwzoOJRa1zGn/oQ==
X-Google-Smtp-Source: APXvYqzIvzKMmdwwcCiIED6qOxdLTfxLSHCy/f0dJllolVlNbJElFBY/v/IuyJZjnz+NznTNObcN4A==
X-Received: by 2002:a7b:cb08:: with SMTP id u8mr88508889wmj.167.1564230228420; 
 Sat, 27 Jul 2019 05:23:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9036:7130:d6ec:a346?
 ([2001:b07:6468:f312:9036:7130:d6ec:a346])
 by smtp.gmail.com with ESMTPSA id g12sm80433030wrv.9.2019.07.27.05.23.46
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 27 Jul 2019 05:23:47 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
 <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
 <87sgqsx7zp.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0b209125-4277-2836-e27b-a9c13f43f294@redhat.com>
Date: Sat, 27 Jul 2019 14:23:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87sgqsx7zp.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 berrange@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/07/19 09:16, Markus Armbruster wrote:
> We started with a single trace-events.  That wasn't good, so we split it
> up into one per directory.  That isn't good, so what about splitting it
> up into one per source file?  Pass -DTRACE_HEADER='"trace-DIR-FOO.h"
> instead of -DTRACE_HEADER='"trace-DIR.h"' when compiling DIR/FOO.c.

For Make this would all work great, however not for Meson because it
doesn't allow per-file compile flags.

Meson maintainers suggest building a static library for each special set
of compile flags; we could do that automatically per-directory(*) but it
would be harder to scale that to per-file.

(*) Still, I'd rather go on with the forwarding headers and look into
that later, to ease review.

Paolo

> This is admittedly a half-baked idea.  It doesn't address tracepoints in
> headers, yet.  But those headers are rare.  A quick grep finds some
> twenty possibles.  Perhaps we can tolerate manual #include there.
> 
> Since we're discussing half-baked ideas already, let me throw out
> another one: move the tracepoint declarations from trace-events into the
> source files.  No more silly merge conflicts between patches related
> only through a shared trace-events file.
> 
> One more: make the format string optional, default to one containing the
> declared parameter names and the obvious conversion specifications.
> Because format strings like this one
> 
>     visit_start_struct(void *v, const char *name, void *obj, size_t size) "v=%p name=%s obj=%p size=%zu"
> 
> add zero bits of information to the declaration preceding it :)
> 
> [...]
> 


