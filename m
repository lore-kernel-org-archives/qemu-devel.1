Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E06AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8D020684
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxovngRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8D020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWMZ-00086K-3f
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDWGm-0006fL-BI; Wed, 02 Sep 2020 13:10:00 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDWGj-0001Rr-OI; Wed, 02 Sep 2020 13:10:00 -0400
Received: by mail-wr1-x42f.google.com with SMTP id c18so173557wrm.9;
 Wed, 02 Sep 2020 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hM9MrG0kYxaTF66jNodBpX4uVHpZDqpNCGguDnceNj0=;
 b=nxovngRD6XKCd1M614effn4LaeZYKV6qupMC6Rw2If4AZcf3EdXnnVV5WO0pAJCtNn
 Ze4dEiqYYJ31to6ebrextu3akLAFg3Yv7rLLRK0aLPAhmJhfJ4/f94aP0QNMhSysXBAs
 agVI0vF/9KPpIUMoo06uaOAFsa+B+Z2josVYpADoPYplKnl8AkF1p9GsBAVkVXGJ0GHt
 6wBUZ07Jvff8zbv6yN8y1rdBb4PjhffGU9zovDfhXESNNyYHhwVNh5Zs0rTij7dYIff6
 gzr+jnaklkNZ//qk4TdZ4Df9s34/rJsdSBN94KzekVAITpUNhGiXC4Ju5qXKWp2VwEM/
 xO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=hM9MrG0kYxaTF66jNodBpX4uVHpZDqpNCGguDnceNj0=;
 b=dSwfIB5Rt+zk9cpIK1Y6VGNF5rTb/uWBgGFtJxJdGt6/O+dZU3l3+Jn1ebnFy5kaJw
 X8Zl5ftIOBskktTnYgQ3Z5TWt6D6NzkjhLYKSinKAuANgrbKWPX2AX0EKkAREdIMX9Pe
 a2ZSP7na7nzDUcuR4DsT5mR4L5FvQBttBHot74Rx1EgtgNiG84WV0SsbKoBEe93YVrGE
 8g6U+wDvzNAvS0QrgbZDzfMFstxbB78X0a6IpCvleGX9XueesErgBBapuNEVwrZauN4Z
 IpuvtdjNk0WU0Kxu87kPa2wl5Iu/NQ8kGXtgYQ/rc0nqMNnxHRSpoPo9TL/cSIYhNvYy
 CzEg==
X-Gm-Message-State: AOAM532LNtafXtgVn3u+spk8nCjpqgqnSX5E9Uazdm1CTZCIVn3zuDVF
 FkAmU3V1NTq3+v9e4BSv0qkfGaSdWhc=
X-Google-Smtp-Source: ABdhPJyt0D2SPSy4TRCwArev+vDP6/xOnwZHh0gL29yeX3W8s04LKQemhuaV6ohMalhG4zvppN89EQ==
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr8163057wrn.83.1599066595610; 
 Wed, 02 Sep 2020 10:09:55 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id f3sm389733wmb.35.2020.09.02.10.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 10:09:54 -0700 (PDT)
Subject: Re: hw/clock: What clock rate for virt machines?
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>
References: <bbdacc80-a321-5f06-e430-973a38e7e037@amsat.org>
 <CAFEAcA8mwjWP-KhJ5bp_Qo_h81Mt_yn8k_5oepgMas9COBQgWQ@mail.gmail.com>
 <f7b28480-c841-f0d7-a848-b5f1775ec12d@amsat.org>
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
Message-ID: <51b5d8aa-4676-b8e4-1b42-710694e58188@amsat.org>
Date: Wed, 2 Sep 2020 19:09:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f7b28480-c841-f0d7-a848-b5f1775ec12d@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.324,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+PPC folks

On 9/2/20 7:03 PM, Philippe Mathieu-Daudé wrote:
> On 9/2/20 6:49 PM, Peter Maydell wrote:
[...]
>> Incidentally the serial.c API seems to be slightly confused
>> about the difference between setting the baudbase as a value
>> in bps (ie the traditional 9600, 115200, etc values) or a
>> frequency (where 115200 bps corresponds to a 1.8432MHz clock,
>> apparently). Luckily nobody uses the serial_set_frequency()
>> function :-)
> 
> Yes, it is a mess, I'm trying to not give up cleaning it.
> 
> Note, some boards correctly set the frequency:
> 
> musicpal, omap1 based, kzm, pxa2xx, boston.
> 
> lasi / jazz use an unlikely 8MHz clock.
> 
> For ppc405 I'm not sure this is an odd case:
>   99MHz / 248 = 399193.54838709677419354838

Or 12.375MHz / 31

But it is not a common xtal freq:

https://en.wikipedia.org/wiki/Crystal_oscillator_frequencies

> 
> Thanks!
> 
>>
>> thanks
>> -- PMM
>>
> 

