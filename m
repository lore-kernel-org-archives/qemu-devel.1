Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525FCC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C1E720732
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6SJI0Ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1E720732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95My-0004Ot-A1
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k94p6-0005Nk-LP; Fri, 21 Aug 2020 07:03:04 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53623)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k94p4-0006SC-S1; Fri, 21 Aug 2020 07:03:04 -0400
Received: by mail-wm1-x341.google.com with SMTP id u18so1427862wmc.3;
 Fri, 21 Aug 2020 04:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BqyZ7CAmD63t7T22Vj5I6SXpsad92zDeG6KVd4AtduU=;
 b=t6SJI0Ef5qaWA2of06HMPP4Sc7bzs4aAFbjUzdxS6r5JCARQBnPXVVD3ttKZq/4gZl
 saKIAQN2hbTl/Hs9FEc0Z4rolXTYWyjLDkPhqCOeRi5eHhoVz1qYg2wwVGymz2yZIlv9
 ZKRCuYvfEO9S4qA+sJLfyPJ2x8JmFjq2tznr5oK2LdEIP0RVm2seOIzazSaP2+T3UUYe
 pw12/CHTosKVlITXHVG0Zc17XlM8BacoXM81VRZlEnLTRIZcDDQTyAUdamNhQ/v2sY4e
 o9LPrXMHv/x/5xWEMzVmz4A9p2TBkgbZNGr5SzK1vOt7+NdZ2cg38ih9/vCp7+B87/4W
 yeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=BqyZ7CAmD63t7T22Vj5I6SXpsad92zDeG6KVd4AtduU=;
 b=L9o0wIxcHs/F2kcmGj4VxFiq8NLtcW8kQI06EfyJBP5tiMNpGjDTTbVYtUPKUrFYY9
 eafyZntRXFc99Jzt83IY9r4DrMsYeig05xlfXx99FDZaLAlV2nrvcfcbhy1OHPt5it3y
 JGSqV+wEeOZQ1C+t7l62qhjjglbI00fQ6qxP2if6sbQDzQ1xbflSeWzYQxeNhUAuL7F5
 9OvIbxoKh9ts5Bkl/OJ+Nwd/+MrNFJnyLr3XIvfG3Fu5+kFNghZxJnfh1attq1Sd9U7/
 RqcHufpPvJR4XjbjqV2PklrhyUeLw4RoZeEZWs+mkLhAyqPs28QMUGgqLEA8YhOKENAy
 K/vA==
X-Gm-Message-State: AOAM533ACGLormLtiIRvL9zsVQh3UWX3wrwOhCYfA75Y9uhdXyvTRl9G
 MxH516qVmv2qeOad+G+AFyY=
X-Google-Smtp-Source: ABdhPJy8i6FabpK97eSy+VdpccWPI2Uzhk8lxRf0spSft19OiQEHIxzfeRnKA3ki3hS1gkCnw/4byg==
X-Received: by 2002:a7b:c5d0:: with SMTP id n16mr3138037wmk.7.1598007781188;
 Fri, 21 Aug 2020 04:03:01 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id d21sm4613628wmd.41.2020.08.21.04.02.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 04:03:00 -0700 (PDT)
Subject: Re: [PATCH v1 0/2] pc-bios: petalogix: Re-generate DTB and add DTS
 files
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200820194342.1292611-1-edgar.iglesias@gmail.com>
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
Message-ID: <59239d83-7d52-897a-95cd-5916531461b3@amsat.org>
Date: Fri, 21 Aug 2020 13:02:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820194342.1292611-1-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Edgar,

On 8/20/20 9:43 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> This adds missing device-tree source files for the petalogix boards
> with recompiled DTBs.
> 
> Cheers,
> Edgar
> 
> Edgar E. Iglesias (2):
>   microblaze: petalogix-ml605: Add device-tree source
>   microblaze: petalogix-s3adsp1800: Add device-tree source
> 
>  pc-bios/petalogix-ml605.dtb      | Bin 9982 -> 9882 bytes
>  pc-bios/petalogix-ml605.dts      | 350 +++++++++++++++++++++++++++++++
>  pc-bios/petalogix-s3adsp1800.dtb | Bin 8259 -> 8161 bytes
>  pc-bios/petalogix-s3adsp1800.dts | 282 +++++++++++++++++++++++++
>  4 files changed, 632 insertions(+)
>  create mode 100644 pc-bios/petalogix-ml605.dts
>  create mode 100644 pc-bios/petalogix-s3adsp1800.dts
> 

I suppose the test_microblaze_s3adsp1800() test in
tests/acceptance/boot_linux_console.py has the dtb embedded after the
kernel.

Do you mind adding another test explicitly using this dtb?
That would cover any further changes in these files.

Also, can you add a test for the kc705 EVB (and previous)
boards as you suggested here?
https://www.mail-archive.com/qemu-devel@nongnu.org/msg605124.html

I already added a test for the cris/etraxfs board, will send
it soon. Well you might wait for it and use it as template too.

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


