Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57A8C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 17:15:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62C721019
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 17:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62C721019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57107 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT8Lt-00065o-2A
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 13:15:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hT8Ky-0005dq-IX
	for qemu-devel@nongnu.org; Tue, 21 May 2019 13:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hT8Kx-0006Vu-JI
	for qemu-devel@nongnu.org; Tue, 21 May 2019 13:14:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hT8Kx-0006VW-Ct
	for qemu-devel@nongnu.org; Tue, 21 May 2019 13:14:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so19519375wrs.5
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 10:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=bZF10rcFoZVRCe/71WAskK4qoUmYlu4m4JVxdYnfvaI=;
	b=EnDkyLyzNe40ne/dyCYZ8PY1JRABqRriNQqiKAfwRumHnAOxrjE7PUKve1lN2Ku5nU
	h8TJ7QSC9O+o8cYJsrm5xfMZnkcMOCzk4nlf5eaiG8pz+R3hkvLtErJak4p/QGpOeepR
	OeF80mnJX5+4DmMw8hI4xtJpcjn2DLCnHIgZ4D8BikLrb68K6n40X9Bs2NE558Am8O/W
	lkV2llRSLwz0VPn8y/+N1w3p2aJQFVUgqOADlSHNH83S/C3o+i7NRp9J1gIdeIUJZpF5
	rUcByooHP/GWDR+Yz1csICzQHO5QP3mrQE7JAApRbcUcXxt6ZsWtVCLxH14qUCIys5zD
	2nQg==
X-Gm-Message-State: APjAAAW8sKJjvSPkg1NdoMR9DyZI/kCPJWFQz9MNfuvpjwzdN7sXM5RU
	8lKi78Al2Bmbn2XxxUz7Luq8/Q==
X-Google-Smtp-Source: APXvYqwW79GcBj4iWOVtR5YahpQdAkoO8Feyq66uN2K/iauQ6bOVjk+RB1jkBEk91hDoPdPW/MfxeQ==
X-Received: by 2002:a05:6000:1250:: with SMTP id
	j16mr2150621wrx.200.1558458842337; 
	Tue, 21 May 2019 10:14:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844?
	([2001:b07:6468:f312:ac04:eef9:b257:b844])
	by smtp.gmail.com with ESMTPSA id
	u129sm4380034wmb.22.2019.05.21.10.14.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 10:14:01 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
	Markus Armbruster <armbru@redhat.com>
References: <20190520184108.GA10764@habkost.net>
	<20190521085350.GF25835@redhat.com>
	<e2395213-efaf-6d6c-6cfd-d949d071b4f6@redhat.com>
	<87pnobrg37.fsf@dusky.pond.sub.org>
	<CAFEAcA8db=UsyU_kRBoatFT2ULQBqL318xRhg+CV4D_7hV76Og@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ea5e6b3-5617-3fdf-f98d-38def76b49f7@redhat.com>
Date: Tue, 21 May 2019 19:14:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8db=UsyU_kRBoatFT2ULQBqL318xRhg+CV4D_7hV76Og@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] Introducing GSoC project: API Documentation
 Generation
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Gabriel Barreto <sbarreto.gabriel@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/19 17:27, Peter Maydell wrote:
>> Anyway.  What's so special about QEMU that justifies coming up with our
>> own doc syntax?  Other than "we made a hash of it, and cleaning it up
>> would be work".
> The major problem as far as kernel-doc is concerned is that
> it somewhat bakes in the kernel's style choice that the
> 'struct' keyword is not hidden behind typedefs, and so it
> gets a bit confused by QEMU's "use typedefs for struct types"
> style. The rest, as you say, is just a matter of fixing up
> our syntax errors.

Exactly, "QEMU's syntax" is supposed to be actually gtkdoc, or inspired
by it, because of the similar typedef conventions.  The basic components
are:

- the head of the doc comment is either a CamelCase type or a function
name followed by parentheses

- @ introduces parameters, e.g. @path

- % introduces types, e.g. %DeviceState

- () terminate functions, e.g. memory_region_init()

- # introduces other C symbols, e.g. #NULL

and they map very well to what kerneldoc tries to parse, IIRC it only
requires some changes to the regular expression at the top of the file.

Paolo

