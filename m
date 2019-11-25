Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECC0C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50002075C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 10:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OD5NAyiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50002075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZBaJ-0002ey-Lv
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 05:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40265)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iZBZZ-0002Az-FT
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iZBZX-0007Ag-6G
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:26:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36886
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iZBZW-0007A1-WF
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 05:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574677582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=cf5kbh6yTuhu/SZx7Z4kj0zg+IDMn5LTQV4PZlV16fM=;
 b=OD5NAyiHuqfIj6lujY5SOQC77Nw8DB4PScbydtV7fuqd47PbCbnNqGQZSoBaiauHFu5wHG
 EkIAC8Tx79ekGmyCGY20j9uh5ILanF3nWCRItxiLRLCwqZHeEYejh6hP4XpkDYOTyDVBck
 jJVcL2Bqxgid2sYJW9+bXeJb7jyMWm8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-z0b-H9xDOJS9aJx1vd1a0g-1; Mon, 25 Nov 2019 05:26:20 -0500
Received: by mail-wr1-f70.google.com with SMTP id h7so8622509wrb.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 02:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OqBvJPHOPgsvHwK3ZAzyK4IJ9guH4qUIOZieUVQMBxo=;
 b=HZr/3efpSj05mdvSI9WOc8/aE6QQz5gxLRYh2dw21vj5qiIfgOqxR7cxN9w1nZGDob
 OmAB8kXH9UQkjO0L4Bw3grG22rsIwmqUwaorvzhaMLDOW/s95FopR9oBJQP0NfTgPtky
 JGvLMuMHaFB5eKG/yChBEgdjqLdJQGEYsMZdhMhhf5BzQrv7NBCUiGYShXP65PdDeoaF
 MBkWGm9kJODp6cbb//IgnaWtLe+FHme39H+w3pI7AFMc1AQecBeBZLfy01FiNt4CRrzG
 bdFBikT66D7iJyKrocQk9tg0Rn5kHefl/pcVHKEIfL+yKAZ71FqzojDoPV3TdKD3a9E1
 Nn1Q==
X-Gm-Message-State: APjAAAVYoB4iujSUtqTdy0TDI721n6B5yz8WagWRKTlmeYXSEGVjQLZM
 yEm7L89XvKcTqgjlQP6oea8clUeXx0kGdfrJdWCIYuSzH+LMZWnrqJgous4cBMMgSZcRxFYka8I
 0hF1b8IHw/7AfmyU=
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr31970897wrr.72.1574677579144; 
 Mon, 25 Nov 2019 02:26:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwnksbnZFRA/KRCpIt6zojoRrJiQtWffu9Y26luYaBdxrcwgJ+7atWa2irJhWOtdr0vghf9VA==
X-Received: by 2002:adf:fe0e:: with SMTP id n14mr31970868wrr.72.1574677578808; 
 Mon, 25 Nov 2019 02:26:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:5454:a592:5a0a:75c?
 ([2001:b07:6468:f312:5454:a592:5a0a:75c])
 by smtp.gmail.com with ESMTPSA id x205sm8635463wmb.5.2019.11.25.02.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2019 02:26:18 -0800 (PST)
Subject: Re: [PATCH v2 5/5] hvf: save away type as well as vector so we can
 reinject them
To: Cameron Esfahani <dirty@apple.com>, qemu-devel@nongnu.org
References: <cover.1574625592.git.dirty@apple.com>
 <e07e6085d8ab9054e58f85ae58e112df6adc024d.1574625592.git.dirty@apple.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <eb3a2de7-fcfe-f0d5-8534-1c59ff40f61e@redhat.com>
Date: Mon, 25 Nov 2019 11:26:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e07e6085d8ab9054e58f85ae58e112df6adc024d.1574625592.git.dirty@apple.com>
Content-Language: en-US
X-MC-Unique: z0b-H9xDOJS9aJx1vd1a0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On 24/11/19 21:05, Cameron Esfahani wrote:
> Save away type as well as vector in hvf_store_events() so we can
> correctly reinject both in hvf_inject_interrupts().
>=20
> Make sure to clear ins_len and has_error_code when ins_len isn't
> valid and error_code isn't set.

Do you have a testcase for this?  (I could guess it's about the INT1
instruction).

Paolo


