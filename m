Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5528DC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CB8622ADA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB8622ADA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqaDg-0002ov-Ha
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40751)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqaDX-0002Nk-DX
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqaDW-0000NM-Ht
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:39:19 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:37548)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqaDW-0000MQ-Bu
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:39:18 -0400
Received: by mail-wr1-f43.google.com with SMTP id n9so24931660wrr.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 02:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e/fSSycln05y8RSOoBGGbOKlh0Cr9o3/ZCJEn7pN+qU=;
 b=SQ13ZCo/oa6RwC8IVZdgt+Zf4xZqjeCSi010Bj5iMntj/5S0hIQeI788zOYWkltDe/
 dwixBltTr6DW2+ECNk/LWRY5Jt6lpXcsgcK0ZvdvoIMEPTTpTQ3taXPK4p8us08xaffP
 2VKnv9XrIviv0NhaWCWpECCcrCu8PGn8mJRvHgV8TtssAinw8/h2Syxlkoz3ljCMuHld
 YXyktDN55eeYHPm4J/TY3HMhDGmWaysebH0xryCytMDAltaZsggp5YH4yQjMSoyjApbI
 RBjtuzmoWl7FbuQ2rS6ZwARLD3Gl6l+A89w/czX5jO0d50qOWhUvtMW9Jp0lWXmoEyrO
 8P/w==
X-Gm-Message-State: APjAAAX14+OXu/GQELYDKXf0ZlBDU2dBrJsae+Euj/vsdGxlfilPGLnj
 KgpyTVQY+JdSlpzUdlxmYpsjJA==
X-Google-Smtp-Source: APXvYqyMshN35FkVAGA81XAphWrz7jYLVdcZiOd7nl91aRiuVeVn3x+QRJMLRjsRYdAOz4nSE2+CfA==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr10923686wru.27.1564047557369; 
 Thu, 25 Jul 2019 02:39:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee?
 ([2001:b07:6468:f312:cc23:f353:392:d2ee])
 by smtp.gmail.com with ESMTPSA id z6sm43109864wrw.2.2019.07.25.02.39.16
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 02:39:16 -0700 (PDT)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190725032321.12721-1-alxndr@bu.edu>
 <20190725032321.12721-2-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1c7a283e-a471-b939-8622-8465b9bae162@redhat.com>
Date: Thu, 25 Jul 2019 11:39:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725032321.12721-2-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.43
Subject: Re: [Qemu-devel] [RFC 01/19] fuzz: add configure option and linker
 objects
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
 "superirishdonkey@gmail.com" <superirishdonkey@gmail.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/07/19 05:23, Oleinik, Alexander wrote:
> +  QEMU_INCLUDES="-iquote \$(SRC_PATH)/tests $QEMU_INCLUDES"

Instead of this, please include files with the full path.

Paolo

