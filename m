Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3AEC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB68020880
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB68020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htUAI-0005TH-0v
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57192)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1htU9d-000528-V5
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1htU9d-0005PS-2w
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:47:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1htU9c-0005PE-So
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:47:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so76510050wrm.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 02:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eOHfF/rCXX8j3COEy4gUW6GLuCIIdeidIgLhcd/eoX8=;
 b=gtEBSq/yj0VrFxx6kTXpDO9ZSrLY3+ZLfo0xnTJ26xoLQv6SKoa3sVoD7l6vWwVPgd
 gjtTNyxQepJYxcYWcDyUku8Xv4fxQXRJG+XjZqeqUuszdSuE4ShoQPIbN6HWKrJmCLfs
 Tm1KGSZRIX4FoeTp5F+5CdGi7n4fsICb97yIHm6PsxF8SnNEgz7e7rOHUO/cbeO0fCX7
 GTam4qldEsjXzfUWMdL0HQyCWecnCEJDsFsW37KnHkrwvU1DL3Rr82kc7qGdXcwuurXk
 FrPyghfpLtw2wzuIgClAGaq/vuDzUqeQtEaw/w1HjPsH/fBQFneVFu0cUPLtvA4EKSzO
 +Kfg==
X-Gm-Message-State: APjAAAVyCBmfdACkTlVslS+2NucLFahFGBZPWv8JNbApo3n20DQDG1of
 2nb1hdaXvBAMr832Zt9zb+w6RAFmGLo=
X-Google-Smtp-Source: APXvYqzkTlvRwR56If4+2dX5tttQ4iO+xfkhkr9D3YB177w9ELRZclb1M0UYC1o6tFR/N+9GEL+h/g==
X-Received: by 2002:adf:b195:: with SMTP id q21mr2462133wra.2.1564739235535;
 Fri, 02 Aug 2019 02:47:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff?
 ([2001:b07:6468:f312:4013:e920:9388:c3ff])
 by smtp.gmail.com with ESMTPSA id s10sm90455911wmf.8.2019.08.02.02.47.14
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 02:47:14 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-15-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e375113c-8cf2-6f82-3fe2-618bb306d14b@redhat.com>
Date: Fri, 2 Aug 2019 11:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726120542.9894-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 14/28] migration: Move the
 VMStateDescription typedef to typedefs.h
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
>  typedef struct VMStateInfo VMStateInfo;
> -typedef struct VMStateDescription VMStateDescription;
>  typedef struct VMStateField VMStateField;

This certainly qualifies for typedefs.h.

Paolo

