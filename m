Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13059C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:02:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE881208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5fuqf8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE881208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPOlC-00024N-0k
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 07:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jPOjT-0000yf-Ui
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jPOjG-0002ol-VA
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:00:27 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:36790)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jPOjC-0002ib-Bh; Fri, 17 Apr 2020 07:00:10 -0400
Received: by mail-ej1-x62c.google.com with SMTP id b9so1273184ejb.3;
 Fri, 17 Apr 2020 04:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fFGB0DAyujTEmrhuJWj9xchCFk3gZC+9MHaA9wQ5x5g=;
 b=k5fuqf8TgqHtd28MPLNLxVihgCsL4cmjgKeU/y31nU9Q59VXNmaThM+TzKpn4JjkrW
 f17U90R5EiNip3BB50SdzyPFuq3929wPIanjLWiZuZe5Y7xZZ9xYTGpgjh7PB+/T/A40
 BWv/foQlRaZZVg5AWVJui0gI1a4hYioW4T7mVD3qZFfDAow07H3EFyWkegI1EFMvlK9p
 eajts5QFS1wpyctaSlLc9H2ULLkjYBZRzF+chr5qe+Gc/2JXBuZJ7d5EU9hQ1UHadGe5
 JeD8BgsgO4lWk3ezH85DNB8YQI3zpexjZgPHjUyfEz7NJYM0tHfd6GrsG0LmKXC1jzga
 sO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fFGB0DAyujTEmrhuJWj9xchCFk3gZC+9MHaA9wQ5x5g=;
 b=t3YXIgsckE1GwTfpS1mlGr24DO70xRaPwAWvvRys34g/1k1Lcj4E68GY8vPKYTgn+z
 1T7K4xDfC6U3MAJDaueoQMr+9xZbEv6TWYE0fYTwh40V4dx1l76rMdPUXGdw+cIkSzeN
 7v7eEBJNlX5ZqrJHAq4xODAUS8Eo5lW7Gmg2LKnOHg5nm262XZAtji9zabmvyYoedKZq
 xCMKES7hmGRAEyqJUncMPR8ZIFCIQ/+YDkRmg7VIu1JaU+OuxC5kI/AcifLCUD+iZPK1
 hYlMUTl2/OOaFF640JUXgEJMmbPmcL5+dafrnyhVM6nmuz4eTXg6BqTllKAaaj4ddUqC
 sO3A==
X-Gm-Message-State: AGi0Pua9bWVVk0F72FpV6DOrKJkCAB9zrJLNq0mygYJccaSnh1vLOlm9
 es+vCcUw3wl5h8KKWzw7vTM=
X-Google-Smtp-Source: APiQypJCyI4QxgEEyUM0tk5VROFBDpfZucySDZx2nK52C+/ZTGRy/5gKtdbgkR9eGSPE4eU15CCGNg==
X-Received: by 2002:a17:906:60d4:: with SMTP id
 f20mr2354072ejk.209.1587121208946; 
 Fri, 17 Apr 2020 04:00:08 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id j9sm2893171edl.67.2020.04.17.04.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2020 04:00:08 -0700 (PDT)
Subject: Re: [PATCH-for-5.0?] target/ppc: Fix TCG temporary leaks in
 gen_slbia()
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
References: <20200417090749.14310-1-f4bug@amsat.org>
 <1587120086.g7mzwaexlz.astroid@bobo.none>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <a7ff1611-6273-f42e-d67d-bec10e6b4b0e@amsat.org>
Date: Fri, 17 Apr 2020 13:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1587120086.g7mzwaexlz.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::62c
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
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Dennis Clarke <dclarke@blastwave.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/17/20 12:51 PM, Nicholas Piggin wrote:
> Excerpts from Philippe Mathieu-Daudé's message of April 17, 2020 7:07 pm:
>> This fixes:
>>
>>   $ qemu-system-ppc64 \
>>   -machine pseries-4.1 -cpu power9 \
>>   -smp 4 -m 12G -accel tcg ...
>>   ...
>>   Quiescing Open Firmware ...
>>   Booting Linux via __start() @ 0x0000000002000000 ...
>>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>>   Opcode 1f 12 0f 00 (7ce003e4) leaked temporaries
>>
>> [*] https://www.mail-archive.com/qemu-discuss@nongnu.org/msg05400.html
>>
>> Fixes: 0418bf78fe8 ("Fix ISA v3.0 (POWER9) slbia implementation")
>> Reported-by: Dennis Clarke <dclarke@blastwave.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Thank you, brown bag required. Looks like I should be testing
> this stuff with --enable-debug, sorry I didn't realise it.

Is that an implicit:

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

?

