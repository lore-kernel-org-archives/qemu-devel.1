Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD61C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 21:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770D52080C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 21:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfMxUSbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770D52080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK7VU-0006oe-LH
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 17:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jK7UU-0006Ec-NY
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 17:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jK7UT-00075B-A5
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 17:35:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22126
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jK7UT-000720-6B
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 17:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585863308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=puRuY8bGQqCcPrcz9SV2fiKM2tAcb5s986aV68qC3LU=;
 b=NfMxUSbPlh3Y8f/LMVcHXXX1KOTaHZ51U9sf6jtfIOtQKSQrFEEQYKb+7Tlqe/LTidYBGN
 OnsQ046bfanfBaFNzAhPFUcarxODpbEeowKZnDWGbN10zf+WNyoqpdBikt7qfTOquLNPIa
 FNLBzyyfxW5GkRvfKDnUbHX4tKNgu4g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-D6MJwDYhPHi41Dt3bF7MEA-1; Thu, 02 Apr 2020 17:35:04 -0400
X-MC-Unique: D6MJwDYhPHi41Dt3bF7MEA-1
Received: by mail-wm1-f71.google.com with SMTP id t65so1920021wmf.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 14:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VIJ16VEm0PgAgSkDo+s+Z8ERsCOSLyUsQEPtdm+Yex0=;
 b=cvBFmG3SmP/IVyuVeLt6HmgpfGfq+Duo5XfUdOxKS3eVdnchEXzJDL/FhT6cZ5/uva
 DphYJSa1DpOGy8hxhxaLVLzTjwjSLPROr6XQsCCXgqfb63B4ZLhspEO0qo5bCNZ4hOv7
 40kSFoATihbNYjCKDR2v/3WgE+oImTWXSJdDYdBcYUq8NmBRWJnVlLC6/TtHMBRWEHvB
 ocLRSL0HjJax2RWFS6PG/nzXSoX+JZPY77ONB3VXQCUlTphCkXBhWgtfFdM17mn2OmfT
 0RFgc767sishqsB+1DM4lMg30wJsbtuVxTCoWok2HLrnMKWIV19li4c6bZXTopTQPWwM
 hvSw==
X-Gm-Message-State: AGi0PuaGmtrXTRUUa/bTHBJhYr0Kw8DCf4C0c6EhLkKwB6vjhC75fAAT
 q4ZKldJ2ZDEx+57p0D95+nDfV3e5tTEnm051Qm7IXiEKIDo9AhDuiSSFhupayDFfAMGjDqMreS/
 t/AzlpFiheB38kV8=
X-Received: by 2002:adf:dfc6:: with SMTP id q6mr5117410wrn.325.1585863302978; 
 Thu, 02 Apr 2020 14:35:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypIld+W/TDI/UnWcHnxfT0RZOChyUOEy8i/iMT2NVDIWgPqKjk7Gsc8Z96fCbKvuZmJR6d6E9Q==
X-Received: by 2002:adf:dfc6:: with SMTP id q6mr5117393wrn.325.1585863302775; 
 Thu, 02 Apr 2020 14:35:02 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id y1sm1302877wmd.14.2020.04.02.14.35.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 14:35:02 -0700 (PDT)
Subject: Re: [PATCH] hw/core: properly terminate loading .hex on EOF record
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200401193849.14017-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1911f95f-3a51-d4fa-59c7-ff5e7ecd5452@redhat.com>
Date: Thu, 2 Apr 2020 23:35:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200401193849.14017-1-alex.bennee@linaro.org>
Content-Language: en-US
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
Cc: peter.maydell@linaro.org, joel@jms.id.au, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/1/20 9:38 PM, Alex Benn=C3=A9e wrote:
> The https://makecode.microbit.org/#editor generates slightly weird
> .hex files which work fine on a real microbit but causes QEMU to
> choke. The reason is extraneous data after the EOF record which causes
> the loader to attempt to write a bigger file than it should to the
> "rom". According to the HEX file spec an EOF really should be the last
> thing we process so lets do that.
>=20
> Reported-by: Ursula Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>   hw/core/loader.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index eeef6da9a1b..8bbb1797a4c 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1447,6 +1447,7 @@ typedef struct {
>       uint32_t current_rom_index;
>       uint32_t rom_start_address;
>       AddressSpace *as;
> +    bool complete;
>   } HexParser;
>  =20
>   /* return size or -1 if error */
> @@ -1484,6 +1485,7 @@ static int handle_record_type(HexParser *parser)
>                                     parser->current_rom_index,
>                                     parser->rom_start_address, parser->as=
);
>           }
> +        parser->complete =3D true;
>           return parser->total_size;
>       case EXT_SEG_ADDR_RECORD:
>       case EXT_LINEAR_ADDR_RECORD:
> @@ -1548,11 +1550,12 @@ static int parse_hex_blob(const char *filename, h=
waddr *addr, uint8_t *hex_blob,
>           .bin_buf =3D g_malloc(hex_blob_size),
>           .start_addr =3D addr,
>           .as =3D as,
> +        .complete =3D false
>       };
>  =20
>       rom_transaction_begin();
>  =20
> -    for (; hex_blob < end; ++hex_blob) {
> +    for (; hex_blob < end && !parser.complete; ++hex_blob) {
>           switch (*hex_blob) {
>           case '\r':
>           case '\n':
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


