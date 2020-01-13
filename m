Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB40DC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B76207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTycK41H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B76207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2VO-0002wC-NI
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ir2Um-0002ML-AG
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:23:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ir2Ul-0006dZ-CY
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:23:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30968
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ir2Ul-0006bP-9M
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578932594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAun/K1lyiRfKGi+1Rk6IAYFzdY3My2Yc1Te6+XXjWY=;
 b=WTycK41HHB6CVKniYSHH0WSoyFDXypJoODJCjXYJ3jZS58lXNyCIT9TLurai0G/IaTixGq
 4sacwHZkjaW6HZ4ONbpLcMT8FjTzzikalDDKjfTZd3vT4bb55te4oRgo7QQN+6EAAUwcBT
 QvWKwoec+3GCebbi75IB7OkUzcZqCh8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-ga-B2Z0zOPetwBmLqSUpTw-1; Mon, 13 Jan 2020 11:23:11 -0500
Received: by mail-wr1-f71.google.com with SMTP id t3so5161581wrm.23
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 08:23:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xAun/K1lyiRfKGi+1Rk6IAYFzdY3My2Yc1Te6+XXjWY=;
 b=q+n0t7eaJe67/CNaExHW+5vyGUgXvRATHwDq40gD6UqGtx0X7TpZVGr5HQ+AFYOMJ3
 KilrO96QGMGjE9orf2fZatZcXUne7YatOAdSwBHXHgmaBd00/IO3iDy8infmdytT0vaw
 V8VnHUgkv4tpCwuB3C4pF+YsZ+0yRiUsiyk6wcCHiLPES7et6r3a81fk5ZMbqAb/r7IQ
 CM8PkdC20QKXt9u3bbZEl2l7fLB1MHzVrFR4t42lLtbHOTYg107S7Du2pUqyMuTotTpq
 +Qq/VaFlJSGsRAyZ2bJP/v/wFQzi0CNztapSFmDYEX7aMPwsTq/zwIhx5B/AFCtJ/OBq
 nvSA==
X-Gm-Message-State: APjAAAXKdPhAG68tcPOYl3/r2KHX8vzW4E9CgGtDA6MqUqWLkA251PeC
 bAt8KhdRr+QovZJf1bKNHwhDdX8tZYDVSfykCgzTUmQi7u87v1fBVBWTpY7gvv4z+OZp+fLsI4m
 m7nvyErpEWbXE/8M=
X-Received: by 2002:adf:e5ca:: with SMTP id a10mr19245148wrn.347.1578932590098; 
 Mon, 13 Jan 2020 08:23:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHZoOOqKWinpNZcHGTkeeUgzb8lmZOSSI9d4L5aq12yEh4+uQTdBpioAPk1z3pJjRZNOXFNQ==
X-Received: by 2002:adf:e5ca:: with SMTP id a10mr19245119wrn.347.1578932589890; 
 Mon, 13 Jan 2020 08:23:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:1475:5c37:e2e2:68ea?
 ([2001:b07:6468:f312:1475:5c37:e2e2:68ea])
 by smtp.gmail.com with ESMTPSA id f1sm15950713wru.6.2020.01.13.08.23.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2020 08:23:09 -0800 (PST)
Subject: Re: Priority of -accel
To: Christophe de Dinechin <dinechin@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
 <656169fc-1abe-b521-20a3-e7041739b914@redhat.com>
 <20200107125451.GL3368802@redhat.com>
 <3241dff4-6223-404f-55d4-846991763046@redhat.com>
 <2ae2dee3-cd16-a247-971b-4b3482e596a5@redhat.com>
 <20200107142735.GC3368802@redhat.com>
 <fb83df0a-da82-f981-fbda-d5c74e87cf5c@redhat.com>
 <871rs3zaih.fsf@dusky.pond.sub.org>
 <752BE521-649F-418F-BD09-DDC7708F4FF2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f217e141-3da6-26ff-a174-487f41722989@redhat.com>
Date: Mon, 13 Jan 2020 17:23:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <752BE521-649F-418F-BD09-DDC7708F4FF2@redhat.com>
Content-Language: en-US
X-MC-Unique: ga-B2Z0zOPetwBmLqSUpTw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/01/20 17:14, Christophe de Dinechin wrote:
> % ./x86_64-softmmu/qemu-system-x86_64   
> qemu-system-x86_64: invalid accelerator kvm
> qemu-system-x86_64: falling back to tcg

That is a bug, Richard Henderson has posted patches to fix it.

Paolo


