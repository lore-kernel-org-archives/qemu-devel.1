Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22151C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1BA20851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:27:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1BA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57291 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUD2u-0001aK-5w
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:27:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hUD1A-0008WJ-Ao
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hUD19-0000OB-DU
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:26:04 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:41473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hUD18-0000Mj-Av
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:26:02 -0400
Received: by mail-wr1-f46.google.com with SMTP id u16so6731479wrn.8
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=pXgZb+2C+kBwbQfWSq15j5IqPh+4XOYyHoqsfi3cGmg=;
	b=qQMHL6olg+zUgVA69B2zBvEV9gwOuKTwPmTIhX6wXsLKeLL+Ty1jJRSe1S5k9/Lwn+
	TyU/ZHjQTpC3AVs01PlNffg9KrONhmLP8SBxE7xJGr2XX9/6W4feseOcROHsHJhKVYhY
	Qaav4dU7Af6/nM4Yw1UvFEZw8iBwLDn2ErB2dFqBKS2J9yWVoorUgo/9WIcn36plGDQx
	a7U2JGAfeiNlkY682nJxCROLMXfTs5wLQuU8COjrMlG/G1P0XSSE8hCIhuVxj0AY8Oru
	so2neJL8pItiGt6MfhGhXAbmu+BnEeMeC150s2wQoTzAi15bMc/A3geFnyVZMwbKD4Bs
	J4Qw==
X-Gm-Message-State: APjAAAWHlj+8QFAvh7GVylobld906VfL5I7X1AvvXvdu4M1e41WqW2+h
	vUCLg1OEXhz4giHzfki9rfzG+w==
X-Google-Smtp-Source: APXvYqyoi9DhWKI4gpKTitmmzsQsSw65qfk0slKa1+x8AwiXtDTjsAlr83xmLNT41GtiI0s62LABBw==
X-Received: by 2002:adf:db89:: with SMTP id u9mr26531440wri.294.1558715159592; 
	Fri, 24 May 2019 09:25:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8553:44c1:ff3a:4781?
	([2001:b07:6468:f312:8553:44c1:ff3a:4781])
	by smtp.gmail.com with ESMTPSA id
	o23sm1823512wro.13.2019.05.24.09.25.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 09:25:58 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-6-armbru@redhat.com>
	<db337f20-8b76-9214-533e-3e4b79c5c4d5@redhat.com>
	<87ef4peyg5.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <14caabd5-34e3-260f-91e0-df93e8f1a02a@redhat.com>
Date: Fri, 24 May 2019 18:25:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87ef4peyg5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.46
Subject: Re: [Qemu-devel] [RFC v4 5/7] tests: New make target check-source
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/05/19 21:57, Markus Armbruster wrote:
>>> A large number of headers don't pass this test, by design or by
>>> accident.  To keep things more manageable, exclude all headers outside
>>> include/ for now.
>> A lot of these, either in include/ or outside, are _meant_ to be
>> included many times.  What about renaming those to .inc.h and
>> whitelisting them in the script?
> Yes, that would be nice.

Another suggestion: are there headers that cannot even be included once
(due to dependencies)?  Is it worth including a test for those even in
the first iteration?

.inc.h files would skip that test too.

Paolo

