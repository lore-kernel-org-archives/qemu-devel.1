Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B682CC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED2F20665
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED2F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiJTH-0005Oi-O4
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44228)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hiJRU-0004MD-9j
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hiJRT-0002Wg-9K
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:07:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38991)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hiJRT-0001mH-1k
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:07:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so17992186wrt.6
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 07:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X7oRvEVQxC/q2cj/C8dg0uF+L/oDnWcoFWlJkxuZLkg=;
 b=rjq/A9iWrHEdxlz0PEr+5gUiCtyCSvMv1fIo7Y5dbaIDwS1RSNVO1H/5c/rkeVhTEB
 SYQzx8KEwn4FhfHZqQ/h5qMGwRH6NTgCxSsq85/LcBqeA1NSpxpevWs+BCdHScPKO0kE
 WIsyHrBsadyR2SoNvz56e2oFxFPk1W7A0y9Qz6jNs68ZnM/siaPRzudUD7zLeRHokByD
 Xa3AKxvn0ScbVlk79rBZNS6Jysb1JkgceZ0IvR2YZfxwDipvuepq7cZWVTw598Uo6R9L
 ZInSbInQx6y7cM3SbAXErAVkzYcYk6XItuLGm3lymPjD5p/hbgChp8jXWpM1uq3ipDKN
 waww==
X-Gm-Message-State: APjAAAUuefrprePE9YrfujmQbU1E98N/+KXZ7YOm/EawOPJBF9RzMjt0
 PZA/tdf2SUtfzoxwixVtobBpVKe7l7c=
X-Google-Smtp-Source: APXvYqwiPW0gwNSosriDNI6dMlzHxQimDf3ZIWHWkT3L0NHkUwC9mgQEs04LjNT5UZkrgq21mtsuvw==
X-Received: by 2002:adf:eb49:: with SMTP id u9mr24859243wrn.215.1562076415277; 
 Tue, 02 Jul 2019 07:06:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b8:794:183e:9e2a?
 ([2001:b07:6468:f312:b8:794:183e:9e2a])
 by smtp.gmail.com with ESMTPSA id m9sm13266755wrn.92.2019.07.02.07.06.53
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 07:06:54 -0700 (PDT)
To: Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-5-slp@redhat.com>
 <20190702081733.ff6cboiddln5wmti@sirius.home.kraxel.org>
 <878stgygiu.fsf@redhat.com>
 <20190702101625.trsg5dnnf2a4woqs@sirius.home.kraxel.org>
 <875zokyahg.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c3b4619-f779-fb0c-7a53-b67150036a07@redhat.com>
Date: Tue, 2 Jul 2019 16:06:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <875zokyahg.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386: Introduce the microvm
 machine type
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/07/19 12:52, Sergio Lopez wrote:
> As I said, I'm also in favor of microvm supporting booting from
> firmware in the future, as long we keep the simple mode too.

The simple mode adds code to QEMU's x86 target that only exists to
support microvm.  It should be motivated by a clear win in boot times.

> My main concern about supporting SeaBIOS, in addition to boot times, is
> having to support ACPI, which due to its complexity and size, is a clear
> candidate to be stripped out from a minimalistic QEMU build.

SeaBIOS doesn't need ACPI.  I agree that ACPI should be optional in microvm.

> AFAIK, qboot can't boot a guest without both ACPI and PCI.

It currently needs PCI, but that's a one-line change to avoid panicking.
 ACPI is optional, on the other hand qboot doesn't support mptable so
that can be a problem when ACPI is disabled.

Paolo

