Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68726C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3226E2078C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SULbWsvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3226E2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKJsl-0000gq-DH
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 06:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKJp0-0004yf-8K
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKJoz-0006wv-3g
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:45:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21685
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKJoz-0006wX-07
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585910708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+ghZb6Eun+5bzjnQXBt9RQ99kAffUM+xGHK/9RPTXNA=;
 b=SULbWsvLH56GsOHlOQT/8BTVKwfRYT2nlWvfC6qmtlYfhf6uWql8dE4Y3zdApJ1N7AknX+
 saWnC7m/jZPKFOvUGRpIfOja4KQeAgm5Wm3mpLsFx7CcGJ0OsN3J4frZRhiF1gSHrKDt6B
 kv8xKD7pyisyDe27ad04Vb+ZOj4+FC0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-9Nw6xPcbPpCS9CB3Y39nlw-1; Fri, 03 Apr 2020 06:45:06 -0400
X-MC-Unique: 9Nw6xPcbPpCS9CB3Y39nlw-1
Received: by mail-ed1-f71.google.com with SMTP id f11so5131692edc.4
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 03:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ozMZ/amXSNgxmyQ0H4QXomcX4f7o5imAO8qQjN8vcqg=;
 b=Gn01N8z1exwF3MXzBs7X0r1y4vMnl3pMhlBBXvYdRutPpk0Q5r/NzHyH06GGVsgMou
 /gacE0TvJNv1qK8nC+52cnvOPwW9cudZ22PuB40Sc44l3sbXagCkQR/7f6HQKCUc2d36
 CNbgh9K68t5sqJlf2cENLvYFdLnTBGT8PXlLwRBsDRcacyh8EIVkY2LHAVQnZLWcLuND
 ybxk4MWRGTWY57aMe5ymZW/aBj1jtNrjdZsgRFbUKOkJlxr2HwyZYnUXC9nnZmFNM8rc
 ZSX2dNBjxiz2+SoeCTzochdj8doL94zmYu5aUpwQVtVsXeUSBCdP1RIwm4hHoGc4pFel
 +RkA==
X-Gm-Message-State: AGi0PuYDNO4jwrScQBVrmTXiy8YF3ONtNFsDUD5pl+8TXv6ARRlhtxE7
 O47o6Riyw8OxM+t8WDkY/Ef4l/pPVZlVyw+Pl4XRRx8PbS+m1Vg/45bDSXtjtKDdNbSNKWlL2gZ
 NcyswYVFminKJXIc=
X-Received: by 2002:a50:cb84:: with SMTP id k4mr7121571edi.89.1585910705389;
 Fri, 03 Apr 2020 03:45:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypKcTgFKWQlSsxSLi1XNOlCRRzZzDJMo9/9ddk6lh/0CRXN/hhMWE0BfPYrprdSWdLxfd2A11Q==
X-Received: by 2002:a50:cb84:: with SMTP id k4mr7121554edi.89.1585910705147;
 Fri, 03 Apr 2020 03:45:05 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id fx19sm1593473ejb.6.2020.04.03.03.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 03:45:04 -0700 (PDT)
Subject: Re: [PATCH for-5.0 v2 1/3] acpi: Use macro for table-loader file name
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, eric.auger@redhat.com,
 imammedo@redhat.com
References: <20200403101827.30664-1-shameerali.kolothum.thodi@huawei.com>
 <20200403101827.30664-2-shameerali.kolothum.thodi@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1c76c584-0c21-c88f-323f-6154f0caf1a9@redhat.com>
Date: Fri, 3 Apr 2020 12:45:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200403101827.30664-2-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, mst@redhat.com,
 david@redhat.com, dgilbert@redhat.com, xuwei5@hisilicon.com,
 linuxarm@huawei.com, shannon.zhaosl@gmail.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 12:18 PM, Shameer Kolothum wrote:
> Use macro for "etc/table-loader" and move it to the header
> file similar to ACPI_BUILD_TABLE_FILE/ACPI_BUILD_RSDP_FILE etc.
>=20
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   hw/arm/virt-acpi-build.c    | 2 +-
>   hw/i386/acpi-build.c        | 2 +-
>   include/hw/acpi/aml-build.h | 1 +
>   3 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 7ef0733d71..81d41a3990 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -929,7 +929,7 @@ void virt_acpi_setup(VirtMachineState *vms)
>  =20
>       build_state->linker_mr =3D
>           acpi_add_rom_blob(virt_acpi_build_update, build_state,
> -                          tables.linker->cmd_blob, "etc/table-loader", 0=
);
> +                          tables.linker->cmd_blob, ACPI_BUILD_LOADER_FIL=
E, 0);
>  =20
>       fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog=
->data,
>                       acpi_data_len(tables.tcpalog));
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2a7e55bae7..23c77eeb95 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -3043,7 +3043,7 @@ void acpi_setup(void)
>  =20
>       build_state->linker_mr =3D
>           acpi_add_rom_blob(acpi_build_update, build_state,
> -                          tables.linker->cmd_blob, "etc/table-loader", 0=
);
> +                          tables.linker->cmd_blob, ACPI_BUILD_LOADER_FIL=
E, 0);
>  =20
>       fw_cfg_add_file(x86ms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
>                       tables.tcpalog->data, acpi_data_len(tables.tcpalog)=
);
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index de4a406568..0f4ed53d7f 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -13,6 +13,7 @@
>   #define ACPI_BUILD_TABLE_FILE "etc/acpi/tables"
>   #define ACPI_BUILD_RSDP_FILE "etc/acpi/rsdp"
>   #define ACPI_BUILD_TPMLOG_FILE "etc/tpm/log"
> +#define ACPI_BUILD_LOADER_FILE "etc/table-loader"
>  =20
>   #define AML_NOTIFY_METHOD "NTFY"
>  =20
>=20


