Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2B7C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 17:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2310206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 17:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcEC+XNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2310206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkW3D-0005IQ-2B
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 13:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkW2Z-0004ca-MR; Sun, 14 Jun 2020 13:03:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44963)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jkW2Y-0003RH-4e; Sun, 14 Jun 2020 13:03:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id y17so14676685wrn.11;
 Sun, 14 Jun 2020 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f18LcKocwUA4j+gn6LBL6lVopyy2KsPDBe64BcnOzyw=;
 b=AcEC+XNT1HHHcDQrAMqGaNdZkNS+GtLhcB483bjWKSDCvByl7dsUV0a2rfsZn/JAzx
 PKiFxiKtaBk82Ee1aQQgPitUQqWQu/VYqJBQMTIUD28l5hUsLpct4oaMvtNgk1F61Gf6
 ikMry2u9TOYVOjV2ttBzHbfmgNcxYWdLfq7pyDKkDv19/CUVw5GI0vDtmFtveeqLbEt3
 I7WTIIbBnxlvPfaNRbvoCb55x0psPBRPL8PAswVUlUxXLNmwOJ/H6LqhyvXYyqjIS/vR
 +qEc74kgKb1ca/rhcAA7J8BEnS2qCBHFaPHmekGYoK6cLbGKWJaBE4QZXo6s559qQuU6
 4J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=f18LcKocwUA4j+gn6LBL6lVopyy2KsPDBe64BcnOzyw=;
 b=OZJ72qC5HmmLxCVbgU2QxRc99KPfhxdhLWxsmgEyLdxjh7aJDCatKLmAaQL9wDS8Xq
 z0htENAJEabNvys6xyutSo3oouipvkMJF9j+vL8yBRySnSFMH0jXUutAg2p5+CXuyASp
 XMLbkKyq4Q18/HuYUMXAgJKviAHlDtxnT4+A9dtrjsA21klcKy/XLhXwGixPhetycdHm
 ilv1bJXskWU8FoKnJ57soIudNYtQFMmg4kxsVti2AaW7f2VvMp3RX9dDjKX9wYBVJ4P6
 1bEzDvwOObuWJgDak5O5QkCCAMKD09JhRVSUJcJvliIdeb7FpGmh8mcm8KtQaxPJsZYs
 vYNQ==
X-Gm-Message-State: AOAM531ra6UrGytjGTB4XsSjnOhZFyZz44YTBH9kCBZgKbdZUm6WTa/v
 8XEDIrmYiVKNsljOFJGRjBs=
X-Google-Smtp-Source: ABdhPJxx8LJLB7STAP8wX6tOtA/MfKPn49FDbykMnKYqU8ClzvAc19g5BfJCU54jU0PVGTTyCdzffQ==
X-Received: by 2002:a5d:68cb:: with SMTP id p11mr23845618wrw.379.1592154193729; 
 Sun, 14 Jun 2020 10:03:13 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id o20sm21656831wra.29.2020.06.14.10.03.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jun 2020 10:03:13 -0700 (PDT)
Subject: Re: [PATCH 18/22] mac_via: move VIA1 portB write logic into
 mos6522_q800_via1_write()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, laurent@vivier.eu, fthain@telegraphics.com.au
References: <20200614142840.10245-1-mark.cave-ayland@ilande.co.uk>
 <20200614142840.10245-19-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <734182d2-91f8-6799-e732-066f4b773d98@amsat.org>
Date: Sun, 14 Jun 2020 19:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200614142840.10245-19-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/20 4:28 PM, Mark Cave-Ayland wrote:
> Currently the logic is split between the mos6522 portB_write() callback and
> the memory region used to capture the VIA1 MMIO accesses. Move everything
> into the latter mos6522_q800_via1_write() function to keep all the logic in
> one place to make it easier to follow.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/misc/mac_via.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index 669fdca4c4..4779236f95 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -801,11 +801,21 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
>                                      unsigned size)
>  {
>      MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(opaque);
> +    MacVIAState *m = container_of(v1s, MacVIAState, mos6522_via1);

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>      MOS6522State *ms = MOS6522(v1s);
>  
>      addr = (addr >> 9) & 0xf;
>      mos6522_write(ms, addr, val, size);
>  
> +    switch (addr) {
> +    case VIA_REG_B:
> +        via1_rtc_update(m);
> +        via1_adb_update(m);
> +
> +        v1s->last_b = ms->b;
> +        break;
> +    }
> +
>      via1_one_second_update(v1s);
>      via1_VBL_update(v1s);
>  }
> @@ -1034,18 +1044,6 @@ static TypeInfo mac_via_info = {
>  };
>  
>  /* VIA 1 */
> -static void mos6522_q800_via1_portB_write(MOS6522State *s)
> -{
> -    MOS6522Q800VIA1State *v1s = container_of(s, MOS6522Q800VIA1State,
> -                                             parent_obj);
> -    MacVIAState *m = container_of(v1s, MacVIAState, mos6522_via1);
> -
> -    via1_rtc_update(m);
> -    via1_adb_update(m);
> -
> -    v1s->last_b = s->b;
> -}
> -
>  static void mos6522_q800_via1_reset(DeviceState *dev)
>  {
>      MOS6522State *ms = MOS6522(dev);
> @@ -1068,10 +1066,8 @@ static void mos6522_q800_via1_init(Object *obj)
>  static void mos6522_q800_via1_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> -    MOS6522DeviceClass *mdc = MOS6522_DEVICE_CLASS(oc);
>  
>      dc->reset = mos6522_q800_via1_reset;
> -    mdc->portB_write = mos6522_q800_via1_portB_write;
>  }
>  
>  static const TypeInfo mos6522_q800_via1_type_info = {
> 


