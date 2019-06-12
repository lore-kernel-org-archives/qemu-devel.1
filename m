Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9F8C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96FA215EA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t4v8BtN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96FA215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33738 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6Fc-00042N-0t
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53938)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rth7680@gmail.com>) id 1hb6EQ-00035S-UJ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1hb6EP-0000gT-R6
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:36:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:34221)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>)
 id 1hb6EN-0000dX-DJ; Wed, 12 Jun 2019 12:36:11 -0400
Received: by mail-pf1-x42a.google.com with SMTP id c85so9993982pfc.1;
 Wed, 12 Jun 2019 09:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4YAKgmm3uxfG6qjAg/EB3AViBdlelytDdopfZVhqhug=;
 b=t4v8BtN+R/KXjMmatS7BuuM2K1xqP+K/LhKOUlpvW1y8Wt89yVH28tDdC0ieAjW7mg
 idQH6IHlLgt0BknBPJpyV0nTJx6LvHbJlW5oGqm7I/PqSAPcfqOpUTZVH6+kmD/LKWiE
 bcIZL6BsAfB3uZ7yRKvbAWjBwqyLs89a3i0MJiunQKubxJWq40Inu6DrjfVR82ZPDktv
 GLpsFsPPmDLvTt2LdDnwmZIfLGhYZbXIKmczaMYmsNBmZFXK0VP4qoNS6WgHZg9nNCfy
 hOhkiPi+pqQmbODN/OLNp9I+aC6ZO6cVL5itYxK4Q6SJ9BuHrhmzxSBTsb6w6RUK9tOT
 K0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4YAKgmm3uxfG6qjAg/EB3AViBdlelytDdopfZVhqhug=;
 b=N+2fy4FBgH/qdpNC2x6E7Mo85+p0johOEViE82BjDkU+mJpkGcZ8O60t0jw5aDRwyw
 lcudNV+sbz2DcZbybgj+O/5MhMiI0Io80COYOinbxAXpES46cS7zcuHdIl/0aNemer7c
 bd3cn4DNSnnDufb3YAYNw34ieygzZuBHeepgckTs5d9/1BoiHRenr+WBkhx9ljDQVkF5
 lTHdCQUUJJDX5CxRi5/7V4J8gQZbY3BZ868F2M7ccYk+NG2fojNzSqfxdDE66MqVy/X1
 plQQvem5NP3hPfZn3Iq/Qi74x9ohw/ticOmAajsyRGRidZ72Ch1plR8H2MaAqPkoKdgH
 fgFA==
X-Gm-Message-State: APjAAAXa4aPZV1joaOATR5RvQzBWqFcy/Al36O+/10Mgns9+feQBzMl3
 pHvR2qE5P3GYBZ+84atrsvx9Z/5U
X-Google-Smtp-Source: APXvYqzN7XKqJZOKGcwnD7e/SipsO4XciwqbymYUNazoBbKHwenkTeHZOLsdfmT8sGIQhn77WrvVQw==
X-Received: by 2002:a63:c508:: with SMTP id f8mr26328076pgd.48.1560357369773; 
 Wed, 12 Jun 2019 09:36:09 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.googlemail.com with ESMTPSA id
 n184sm90591pfn.21.2019.06.12.09.36.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 09:36:09 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
 <20190602110903.3431-5-mark.cave-ayland@ilande.co.uk>
 <20190612015224.GG3998@umbus.fritz.box>
 <53c86ca8-332c-e073-0e78-2a684cd05161@twiddle.net>
 <20190612051604.GI3998@umbus.fritz.box>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
 mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
 n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
 rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
 Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
 n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
 AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFBBBMBAgArAhsDBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
 cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
 Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
 eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
 LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
 Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVuQENBFGuLC8BCACyEx3x
 94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
 86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
 I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
 VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
 +PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAGJASUEGAECAA8CGwwF
 AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
 Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
 prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
 /E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
 jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
 VcROBqvtH3ecaIL9iw==
Message-ID: <380e5888-ad0d-c8aa-3ed5-ac542467fc09@twiddle.net>
Date: Wed, 12 Jun 2019 08:58:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612051604.GI3998@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42a
Subject: Re: [Qemu-devel] [PATCH v2 04/15] target/ppc: introduce separate
 VSX_CMP macro for xvcmp* instructions
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
Cc: qemu-ppc@nongnu.org, gkurz@kaod.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/19 10:16 PM, David Gibson wrote:
> Fair enough.  Richard, I was kind of hoping for an A-b or R-b on the
> series from you, but didn't see one..?

It's still on my queue.  I hope to get to it soon.


r~

