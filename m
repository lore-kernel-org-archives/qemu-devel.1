Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F5C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C51620989
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 14:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ezE2aJV4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C51620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjPNd-0004lQ-J3
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 10:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51855)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hjPLx-00032q-Pm
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hjPLv-0008Hx-M6
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:38:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hjPJr-0007gY-W9
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 10:38:19 -0400
Received: by mail-wr1-x444.google.com with SMTP id n9so1025407wrr.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qa0PQaRVLZzo5QsPehq/XCw5GiwLGdS0EHMST0VXnmQ=;
 b=ezE2aJV4nZEI55EeUjjPDnqvvfhPzpwB1RDD76Tl5JfAJPrpbmly0IXcdMskjB1Rng
 jReuferUhh1ZitKawecc1v0JOCpVQSBUmISZQddxlMqqsxUlDsueKPKRXCMFcDZ27CMP
 DImFHZLVFU4i3JSAEF92I+Fp17Cs0HiMFr4wnM5T3eu9KGzxHKnhaGuRyFfIffY/oFoB
 JNoQkDiYhp56hYaORz+t9b0Oy8sxouUTN4XdgJAn433N19yZQ5x7UvPvjtu7BVUsd0dL
 hRf8o/iM0eIFcYh/HKA+1H+RqgTLnBmF4Gf1/Dgrb1KeTRwNdokSL/HjwaQHK7Onvfkp
 XRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qa0PQaRVLZzo5QsPehq/XCw5GiwLGdS0EHMST0VXnmQ=;
 b=r92GVw47DGUfPkSHyz4xsnTSnr9xy0vHK4lYkReci8zeg8lhkwpn7xEYbkRGrSQPpJ
 4T59XasprClffNhUzIqqsbeI555hv3CubKFDthrin+tEM6z35rxwnrUgEg22OTItW2v7
 Eaa5M4Bho+QRTVCm3fJCc7oNM8trMNUDCexYgmoQIfUF+LqvEJ71Csf7m7LJocuSv2HH
 yFwhzFWVhuZGuLQnmMyweLb5CisPo7RaUmkOl5eJfB6NXl61YD0/rx4e6wtKp5le4ajL
 Vu/ox5koUiUAyrqEg69AkFXbcWusCDNJ893kBascGTo/X0DDgtHq13K1UMsdpIvZsKAC
 ZH7w==
X-Gm-Message-State: APjAAAUWtd9jRWppQsT/lFAMdTiOJAWJzy9mXdt/9oMBzr4SbwwDANqO
 ZhnhcFIpJmMIc/UIsGRuRRzWtA==
X-Google-Smtp-Source: APXvYqy2jnjmZ7NYEE6PtBNDCdtSu7HsXO1GB5rNyv/xnV9QvjyS4NIXL9LKpzhbgIkExpYlMe6aTA==
X-Received: by 2002:a5d:4d81:: with SMTP id b1mr4682920wru.27.1562337366487;
 Fri, 05 Jul 2019 07:36:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id k63sm10451711wmb.2.2019.07.05.07.36.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 07:36:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8B4FC1FF87;
 Fri,  5 Jul 2019 15:36:05 +0100 (BST)
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
 <20190702210017.4275-5-vandersonmr2@gmail.com>
 <877e8wk2nm.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <877e8wk2nm.fsf@dusky.pond.sub.org>
Date: Fri, 05 Jul 2019 15:36:05 +0100
Message-ID: <87tvc0v99m.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v3 5/6] monitor: adding info tb and tbs to
 monitor
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
Cc: vandersonmr <vandersonmr2@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> vandersonmr <vandersonmr2@gmail.com> writes:
>
<snip>

I'll leave Vanderson to address your other comments.

>
> Debugging commands are kind of borderline.  Debugging is commonly a
> human activity, where HMP is just fine.  However, humans create tools to
> assist with their activities, and then QMP is useful.  While I wouldn't
> encourage HMP-only for the debugging use case, I wouldn't veto it.
>
> Your (overly terse!) commit message and help texts make me guess the
> commands are for gathering statistics.  Statistics can have debugging
> uses.  But they often have non-debugging uses as well.  What use cases
> can you imagine for these commands?

So this is all really aimed at making TCG go faster - but before we can
make it go faster we need better tools for seeing where the time is
being spent and examining the code that we generate. So I expect the
main users of this functionality will be QEMU developers.

That said I can see a good rationale for supporting QMP because it is
more amenable to automation. However this is early days so I would
caution about exposing this stuff too early least we bake in a woolly
API.

The other wrinkle is we do have to take control of the emulator to
safely calculate some of the numbers we output. This essentially means
the HMP commands are asynchronous - we kick of safe work which waits
until all vCPU threads are stopped before we go through the records and
add up numbers. This is fine for the HMP because we just output to the
monitor FD when we are ready. I assume for QMP commands there is more
housekeeping to do? Can QMP commands wait for a response to be
calculated by another thread? Are there any existing commands that have
to support this sort of pattern?

>
> [...]


--
Alex Benn=C3=A9e

