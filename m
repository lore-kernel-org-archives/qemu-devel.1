Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4C9C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 04:26:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32D120874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 04:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpwEyxNu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32D120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56584 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hauqV-0008Fn-M6
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 00:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46794)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rth7680@gmail.com>) id 1hauoK-0007B6-94
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 00:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rth7680@gmail.com>) id 1haumE-0006cA-HQ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 00:22:23 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rth7680@gmail.com>)
 id 1haumD-0006bC-6l; Wed, 12 Jun 2019 00:22:21 -0400
Received: by mail-pf1-x444.google.com with SMTP id j2so8814630pfe.6;
 Tue, 11 Jun 2019 21:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jRyOzvRcVS4d5PkRMA/txJ2qLGg7SMlEd20E7BdieUY=;
 b=SpwEyxNuwpVTL4YYzuOPPqKiberBj18dCYd3kVd1+fgw9pU/Y2Wea84/pfJlFHHc4G
 TCPCcTnFqdAOOMG2xAzsgJzvEdmaMvSPuhEaHTSv7NlC7n2OmaDGgqIBi0x8dncGrcxE
 7LTAPyeHLNx1Jj6cR7+gj405iK2jG+9CO88dZ084ZtAv0CmWCK9/yjUy5RObebUfVk2s
 xUFtC3ldFvVXjdU9iuolCEVqkorg1Hff4QyFJiX4uOdOBvdp5fLH2TBGOCslU8SE3Jv8
 AwG56ePRN+DEf7vJrqx0A2BbnCfWfJNLVpT1pzNVkk7zujcryA0WXVWA7jt+ivC92NXy
 IiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
 :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=jRyOzvRcVS4d5PkRMA/txJ2qLGg7SMlEd20E7BdieUY=;
 b=to0VDo7fX3N5MZqF7Yl4rjFhnEHIQgRpt8utyQ8TDs3/38wdOft0YeCS1JGFZJJtMN
 BuABvTuLx+g9Hjrrq5leFLN9xZxWDJk8YoA1e6U1z2+YUAjkQ3EsKXy6iITUcIxu4JSQ
 9JEp5Kv7EQRZBvgtvrit+gUdK400mnzgYGydTLfFj/M8YsfZS4Y05kPXtUXku5E9ecIb
 JwlrNxJPExXXroAwXsnYzWQSxV3C7HKZKi6YiKP/Mn7ryQ59hsfiH+CCwhpFDqVpEp0y
 +8/WeFp+0VSDSmUuPxuZTHMexxuMIMbZ4qI3Ymp8RaG/tW3979ZNAUtvgqgKil3rsGcS
 dQpA==
X-Gm-Message-State: APjAAAV2gdNYPkAPOE5c5XAr3Soa3/AfO/trrYR0VxtbdfL8ob85WbZ1
 J2342zXrJP6hqWvieF+IdY3rqwUT
X-Google-Smtp-Source: APXvYqxaeFND4WMBS1MatmAuNL6Uqs2/mjQ1w/wunBJ2t3p0/YSXEcI6oDaSO6dKbOqvVMZaXNnTrw==
X-Received: by 2002:a63:441c:: with SMTP id r28mr23413747pga.255.1560313339248; 
 Tue, 11 Jun 2019 21:22:19 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.googlemail.com with ESMTPSA id
 k22sm15674884pfk.178.2019.06.11.21.22.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 21:22:17 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20190602110903.3431-1-mark.cave-ayland@ilande.co.uk>
 <20190602110903.3431-5-mark.cave-ayland@ilande.co.uk>
 <20190612015224.GG3998@umbus.fritz.box>
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
Message-ID: <53c86ca8-332c-e073-0e78-2a684cd05161@twiddle.net>
Date: Tue, 11 Jun 2019 21:22:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612015224.GG3998@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: gkurz@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/19 6:52 PM, David Gibson wrote:
> On Sun, Jun 02, 2019 at 12:08:52PM +0100, Mark Cave-Ayland wrote:
>> Rather than perform the VSR register decoding within the helper itself,
>> introduce a new VSX_CMP macro which performs the decode based upon xT, xA
>> and xB at translation time.
>>
>> Subsequent commits will make the same changes for other instructions however
>> the xvcmp* instructions are different in that they return a set of flags to be
>> optionally written back to the crf[6] register. Move this logic from the
>> helper function to the generator function, along with the
>> float_status update.
> 
> What's the advantage of this.  Since we still have a helper, don't we
> suffer the cost of the helper call *plus* the now-generated
> instructions?

Not as such.

The generated instructions are all of the form

	lea	offset+x*16(env), reg

which is cheaper than

	mov	$x, reg

and then

	shl	$4, reg
	lea	offset(env, reg), reg

within the helper.


r~

