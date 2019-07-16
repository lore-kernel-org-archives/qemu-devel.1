Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D151CC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23E02173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 14:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23E02173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnOOB-0006I9-IV
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 10:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40778)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hnOO1-0005tX-4A
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hnONy-000400-Kp
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:24:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hnONy-0003xp-DA
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 10:24:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so21152410wre.12
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 07:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Su5ymIHZjANx7dP+Xu3TZIJ4pkb9fa/N/UhL+cR/+iA=;
 b=RICqHbYO9DdsSEAf/tYBCXxDvORUavbmlTPwGg3fhC6hWly/QbcNfmW8QEMAz9j7sE
 7TfuGH14ojgAR/hJViWj4eMff72/26eXschN0TbEDeW6tqHo1k05YmLnUo+wI6kzeO6D
 gKYxw7UyPbNQE/Kv80Png4zvCwvZ3vSuEXcZzVCjB41gvUfSEePMDOMqzwvj56ITo44h
 JBsIr5GPufJrH6d/G3qoqKaEsNR0NjMYItz9x3E4zxW7DRrh7bF7FH5o+DbDRqiWpeC1
 JuA+d36HvqomtOFclAcqJW7/240g5FX1SYhaUECNujh2e50cwMU/LDWMyhmIcGRBtggj
 GPNA==
X-Gm-Message-State: APjAAAXvJd5esr96alDcG9twq2L+jqqkwXIzBRT/EgnzL660ynrfVjeA
 6WtMbo/UYW7ASQOsjm+SgoXEUQ==
X-Google-Smtp-Source: APXvYqyRLROz53EB1grQSY399QHeq+KdeGBTVBFFZzc6Ds6vGzwfRN9a8JEJ9SFVyqk1Bs5Kvy7NeQ==
X-Received: by 2002:adf:f646:: with SMTP id x6mr38757512wrp.18.1563287091956; 
 Tue, 16 Jul 2019 07:24:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bca4:e0e3:13b4:ec4?
 ([2001:b07:6468:f312:bca4:e0e3:13b4:ec4])
 by smtp.gmail.com with ESMTPSA id a81sm19777040wmh.3.2019.07.16.07.24.51
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 07:24:51 -0700 (PDT)
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
References: <1562959033-223586-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <b270d0cc-2a28-8a60-ccac-45ac4de89f02@redhat.com>
 <a55d4518-734e-9dd1-296f-473600eacbf7@redhat.com>
 <5832b3c6-c014-eef2-50bb-f25d70d65678@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ac5aefc4-b1e4-9465-c3f0-88f180f6fa14@redhat.com>
Date: Tue, 16 Jul 2019 16:24:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5832b3c6-c014-eef2-50bb-f25d70d65678@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] chardev: race condition with
 tcp_chr_disconnect
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
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/07/19 15:08, Andrey Shinkevich wrote:
> The test check-qtest-x86_64: tests/qos-test hangs with the 
> QTEST_VHOST_USER_FIXME set even without applying the series:

Hmm it must have bitrot. :((  I hope I can look at it on Thursday.

Paolo

