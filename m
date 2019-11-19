Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB77DC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95574208CC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIwJ+wG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95574208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6Vu-0000Kj-C3
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iX6IY-0004ms-6y
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iX6IW-0007Q3-TB
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:24:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35906
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iX6IW-0007Oq-PS
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:24:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574180652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xjysQALhk+U9MIs4/dyzD9AOC+F1VbKkNCYM+APDpgs=;
 b=SIwJ+wG2FMT3+yJmndGpeql0gZYrozaQ/oBMvAHxua/9pfXKruEqqGWyO0qjyEVP8ojXI+
 6fojMH+I+kLkeNkTe9534tGbPi7LkeYphdtUbxIoZiJhrB9HAkD720VU0syV09+6g+fBV7
 ByBkWNZrI0ofy/HeXGEpkq17nu2x+xA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-jdeeMzRuNuqM86EQ1mv3tw-1; Tue, 19 Nov 2019 11:24:09 -0500
Received: by mail-wm1-f72.google.com with SMTP id f16so2585913wmb.2
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jKRhxYVddBJ4HfBKN9Vv6aCtn3nJZeIh4nl5sSKteJs=;
 b=f4qLGontj+6ijrH2y3ORqF51FleGHRAc43K3Wk5U+ub4yHmXKIrU8V2Hc7mU+qrveP
 1EJOiaghVrZxr/IiuEvrIdjPQJHPXBBvKZflYnB6SqIISRKwA2kvpTXtkkmsbUICrGva
 9PkaWkVCKlJWlDW1bQlA4cmyeg8jdzevf9lHOQEbp0+bMdppLoyHe61ODdWKv6H+0qd0
 CBYzgb4oM6A2Pl1vcg4ldI7vCZCuivaSoYg2ZUj98sFJiAMneW/KjhGyFZeuuiZK1hCc
 17HExtBdQMetRrfkrhmbF5znnmHCchoX5tuq+Fl3UrZUWniO8KFFm+JwAIUHH3lhzk5H
 QQfw==
X-Gm-Message-State: APjAAAVacxBrQV/5/C0b5b4LrD9BMzegzB6Zdx0LNdEUdAmzgUpRw1vn
 0ZnHnBEhc8+X5B/9/s59lpTN2Jf1Mcr0iBOOVa1b/ruvFVXQ8INOpEctscOzihHc9ItSzUyykDj
 RJmuPE9Cr7EOQCRU=
X-Received: by 2002:a05:600c:294e:: with SMTP id
 n14mr6562062wmd.18.1574180648796; 
 Tue, 19 Nov 2019 08:24:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzwuwCf32+G1yVoTW4lxfXbu8F7JhgX8kaHWDQXhJeelptkKnvfjYYMwxJKCQDrHC9Qp/0haw==
X-Received: by 2002:a05:600c:294e:: with SMTP id
 n14mr6562027wmd.18.1574180648612; 
 Tue, 19 Nov 2019 08:24:08 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id x8sm27445666wrm.7.2019.11.19.08.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 08:24:08 -0800 (PST)
Subject: Re: [PATCH v4 0/2] hw: Remove dynamic field width from trace events
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20191118222746.31467-1-philmd@redhat.com>
 <20191119162112.GC229732@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f2a3704c-da84-5f88-14a3-74c0d6bd38c3@redhat.com>
Date: Tue, 19 Nov 2019 17:24:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191119162112.GC229732@stefanha-x1.localdomain>
Content-Language: en-US
X-MC-Unique: jdeeMzRuNuqM86EQ1mv3tw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/19/19 5:21 PM, Stefan Hajnoczi wrote:
> On Mon, Nov 18, 2019 at 11:27:44PM +0100, Philippe Mathieu-Daud=E9 wrote:
>> This series fixes LP#1844817 [2].
>>
>> (Eric noted in [1] the dtrace via stap backend can not support
>> the dynamic '*' width format.)
>>
>> If they are trivial/block/tracing pull in preparation, this
>> series will be happy to be taken, else it will go via mips-next.
>>
>> Thanks,
>>
>> Phil.
>>
>> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04720.html
>> [2] https://bugs.launchpad.net/qemu/+bug/1844817
>>
>> Philippe Mathieu-Daud=E9 (2):
>>    hw/block/pflash: Remove dynamic field width from trace events
>>    hw/mips/gt64xxx: Remove dynamic field width from trace events
>>
>>   hw/block/pflash_cfi01.c |  8 ++++----
>>   hw/block/pflash_cfi02.c |  8 ++++----
>>   hw/mips/gt64xxx_pci.c   | 16 ++++++++--------
>>   hw/block/trace-events   |  8 ++++----
>>   hw/mips/trace-events    |  4 ++--
>>   5 files changed, 22 insertions(+), 22 deletions(-)
>>
>> --=20
>> 2.21.0
>>
>=20
> Will send a pull request today.

Oh thanks Stefan, but it was getting late for the RC tag so I sent a=20
pull for these patches via mips-next a pair of hours ago:
https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg02894.html


