Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF10DC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 12:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7452206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 12:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7452206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40605 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYV1J-0006Ty-Rt
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 08:27:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYV0M-00062f-Qa
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hYV0L-0007SL-T0
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:26:58 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:34986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hYV0L-0007OS-27
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 08:26:57 -0400
Received: by mail-wm1-f47.google.com with SMTP id c6so2090680wml.0
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 05:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=VUvd3fJgcva0n+rYslNhqq2PpcuLx5aDCrYJf6TMzdk=;
	b=SzV3Rnnubij1nMpbNt3DhQJUGp3lYUjpkoyboXtFzQ8uPr8kJMPr7FwaeoCZdvvDDm
	dwohGBbCzo8kVOal/gDgZJ50J9ZVE+r+OC4pxOQZ+wMrR5KyNbrg84R7+hsAn5ep5D2T
	zDoSid4W2cuNx1+Oc5bssgvvaHDAQZiZcN2jnt1wtn1q6UizDdpQswoxe8697EgNtIyi
	TMy5ifYoOuQzmqPJVopBClNSNN8Ql3YbH8AQdjhITw2ioh7L2qnWiKTG6VGzVZVj7eL1
	Gnr28kwHdMP/L+V1QHAML1mL2oPurjU2VHkZuuKuVcjujzbM+HgDcTbgA3uV74ZwhNYO
	6A1w==
X-Gm-Message-State: APjAAAUgQrVwB1GP9Mv+kRlo+oj1LY0eAOSnIuVttqmu7G4Qezovk0fz
	GQjzrIXO7v0usUQEvbAIPQY4tw==
X-Google-Smtp-Source: APXvYqxpZoaLsA1yuVf0EYSHyRVwR5xvUtZl56oFE8+Xxa2TlVdG7x2IVrCY8nPrNYZXKRuLxtBBdg==
X-Received: by 2002:a1c:a807:: with SMTP id r7mr21766585wme.137.1559737614359; 
	Wed, 05 Jun 2019 05:26:54 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	l190sm16760251wml.16.2019.06.05.05.26.53
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 05:26:53 -0700 (PDT)
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20190605115318.9972-1-quintela@redhat.com>
	<20190605115318.9972-6-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <60500aa5-856d-e754-3a4d-8d8b311087ca@redhat.com>
Date: Wed, 5 Jun 2019 14:26:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190605115318.9972-6-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.47
Subject: Re: [Qemu-devel] [PULL 5/5] migratioin/ram: leave RAMBlock->bmap
 blank on allocating
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Markus Armbruster <armbru@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

migratioin -> migration

