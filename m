Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52377C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199BA207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jsq8z6OL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199BA207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wk6-0003NT-8f
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3wjA-0002wO-W4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:51:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3wj7-0005VH-FN
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:51:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28284
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3wj7-0005V6-BT
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582008684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXu3dTJnGeCPNl6Wj3/I0DcBqHkkVxoLIUBttvTJ/MI=;
 b=Jsq8z6OL3JvigHxaSAb6wk8cy7a/sbE+fSru123zoUx20lrd8XJ5aoAGcK/acHmCZQz8GG
 N1p4CsqVslKGjmkEQITi8QRlIYA31Js20GVRLt39U8CMt7yxVdEFYtaRKY+8kpRTbLktIB
 0Vv+7/Ld19qvKGmHsH+1d/achHQSr84=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-am1ytdxYM-C-Ul_C2TdZVw-1; Tue, 18 Feb 2020 01:51:23 -0500
Received: by mail-wr1-f69.google.com with SMTP id j4so10287495wrs.13
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:51:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2UcbJiQ/7H1UBF3e3ZaiblHCql68Wni2pQ7N/Pryn2o=;
 b=F/xhzCllzNveiBwobUWtAeYloV4fCtDJF1YxIf3e4RQhXT08CAr0mpfhm4Uv41v0Ut
 N9008IhUOw+IVaVLPQfHiuoW/zSYYy1KT0z5vrexEKXopa1iSI3eH4tSYm3OSApo2nB3
 Jysl+OxD+S/0gEE19DOlFDYwwp5imGY01TwRd67hByKuAeIWk+uLVyV5NLRxWGHDymLB
 1KEirtGr91OloffxO712lDI3IAcTJFVV2NzLHRk2jyackw+7jbuPvrN0GmB5BMEKNJos
 0GkjdC4aqECAKrqyQOhp/brsK/yu9wbK4lSfEqzDtB3mbHx93Gf/i23qP5nxzjMWb1FA
 Zz2w==
X-Gm-Message-State: APjAAAXNOWEuln1YlhH+JP2TJXV/g/roxtJx2Qi6/JfE3Bs+YPc49l4V
 Bc6cn3ofJLtQ/i3eakQ8tiLuznR7kRnpVkRoBE2llEo/VkYPqXe3Y2Efb7cPszqwTjgXV9XWpH3
 Kw5tC26bLIufxvX8=
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr26470118wrw.126.1582008681900; 
 Mon, 17 Feb 2020 22:51:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUnP4W8SqTLyUHxEpNjhOmSMgjBALfho2all/3MP2CFGmCXvjOQyhUqnBexJvFcgFgQwNQ9w==
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr26470093wrw.126.1582008681671; 
 Mon, 17 Feb 2020 22:51:21 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id v17sm4585682wrt.91.2020.02.17.22.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 22:51:21 -0800 (PST)
Subject: Re: [PATCH v5 15/79] arm/imx25_pdk: drop RAM size fixup
To: Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-16-imammedo@redhat.com>
 <77939c6c-3781-a016-d023-a9aa0f580846@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <057e44ee-d444-4f31-e4df-d402e213c3b2@redhat.com>
Date: Tue, 18 Feb 2020 07:51:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <77939c6c-3781-a016-d023-a9aa0f580846@linaro.org>
Content-Language: en-US
X-MC-Unique: am1ytdxYM-C-Ul_C2TdZVw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, jcd@tribudubois.net,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 7:56 PM, Richard Henderson wrote:
> On 2/17/20 9:33 AM, Igor Mammedov wrote:
>>       /* We need to initialize our memory */
>>       if (machine->ram_size > (FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_=
SIZE)) {
>> -        warn_report("RAM size " RAM_ADDR_FMT " above max supported, "
>> +        error_report("RAM size " RAM_ADDR_FMT " above max supported, "
>>                       "reduced to %x", machine->ram_size,
>>                       FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE);
>> -        machine->ram_size =3D FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_=
SIZE;
>> +        exit(EXIT_FAILURE);
>=20
> The wording here doesn't make sense anymore.
> I think it would be better to mirror that used elsewhere:
>=20
> +        char *sz =3D size_to_str(mc->default_ram_size);
> +        error_report("Invalid RAM size, should be %s", sz);
> +        g_free(sz);
>=20
> With that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Agreed.
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


