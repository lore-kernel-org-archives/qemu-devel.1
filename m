Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E359C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:11:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC642072D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGHgwwiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC642072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6avY-0001uJ-4M
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6apB-0006QW-BE
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6ap7-0005Bt-KG
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60009
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6ap7-0005Bc-GD
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582639472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=40OE/qVOCZxLzmdwYxW8Sc/Tnp2Mxil5cjFkRfrKVVU=;
 b=UGHgwwiOXMlVH1IJs1ttOIB9nUd1NICDt7lQa9Gl8TANE7c4PJbylvw9HMpCGd5IETMUeY
 ksUaCw8zn1oerUBGibqbx6f+ImBB2O0yRXBTF/vc+lc18OzukElIsB1dq1/QAhlshmE/gP
 k+zMFIaAM/K+pMD4pWPqxsg+Rhb0FNw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-R4QX7mnZO-CfWMo_HWfHSQ-1; Tue, 25 Feb 2020 09:04:28 -0500
X-MC-Unique: R4QX7mnZO-CfWMo_HWfHSQ-1
Received: by mail-wm1-f69.google.com with SMTP id b205so1075734wmh.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QpQVC0YTSnpItE3bP6VKj3X+7+Htj34XxGnUJIbpLOw=;
 b=c36DMYl3Q91uxS6/vL26BFczgU126aUBXOf9Y63gvF2aYZ9RBzb3Sp7+UT32OF2uZc
 EueHhGFdVPXx/hlub53ahWKKUwjI0b5WBzax1vDSFbeka73vBQ0VS0OB9ZdtJHhLsJAJ
 JzKPWNh0wljfqY+HB6rPt4tEF2vQNqQ1kYzPmYXZA5pyWXU7wzDgsuwV3xUx1KJyBk7D
 SxfOZc1/LBoP9fmjqZCjunCi2O18n/g8Ygd3uJSYP5x/2NbEVB28jMluRJYhxefxmMMO
 HLMIWokHjl9Vb2qCCg3GCcMdH40zPH+97JUGNf78128McpMKfXCKhkCxPM3Yn1QelJ63
 7cOg==
X-Gm-Message-State: APjAAAU7nklGhCUKFkn2NugreJmxtF1c6DTugFeoPCnl1/hin+ApAUFv
 DF1gjHjKQfrJ2a1sR8cVX2aZG8Mi4ga3MFRVDJReOuqISjg0RuQ+81dIocVntUWpjVFAz2KsjiZ
 wOqZ614upnl4L9Eo=
X-Received: by 2002:a1c:59c6:: with SMTP id n189mr5441543wmb.178.1582639467066; 
 Tue, 25 Feb 2020 06:04:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXBvoa5Ej3WKhj5Z1JvqBsxf10MYOfHZ5MFR/HIa0Ac/wsdqsPpPW6CAnX0EGx4bcnPnmiIQ==
X-Received: by 2002:a1c:59c6:: with SMTP id n189mr5441514wmb.178.1582639466819; 
 Tue, 25 Feb 2020 06:04:26 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f62sm4552538wmf.36.2020.02.25.06.04.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 06:04:26 -0800 (PST)
Subject: Re: [PATCH v3 13/19] qemu/bitops.h: Add extract8 and extract16
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200225124710.14152-1-alex.bennee@linaro.org>
 <20200225124710.14152-14-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6c91fde6-7aa9-2fb7-779c-4c5fe3139ee7@redhat.com>
Date: Tue, 25 Feb 2020 15:04:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225124710.14152-14-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org,
 f4bug@amsat.org, robhenry@microsoft.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>, marcandre.lureau@redhat.com,
 aaron@os.amperecomputing.com, cota@braap.org, stefanha@redhat.com,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 1:47 PM, Alex Benn=C3=A9e wrote:
> From: Yoshinori Sato <ysato@users.sourceforge.jp>
>=20
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20190607091116.49044-10-ysato@users.sourceforge.jp>

^ This tag can go.

> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20200212130311.127515-3-ysato@users.sourceforge.jp>
> ---
>   include/qemu/bitops.h | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
>=20
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index 02c1ce6a5d4..f55ce8b320b 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -301,6 +301,44 @@ static inline uint32_t extract32(uint32_t value, int=
 start, int length)
>       return (value >> start) & (~0U >> (32 - length));
>   }
>  =20
> +/**
> + * extract8:
> + * @value: the value to extract the bit field from
> + * @start: the lowest bit in the bit field (numbered from 0)
> + * @length: the length of the bit field
> + *
> + * Extract from the 8 bit input @value the bit field specified by the
> + * @start and @length parameters, and return it. The bit field must
> + * lie entirely within the 8 bit word. It is valid to request that
> + * all 8 bits are returned (ie @length 8 and @start 0).
> + *
> + * Returns: the value of the bit field extracted from the input value.
> + */
> +static inline uint8_t extract8(uint8_t value, int start, int length)
> +{
> +    assert(start >=3D 0 && length > 0 && length <=3D 8 - start);
> +    return extract32(value, start, length);
> +}
> +
> +/**
> + * extract16:
> + * @value: the value to extract the bit field from
> + * @start: the lowest bit in the bit field (numbered from 0)
> + * @length: the length of the bit field
> + *
> + * Extract from the 16 bit input @value the bit field specified by the
> + * @start and @length parameters, and return it. The bit field must
> + * lie entirely within the 16 bit word. It is valid to request that
> + * all 16 bits are returned (ie @length 16 and @start 0).
> + *
> + * Returns: the value of the bit field extracted from the input value.
> + */
> +static inline uint16_t extract16(uint16_t value, int start, int length)
> +{
> +    assert(start >=3D 0 && length > 0 && length <=3D 16 - start);
> +    return extract32(value, start, length);
> +}
> +
>   /**
>    * extract64:
>    * @value: the value to extract the bit field from
>=20


