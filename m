Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1A0C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:53:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5A02064A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5A02064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htUFz-00013Z-93
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58161)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1htUFd-0000dU-BF
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1htUFc-0001pM-Fk
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:53:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52393)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1htUFc-0001oz-8P
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:53:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so67302669wms.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 02:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MzInnSIT87V803bDWPXVwNqb70Z/eWP1kr9qKY+n29M=;
 b=gM9XgdseTjqoluoLAJcnmPuLhFmF7412DUs2CjfrhdOkmOM4OIZXBqJAmta8iuy1Eg
 8USxNWOWIWE35aPjALafbS3N3MPjJ1kTzO7C8RNkXa77nWbYDDFrYe4llzrKCHoX0kXb
 TBlc8IaxngDCffD0kID3p2knLE6dTJhYzMdek1qRcVwajGX8thuwxpVt2LJ3DFo0DOOr
 lutUfakKc3mGesDXKTS/4YfrBsghbhYU4cz2lzuPiyhjRr9PuoG6Alr6L/vs3j+F9E5G
 ZRRx6Nc7Levw5IS7cqnnHTfgN8qoqMTsQ/jEpveR9cvOwpw4MglL5vbYUJP5l3hk49Sj
 Prag==
X-Gm-Message-State: APjAAAWO/37cNcyTKh3vjf9Y/19BVeqprjYtDMXKF8j/UOtw6h0C6p7D
 HY69VdfIBKZvo7s2TTDWzQPtrQ==
X-Google-Smtp-Source: APXvYqwAWnZB9u2eTY0FPg4aggqWNXyWM7MhEHfmNQrOIeHhJD3pwQ4QTMWhI4zOfqRNlVd2g4PKZg==
X-Received: by 2002:a05:600c:303:: with SMTP id
 q3mr3882652wmd.130.1564739607172; 
 Fri, 02 Aug 2019 02:53:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff?
 ([2001:b07:6468:f312:4013:e920:9388:c3ff])
 by smtp.gmail.com with ESMTPSA id s10sm58630480wrt.49.2019.08.02.02.53.26
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 02:53:26 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-25-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <487183bd-5437-af05-4a6e-73543570d2c6@redhat.com>
Date: Fri, 2 Aug 2019 11:53:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726120542.9894-25-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 24/28] Include sysemu/hostmem.h less
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
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/07/19 14:05, Markus Armbruster wrote:
> Move the HostMemoryBackend typedef from sysemu/hostmem.h to
> qemu/typedefs.h.  This renders a few inclusions of sysemu/hostmem.h
> superflouous; drop them.

I think this can also qualify for qemu/typedefs.h, even though this
patch is also into diminishing returns (sysemu/hostmem.h is only
included in a dozen files).

Paolo

