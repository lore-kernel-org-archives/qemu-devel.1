Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C10C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8453A21783
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 12:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8453A21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho5tM-0007Yb-2e
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 08:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50145)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1ho5tA-00079O-Jr
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ho5t7-0002bq-5N
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:51:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ho5t5-0002Wi-Mv
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 08:51:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so25484409wma.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 05:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+LCMd9JsmOp1iEykBtg3/UrXWVamfKuCv+AuOFcZHao=;
 b=JTFMkzHeZ72oLByHRejjSrUHe75snM645RgoyUX27sgAUvIBsnW3PahixSYOlUpYJU
 vVdJXpwlaYP+tZqob6+7pbTicYoHvhQXffcSC6mJqEgtkRNU26oMDSkfLGft9lQn0lwU
 hkoKVIILSw9TEgd+fx3SvSEi6+Aofw8J6wQAyW+ApcfGHRwV4BVn3IwNqKnsNdosS0YL
 Avagnw68Dh8ohzCQ/DHgb/ZYES1IdBjii/W1FvNYDKGViYRTby8afbNrvtOL30JlxoLs
 v4cvyasTZSwXRMXtbpj8t5Ivsi+Rw2Hnh+pNQ725zHCTI6KX++kz+9dj4v/ralDkxNCi
 04Lg==
X-Gm-Message-State: APjAAAVC3DQ94RVJCNPjpcanXAPGbt7MpRTd5QGc/wHQVm1rvMThK878
 stxZ3fKPP7UT4rCld7CyJqc+sCfAKphs4g==
X-Google-Smtp-Source: APXvYqy+/LxFUXTSXQbGf8QJHkSkPD0NAkUnqgeflA26A9Xx91ST5WGBUT0w5WZcfbe9Ak7VJSBgug==
X-Received: by 2002:a1c:a7ca:: with SMTP id
 q193mr45275184wme.150.1563454309020; 
 Thu, 18 Jul 2019 05:51:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e427:3beb:1110:dda2?
 ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id h16sm26476677wrv.88.2019.07.18.05.51.47
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jul 2019 05:51:48 -0700 (PDT)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20190718120413.27678-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <37c62488-5f8e-0d4f-bb30-eb3a2a79ff96@redhat.com>
Date: Thu, 18 Jul 2019 14:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190718120413.27678-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] build-sys: do no support modules on Windows
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/07/19 14:04, Marc-André Lureau wrote:
> Our module system does not support Windows, because it relies on
> resolving symbols from the main executable.
> 
> If there is enough interest in supporting modules on Windows, we could
> generate an import library for the executable and link with it:
> https://stackoverflow.com/questions/15454968/dll-plugin-that-uses-functions-defined-in-the-main-executable
> 
> However, there is a small chicken egg problem, since the executable
> link and exports extra symbols needed by the library...

Yeah, with Meson it would be possible to do this easily, but for now
let's just drop support for modules on Windows.

Paolo

