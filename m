Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1C8C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5A62133F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 16:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5A62133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgXEh-0004x6-9E
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 12:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42159)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hgWpt-00045X-An
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hgWps-0001xz-BT
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:01:21 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:51602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hgWpr-0001uE-PG
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 12:01:20 -0400
Received: by mail-wm1-f43.google.com with SMTP id 207so6263115wma.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 09:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lzdWi605UX5uzoK2lZEBsspC7vCvsZ9u2EmgI+QRriI=;
 b=O6jibhRZYl3TaDjEkD/WHuAowtzSf2x7QimnF7eAUOA+XPIChDv2oXvcBOWahbqCCW
 0VeXx1cSW0WBEpNehpOsg07pWjVNHltQj4NlCGfFC7VgCimPbY+zoWe9xIlgrZmdAiKe
 tLOcsHsModWsfH13UiA+pmrs1O61VPxRoxLyHiHeznG8yRke+aOvjb9gO5KybiJK+8HS
 Z8Eck/uFs4Bhtwzh0t4RC8NjawQMjG8SeSss7dRltJN3awzqgdpgzkxqONPUmOkS38h8
 5NkkfN+qEoOoTd5CxnHDlUXzjtLQ9+coaYWZW6KVo+P0UhleIhJSOSQCjI6NcrHy08wX
 YF8w==
X-Gm-Message-State: APjAAAUWJibzAVeg/QjLKhTE0VN2VS7L+oXlI2eWQ/rQvyovshR/CRoH
 mj0+iaZssvfmJI4ATzPveAYiGQ==
X-Google-Smtp-Source: APXvYqwYYio+44l1bSKnRTr7qUSJ7+xZpL3F99GgiokHmBqkn5/+Il7ueG3ucDpibmIBpKDPcr7gDA==
X-Received: by 2002:a1c:1d83:: with SMTP id d125mr3700662wmd.63.1561651274748; 
 Thu, 27 Jun 2019 09:01:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d4d:4830:bcdf:9bf9?
 ([2001:b07:6468:f312:5d4d:4830:bcdf:9bf9])
 by smtp.gmail.com with ESMTPSA id j17sm1803018wrw.6.2019.06.27.09.01.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 09:01:14 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87tvcbc9ul.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <655a1ac0-bbd9-9798-4e44-478f94afb86f@redhat.com>
Date: Thu, 27 Jun 2019 18:01:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <87tvcbc9ul.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.43
Subject: Re: [Qemu-devel] Should configure --enable-debug add -Og to CFLAGS?
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/06/19 17:43, Markus Armbruster wrote:
> The fine manual advises:
> 
> '-O0'
>      Reduce compilation time and make debugging produce the expected
>      results.  This is the default.
> [...]
> '-Og'
>      Optimize debugging experience.  '-Og' should be the optimization
>      level of choice for the standard edit-compile-debug cycle, offering
>      a reasonable level of optimization while maintaining fast
>      compilation and a good debugging experience.  It is a better choice
>      than '-O0' for producing debuggable code because some compiler
>      passes that collect debug information are disabled at '-O0'.
> 
> Our configure --enable-debug effectively picks -O0.  Should it pick -Og
> instead?
> 

    commit 48e56d503e18bd1e8a75463fd7cc1580bf7e7650
    Author: Paolo Bonzini <pbonzini@redhat.com>
    Date:   Tue Mar 6 11:32:44 2018 +0100

    Revert "build-sys: compile with -Og or -O1 when --enable-debug"

    This reverts commit 906548689e37ab6cca1e93b3f8d9327a4e17e8af.
    Even with -Og, the debug experience is noticeably worse
    because gdb shows a lot more "<optimised out>" variables and
    function arguments.

    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

:(

Paolo

