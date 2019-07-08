Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8598AC606A7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 10:18:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A7920651
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 10:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A7920651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkQik-0001tr-G6
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 06:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60185)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hkQi0-0001V9-AC
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hkQhz-00074X-D9
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:17:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hkQhz-00072O-7N
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 06:17:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id v15so4773062wml.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 03:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P8p4g6VJr2ebqg8m9wj6yZLc7XA9ToZQDIHUze4c5vg=;
 b=SMfNa2Aaz/37R2eQzmSld1bvz2666o7C744QARuuIfm0Kq3qatJWlb6C4TExJCloNN
 nDlWuMuKLbC2+LEzDx5dDZ3dbmPAHhCoV1Okl/Z6VpgGjC3SoRxYvcyk4r52yMm3yBBI
 DeA+uEtLBU4OblC8m40dTqn1/Ei9a8Y8Mup4qBFJ0y9dnb3drMCxcEQGISwiVvfGfqcI
 3w/fHoc2J4wJ1ytw7FRPcQ+OF1PJfMpDB+f9BL4KzVTr3phkx7Gu46+8159l+QK7F016
 hAOY2GGzFy9Zwoihd47VsM4f92BxDaYlugmuToI4yn8fulguMLX4ZDiCvGtRvSq/t4iB
 mtcw==
X-Gm-Message-State: APjAAAVLhVsAF7ZPkKFTLSZifc9qPbu6rH9uWBad+qZ/nPtL1Xn5xPQG
 RnUfgg2iLGzHqRTTAMdKC4jbnebaF/c=
X-Google-Smtp-Source: APXvYqzf/asS3MVBfWORvGtKoWayPmJFUb4XbQDKO9rac2pkTIu1BFui80nx89MR563UKqmnlsnFTA==
X-Received: by 2002:a1c:c1c1:: with SMTP id r184mr15946258wmf.9.1562581034562; 
 Mon, 08 Jul 2019 03:17:14 -0700 (PDT)
Received: from [192.168.1.103] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id r16sm46144738wrr.42.2019.07.08.03.17.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jul 2019 03:17:14 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <3c8b83fe-120b-40e6-84d5-5a3b88e46ee3@ilande.co.uk>
 <CAFEAcA9KjJUE7R0OYfM9AT=Ydu8eXBYJR=sGoGog25xrpRMZig@mail.gmail.com>
 <914f608a-5128-87a5-1c08-e20db88ad216@ilande.co.uk>
 <CAFEAcA9=KKtbR624rV77cu41zUTyu2N8-+1Gjmg-rQwdS1htuw@mail.gmail.com>
 <20190708094107.GD3082@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <28ca7c60-5795-31ff-1d71-1fac477ad996@redhat.com>
Date: Mon, 8 Jul 2019 12:17:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190708094107.GD3082@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] Parallel make build fails on fast machine
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/19 11:41 AM, Daniel P. Berrangé wrote:
> On Sat, Jul 06, 2019 at 09:35:30PM +0100, Peter Maydell wrote:
>> On Sat, 6 Jul 2019 at 11:28, Mark Cave-Ayland
>> <mark.cave-ayland@ilande.co.uk> wrote:
>>>
>>> On 06/07/2019 11:16, Peter Maydell wrote:
>>>> If you just do 'make' rather than 'make install' does it fail the same way?
>>>
>>> Interesting. A quick test shows that "make V=1 -j2" works fine, it's just "make V=1
>>> -j2 install" which is failing.
>>
>> Mmm. I suspect most people just do the plain make (with the make install
>> phase either never or as a second command afterwards), so missing-dependency
>> bugs between the install targets and the build targets are probably more
>> likely to lurk around. We should stil fix them, though, assuming we
>> can track them down...
> 
> The main 'install' target depends on 'all':
> 
> install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstatedir \
> 
> 
> but I think still allows 'install-doc', 'install-datadir' and
> 'install-localstatedir'  to parallelize wrt 'all'. I guess the fix is to
> make each of those 'install-xxx' targets depend on 'all' instead.

I'm not sure I follow, are you suggesting this as a kludge for this
release, or you recommend this as a default?

Apparently only 'recurse-install' depends of 'all'.

