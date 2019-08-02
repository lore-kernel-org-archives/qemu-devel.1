Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB528C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 850DF2087E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850DF2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htUBQ-0006V5-PI
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57342)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1htUAr-000658-50
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1htUAq-0006d3-Bp
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:48:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33008)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1htUAq-0006bp-5P
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:48:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so1066158wme.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 02:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XzT7wDoHZX9pcaInhYwM1qkOLtyT/ZxrYbYR3hy/Rmo=;
 b=FBixKZsCkOtcK93gKbP1OEibkoWT+r8sHoGtrJsk78rat0qT0u6s9PKWD+LW4ktWL/
 dc8+K0LV10pseH7mG4YrCUeUOqdKqDKsW4zXSv96xrbrx1Q6LV1kOzkupjM1nOscqDlU
 U2P1tjInyvNm9d0TcoAjoNfZ3/67kmxQD6+RnZckc7vEwiqL36bZy6XV8+CBHfklQYqx
 NSvNwU3oIGCKTBpwKnpL7Q0U8gymgO1LS0NHFTkBUIVGnBGPL5lJLiLixmh9yec8ilvD
 qgA85Wlw//6wXkflovzAQN+TfdW/gu0/KQ3yKGoc0HsXZDGWjw0XnI2FcW3kHeLyvWut
 A7aA==
X-Gm-Message-State: APjAAAUcKkz86EBaixRDihFP6czjpyfOR52izRaoihHgI5hgKrhbqID0
 h96wiMd7YIcaFTEs5/zT6mbtKrU8Ffs=
X-Google-Smtp-Source: APXvYqyhitQ7h8BtU3p7LE1QkeFPsGGRT8CFE+jDZKrnpXltzQZ2jlwoaOQycwTXxu9b0QyTvSHIog==
X-Received: by 2002:a1c:a481:: with SMTP id n123mr3494413wme.123.1564739310900; 
 Fri, 02 Aug 2019 02:48:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff?
 ([2001:b07:6468:f312:4013:e920:9388:c3ff])
 by smtp.gmail.com with ESMTPSA id t185sm65985744wma.11.2019.08.02.02.48.30
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 02:48:30 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-28-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <10eeb125-0acd-330a-28f1-50efe82b2fe5@redhat.com>
Date: Fri, 2 Aug 2019 11:48:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726120542.9894-28-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 27/28] sysemu: Move the VMChangeStateEntry
 typedef to qemu/typedefs.h
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

On 26/07/19 14:05, Markus Armbruster wrote:
> +typedef struct VMChangeStateEntry VMChangeStateEntry;
>  typedef struct VMStateDescription VMStateDescription;
>  

This is a bit borderline; I'd rather split sysemu/sysemu.h, e.g. adding
sysemu/runstate.h that would have VMChangeStateEntry functions.  If
there aren't many conflicts, perhaps you can drop this patch?

Paolo

