Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87526C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574CF20872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:23:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574CF20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDwmI-0003dW-FW
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 16:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDwlN-0002kr-Qr
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 16:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDwlM-0000mu-Sq
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 16:22:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38682)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDwlM-0000mk-MF
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 16:22:48 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BACDF85A03
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 20:22:47 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id l6so1602911wrn.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 13:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HpWQUH+bZpFVQAathDrFNRBGbgJ/OKk/HwVBcDJZV3Y=;
 b=RXthhRICv01qZNzvWxu/YD7TJkgh0TjuqtQJIXA2BWUXjBGa5xY+2NTmuAEpcsX4PK
 Q49WSJaEzbTEWra89EW8rj6Hupq7hFWs7CjHWqso74IADQl6jRO3nAUioEkPfSglHyYA
 dJlbJRdvqdYdt9YNdz0gyB3KEfpB5eEgUODzb0lU7/xvsipcWPFlZpN/Svm2CMzxxoY9
 hMjLMJYNSorye1US+KB8lGSpcH1z8OG0WFqsqYZpmXaCSdGUbku2Boc6Eg4GpNRQ/Hdp
 mny/AKbrFllUI/c7H4m19x/1bDgQeEH/9RamvvQXrfZ1D9TLOw2K0jXpr27joPizh5q5
 916A==
X-Gm-Message-State: APjAAAUzx2qacFaMw4aaX5FPLq/PVYkw/XX2qwIiLcL8nQ0WI0tplpn6
 yPksTQV7GSp9NRphKuGR9gxyXpVLSZ1yp5D0N78+0pCDSnGQdbLFLBBwjq9bqKFT6UEwQMk7D43
 +cHzVtq+gR7QURfw=
X-Received: by 2002:a5d:6ace:: with SMTP id u14mr4615009wrw.385.1569615766408; 
 Fri, 27 Sep 2019 13:22:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwkdGlCcHBXXmZg6D7LanB6aSTUDgMp8/vvcujJ0wwRU2P32V6fwgBbo1ZF++jz6bg4B7lZ5g==
X-Received: by 2002:a5d:6ace:: with SMTP id u14mr4614992wrw.385.1569615766165; 
 Fri, 27 Sep 2019 13:22:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id z189sm17892522wmc.25.2019.09.27.13.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2019 13:22:45 -0700 (PDT)
Subject: Re: [PATCH RESEND v4 1/2] x86/cpu: Add support for
 UMONITOR/UMWAIT/TPAUSE
To: Tao Xu <tao3.xu@intel.com>, rth@twiddle.net, ehabkost@redhat.com,
 mtosatti@redhat.com
References: <20190918072329.1911-1-tao3.xu@intel.com>
 <20190918072329.1911-2-tao3.xu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a1156a86-3ec3-da72-306b-1fafa0c369d7@redhat.com>
Date: Fri, 27 Sep 2019 22:22:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918072329.1911-2-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: jingqi.liu@intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/19 09:23, Tao Xu wrote:
> +    } else if (function == 7 && index == 0 && reg == R_ECX) {
> +        if (enable_cpu_pm) {
> +            ret |= CPUID_7_0_ECX_WAITPKG;
> +        }

This should be the opposite; remove the bit if enable_cpu_pm is not set.

Paolo

