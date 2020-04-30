Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF2FC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9771F20575
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJGUD/NH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9771F20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU2qY-0007gP-ND
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 02:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU2pN-0006YH-JS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU2mq-0005PV-PI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:37:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24056
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU2mq-0005PL-B0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588228506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7hxsEGlMcqmrdcW8MsspY5UAn6B4BTNZZwlBJ+lezE=;
 b=FJGUD/NH9FOvpfefjVe5lUIalXj9Z6yQgCK8dVg7Q2zwUMD2n4UCYD9hYcCCbyAKeCJB9t
 FLU/XlKmWo3RtvUN1S3AuAMrPUzf/6hneyqnUYCh+AzPyaJSpsH16A5BNtj3vbjojIVa8V
 Teazv8Uo1tIYQT2GxOD1qNE3PVqun5g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-pHThY8ewNmWzL6m2xdHszg-1; Thu, 30 Apr 2020 02:35:05 -0400
X-MC-Unique: pHThY8ewNmWzL6m2xdHszg-1
Received: by mail-wm1-f70.google.com with SMTP id l21so364633wmh.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 23:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BW973fD/3TQOYjjZNhqsJsfv/dOrY3vLV0vuM12YZC8=;
 b=o3DeOaQX01m/TmgITUKSFmoomw4zuf4C264wQsG3HvqSAZI15Uw8ZEzXey1DIKXTLY
 VLUuQ1MuOhSxKSPeiH28WlrT6TCIn+vHdX79TpSBQJF25eDwBDFdz1/YAuju/h+xhqZx
 dhieWdrd5VXXYvVuWRW7jJsBnhfrCsiqjYmop1LfJ5llARaVuJgXcHJLK94C56C+n2iP
 TmyYkddOfrSPk+xKvj/9yXT4RxCDVlGvPkw6UDVuLR5+sxxR7kfVJttNhIp+LmwaWIjM
 fn+nvZnRJPWFHNUMP3o6UaDLykQWXYjIDlLiboqMnmevimrLOBU3HBRrBHh50l9eLtDJ
 AP8Q==
X-Gm-Message-State: AGi0Puaicq9yrnGPfiQHanwvOi0RXZ69N2A5+5u6TQYJSzQpL0TcNLQi
 74eFJloT1uy6l7QiSEVmxlfrdapn6bnv9lcH2Qb0YRIaQstSOb7uOsxjk9C8hFlYGs0XEXUpSss
 ApkgyEWd5hGsHVik=
X-Received: by 2002:adf:ffcd:: with SMTP id x13mr1971424wrs.11.1588228504298; 
 Wed, 29 Apr 2020 23:35:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypLq5FGEkqgPJt0731t7owUNPIWnja4ZLOGu9xM3g9A4n0evPy6hpe7jSoao0CjPEAl7Gi8K4Q==
X-Received: by 2002:adf:ffcd:: with SMTP id x13mr1971384wrs.11.1588228504001; 
 Wed, 29 Apr 2020 23:35:04 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id p16sm2440769wro.21.2020.04.29.23.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 23:35:03 -0700 (PDT)
Subject: Re: [PATCH v3 04/15] acpi: drop pointless _STA method
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-5-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d5821b18-93e4-74ae-ed27-1decc402e1e2@redhat.com>
Date: Thu, 30 Apr 2020 08:35:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429140003.7336-5-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:31:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 3:59 PM, Gerd Hoffmann wrote:
> When returning a constant there is no point in having a method
> in the first place, _STA can be a simple integer instead.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/i386/acpi-build.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 23c77eeb95a9..3a046b03e4cd 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1151,14 +1151,11 @@ static Aml *build_kbd_device_aml(void)
>   {
>       Aml *dev;
>       Aml *crs;
> -    Aml *method;
>  =20
>       dev =3D aml_device("KBD");
>       aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0303")));
>  =20
> -    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_return(aml_int(0x0f)));
> -    aml_append(dev, method);
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
>  =20
>       crs =3D aml_resource_template();
>       aml_append(crs, aml_io(AML_DECODE16, 0x0060, 0x0060, 0x01, 0x01));
> @@ -1173,14 +1170,11 @@ static Aml *build_mouse_device_aml(void)
>   {
>       Aml *dev;
>       Aml *crs;
> -    Aml *method;
>  =20
>       dev =3D aml_device("MOU");
>       aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0F13")));
>  =20
> -    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_return(aml_int(0x0f)));
> -    aml_append(dev, method);
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
>  =20
>       crs =3D aml_resource_template();
>       aml_append(crs, aml_irq_no_flags(12));
> @@ -2238,9 +2232,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                                              TPM_CRB_ADDR_SIZE, AML_READ_=
WRITE));
>           aml_append(dev, aml_name_decl("_CRS", crs));
>  =20
> -        method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
> -        aml_append(method, aml_return(aml_int(0x0f)));
> -        aml_append(dev, method);
> +        aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
>  =20
>           tpm_build_ppi_acpi(tpm, dev);
>  =20
>=20


