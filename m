Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FBAC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:27:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3913D207FD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 19:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cIApefO9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3913D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9w95-0001SF-9N
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 14:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j9w7n-0000OT-CB
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:25:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j9w7l-0006nm-6U
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:25:38 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:40891)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j9w7j-0006mc-Cg
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 14:25:36 -0500
Received: by mail-pf1-x436.google.com with SMTP id l184so3230106pfl.7
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 11:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=WyJyqiSUmQZcTxz7y2IjBR8U/XYz5RrHpQ4cTG+YLIg=;
 b=cIApefO9ReLgiJFNPpbiAKDObTtDMAMJy9r+tF2N52dCx5cxG74aXl89XXpAKfULLV
 xu1Yx/48xPGT09rmshScJpTrrVQCOmYMjkThijSL9gObuZxnLv5//sUNrlA7OLKq03Ys
 lwh6kcrQdXUC/V7ADjKQPyhS6CclgqB394QIHBw719vIOkUNbt9BZh8BT52AT5lKmowT
 KDB+Gf75iULHbNYtIuUxt+0EV3SNcGi6J8mLa9hQ2xu2WGCxkQNxJYs8+6SCFsgZrgZS
 CEBX+vRe0FZ8DbE6/xHfFf58Qed0A/TJhBoW1kRbrL51XScyDp+eUQszas5vHHD/Avuu
 aQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WyJyqiSUmQZcTxz7y2IjBR8U/XYz5RrHpQ4cTG+YLIg=;
 b=coxftcymfiyLGFvT/V9kzzDVoOarMqXbStckR0U1VSoqVmbVe5MUyEE+1KwWGRhdIu
 PPPn8runNiwTMfInCM4eT6oi9MSQdw/SmUPVrcGG1rnNmfALHY9W7T/74lIav+JJeg6v
 C5Qb+ucqPbHZ6Dld1q61jLab17vqYUYZ0hBu5MIio2VU9J20aK1KWsJf255QO9kRXfzY
 kghXMdiyMndExwpZsrrWlAgnsLDTcX7SFoChRxL5iInMAbKH3I+4Dw4EwT2HWuPfqhYY
 KOCFGifvN9M1NFa48/tfvoD97B/cz83hZBcPAi7POjN8gKvH/l1ya7Cj6gP8dFcOqM7U
 kvbw==
X-Gm-Message-State: ANhLgQ2fm3JIAstKU9YYKTNNTqsb75Lr6/RG+Z/OAXHSH8b2yvjNzEtC
 xOSqLakrPp+4NwN1iAF2DoGUCw==
X-Google-Smtp-Source: ADFU+vsXaZ8e08Ff/ACP+oSe1HYRvt8wdiEwpMdbSNZ3cC0kFYb4dgBxptpnsvrfT+m4qvdz8ew0Og==
X-Received: by 2002:aa7:8513:: with SMTP id v19mr9556395pfn.222.1583436334396; 
 Thu, 05 Mar 2020 11:25:34 -0800 (PST)
Received: from [10.0.3.1] ([156.19.247.250])
 by smtp.gmail.com with ESMTPSA id 1sm28809680pff.11.2020.03.05.11.25.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 11:25:33 -0800 (PST)
Subject: Re: Fwd: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: G 3 <programmingkidx@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Dino Papararo <skizzato73@msn.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, luigi burdo
 <intermediadc@hotmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
 <alpine.BSF.2.22.395.2002251241080.22173@zero.eik.bme.hu>
 <3539F747-145F-49CC-B494-C9794A8ABABA@gmail.com>
 <AM6PR03MB5525DE221E3E7E595893DF4DC8EA0@AM6PR03MB5525.eurprd03.prod.outlook.com>
 <AM4PR07MB350651FBB263FEEDB857CBFFCAEA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87eeuhxw0y.fsf@linaro.org>
 <CAL1e-=gGsEV4_a4gJr2x0L3r_UK7isnpjOWoJRCDhqpG_XT3Ww@mail.gmail.com>
 <CAKyx-3MCENJREWm0BxO3ES9sDB04KV3FzYoVFKK20Fh_iwh7wg@mail.gmail.com>
 <878skpxltm.fsf@linaro.org> <FE03C155-E46D-4925-BA2B-FABBE2518C8C@gmail.com>
 <2576fd41-8b01-91a0-ca56-792ce65b5092@linaro.org>
 <alpine.BSF.2.22.395.2003021218180.72848@zero.eik.bme.hu>
 <d136165f-46c7-8983-9725-2b224742deef@linaro.org>
 <alpine.BSF.2.22.395.2003030002340.47473@zero.eik.bme.hu>
 <CAKyx-3Pt2qLPXWQjBwrHn-nxR-9e++TioGp4cKFC3adMN3rtiw@mail.gmail.com>
 <CAKyx-3OAVOvOiaWqUbVa4P35RtFS6bN0wbPuWa=6SFcB2zhL3Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <80805a79-b2e6-6283-61ee-ef91b5787314@linaro.org>
Date: Thu, 5 Mar 2020 11:25:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKyx-3OAVOvOiaWqUbVa4P35RtFS6bN0wbPuWa=6SFcB2zhL3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::436
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

On 3/4/20 10:43 AM, G 3 wrote:
> I am all intrigued by these vector instructions. Apple was really big on using
> them back in the day so programs like Quicktime and iTunes definitely use them.
> I'm not sure if the PowerPC's altivec vector instructions map to host vector
> instructions already, but if they don't, mapping them would give us a huge
> speedup in certain places. Would anyone know if this was already done in QEMU?

They are, provided that your x86 host supports AVX.  Which should be everything
manufactured after about 2011.


r~

