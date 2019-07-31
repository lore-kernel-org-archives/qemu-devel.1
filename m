Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BF7C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF73A206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 15:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF73A206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsqzP-00020K-7p
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 11:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37190)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsqwo-0007hL-TS
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsqwn-0003Pl-Sm
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:55:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35514)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsqwm-0003Od-IQ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 11:55:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so70273350wrm.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 08:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Uth9qsTfua0g93Td8NIKxyaZHAfndLwCy26ZoGyTNNg=;
 b=Fzo9bayrLQmtfsByGzEKqtyu77dKl9i6cxjjOLezkwRHMQWh55ZJGGZmHJXoA8yues
 0mMaiMQZ51/83EUNrIeGo9YNDSMka6Jv8dC0Su4fDbtThiQ8O7ui8fkPVXUPYM8kr7C5
 ssQhOnMEinc0sDuMp/BCq6PhDTfS17p5fRC+pBXPrZjO1O2O0QZtcZxPDYhmInaK+V49
 lUjAjDFbWKANoVPh5k0Zbx70MXYM8WVvMhbW/QDjHJgYaPSGaRoHD2dg0EHYo+H/Eum2
 5a1oT2Zv47+ifXq10yi1wEGdNK0rAyBQDIDds0aYJL/IJXcXIblfXjh1bVl73/vb1o5k
 +ALw==
X-Gm-Message-State: APjAAAUCluJeVVZA/JWjDlZwSc6hJQ+LPIFotmh0RdWRFtDX6tIxmP5c
 BTRDJziFeV6T4yOuBdUfgr4I+A==
X-Google-Smtp-Source: APXvYqwvuXJu6kVL7xSQDaGof5okcpIy7LvuGzZgqsCLxxzWnzbeayz9TYPDt/B8Z0PCHJGMgiuI5A==
X-Received: by 2002:a5d:4212:: with SMTP id n18mr12976431wrq.261.1564588522958; 
 Wed, 31 Jul 2019 08:55:22 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id j33sm146033040wre.42.2019.07.31.08.55.21
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 08:55:22 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
References: <20190731075652.17053-1-thuth@redhat.com>
 <20190731075652.17053-8-thuth@redhat.com>
 <f2399005-cead-a147-37a5-600fda7eaea5@redhat.com>
 <b9bbf556-e2fc-8634-2238-9c1c5ead7a35@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <18d71b10-6be2-b76e-54d6-76c0395ca700@redhat.com>
Date: Wed, 31 Jul 2019 17:55:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <b9bbf556-e2fc-8634-2238-9c1c5ead7a35@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 7/8] hw/misc: Add a config switch for
 the "unimplemented" device
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 1:50 PM, Thomas Huth wrote:
> On 31/07/2019 13.47, Philippe Mathieu-Daudé wrote:
>> On 7/31/19 9:56 AM, Thomas Huth wrote:
>>> The device is only used by some few boards. Let's use a proper Kconfig
>>> switch so that we only compile this code if we really need it.
>>
>> I'd prefer having the UnimpDevice user-creatable and always present as a
>> core device...
> 
> Why? This is a sysbus device that needs to be wired up in code, so I
> don't see a reason for making this user-creatable right now.

Right now no.

> Anyway, that's a different subject, so this should not be part of this
> patch.

Fair enough.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


