Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A25C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E676216C8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 11:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E676216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpWMg-0006JJ-OL
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 07:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46799)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hpWMU-0005oc-Le
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hpWMT-0006Ma-9t
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:20:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56211)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hpWMT-0006Kf-3j
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 07:20:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so34737639wmj.5
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 04:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2fpuRPOv5OY1/qk5ermN5cxKvNEgnBgIDfx6cOhzHzI=;
 b=kSzpXYhktm3eo+qIJzbB/ifw1pnHhd7AiFS6nQbeTooLwyYmiCRcL2MnoqqeeiNrIL
 Un9KoG+ic8gDaVHJJ9dJ8KAhXo34I/A2mPZwD5iB2hJlB+MPJrZZMbQEHoGL2hr8rS41
 5gw7ANlWcOt9XbYv1EiaOX5gUFuqRNSDzwQmUV0L6lmFfvoXSYFqy/i6BKkDzBour7ox
 ZF6SenxXCHZgg7NO2TWUsEtspV4WynfFEEYiTSOf0wvmu0ZpNuG1kGQsLNrAZdt3cwx4
 NEiKWKvtDIqGnSlfK5HSzWyM0pb5PpT7pPzHr/bVfVKU9bLb6OYHBCWZNUxfb+V3SJ7U
 eCbQ==
X-Gm-Message-State: APjAAAWhmB7/z8U9zIqLjAUdYrjcXBYKcvhCAG78frPuzWve1SXDKilE
 cU3CBpRBDoWMZ/6ZBcjZdOX5AQ==
X-Google-Smtp-Source: APXvYqy4IhXN5t2mANEO1cHS+OdECWye0BoDSKBaas4L92mfd08QJMrIEy7IdOyEJCg+m3o/ktoWpQ==
X-Received: by 2002:a1c:56d7:: with SMTP id k206mr61536046wmb.56.1563794407944; 
 Mon, 22 Jul 2019 04:20:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id u18sm32290763wmd.19.2019.07.22.04.20.06
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 04:20:07 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20190722053215.20808-1-npiggin@gmail.com>
 <20190722083939.GG25073@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <585a8a2b-6ed2-dd44-bc38-7669f0357528@redhat.com>
Date: Mon, 22 Jul 2019 13:20:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722083939.GG25073@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Series to implement suspend for
 ppc/spapr
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
Cc: Liu Jinsong <jinsong.liu@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Luiz Capitulino <lcapitulino@redhat.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/07/19 10:39, David Gibson wrote:
> On Mon, Jul 22, 2019 at 03:32:12PM +1000, Nicholas Piggin wrote:
>> Hi, this series is rebased on top of the qmp event fix, and takes
>> Paolo's suggestion to implement ->wakeup for i386 before adding
>> ppc, which makes it much nicer.
>>
>> If the first two patches can be agreed on initially and merged, I
>> can take the third patch through the ppc list after that.
> 
> LGTM.  Now, what tree(s) do we merge this through?

I have just spotted a volunteer!

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

>>
>> Thanks,
>> Nick
>>
>> Nicholas Piggin (3):
>>   machine: Add wakeup method to MachineClass
>>   i386: use machine class ->wakeup method
>>   spapr: Implement ibm,suspend-me
>>
>>  hw/i386/pc.c           |  8 ++++++++
>>  hw/ppc/spapr.c         |  7 +++++++
>>  hw/ppc/spapr_rtas.c    | 32 ++++++++++++++++++++++++++++++++
>>  include/hw/boards.h    |  1 +
>>  include/hw/ppc/spapr.h |  3 ++-
>>  vl.c                   | 16 +++++++++++++++-
>>  6 files changed, 65 insertions(+), 2 deletions(-)
>>
> 


