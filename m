Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220A7C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E44F7206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIkcjhbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E44F7206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxya-0004yL-1A
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVxxJ-0003Rv-I0
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:49:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVxxI-0001PY-G9
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1TcJgozQS9VaKWjcm+I9P5JxgAHoMyCeu0LvRW6sgbo=;
 b=RIkcjhbKQrtBKLr1Cd5xtX8K8JD2sbiQR5Vs/IZj921STcuzoasmU1Qj8/jwHgpujcERV5
 ebpItpVCADxfZwTn+ul4+27zDrOWSmrdAcQ5E8Kc7ea2XhqgFuS1gIvqbAtlEsxHtPXjFR
 HrLNx9uAYy+kEpkcrkz492X1pyJmtrc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-prUkdPkLPrqAaDRTmhCVMg-1; Tue, 05 May 2020 09:49:49 -0400
X-MC-Unique: prUkdPkLPrqAaDRTmhCVMg-1
Received: by mail-wr1-f70.google.com with SMTP id 30so209872wrq.15
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+/bGB1RmLTcdGqhjZUkHv5EBcYBvR/brdQaAAsizQ6w=;
 b=fcX0DZUIMTjBwwlMzt+oMNr6vTRC5fuUFe4TX2UeYTrWGHfP6Bq0zuWjRh8A5YL65Y
 y/RbO4sMPc/YSTJvkT01KzjOCeubLhNyNYtFPbWbj4mGuFUu5jc8gznRRDj3oHxkM5d0
 +twy7BImA+oJ1ifS8+0sDfUzp3mwvnhBdjCniL/RTB5Pl1l0Jes3ejgXOdnkE2rI6V+b
 7eU6/3YbzOuHi5TP/4Ga1LBm5XbTze2lpKqzkh7MN5cglixLWvOdToE3caJiWHSVicGv
 vhMXP2k1E+ts8x5PSZr+soeYH7/CQfh6nJO3QjkIt3+nCopRWgYFL4WBXxc4zx7BAHhs
 GqAw==
X-Gm-Message-State: AGi0PuYeJjcYDlb/usXo4DPCc5eBnZ0r1KdIfoJIWKKHSj4xdPPpU3bD
 ssvRgboR2eOLJruL3t6ZYDGVGrul49smt4ERRE8ZTraWacBV9H+2qY3YFuJE6e5E5F/cKqEmaXQ
 WgdQ7W4TuwVvIsME=
X-Received: by 2002:adf:a35c:: with SMTP id d28mr3675913wrb.37.1588686587693; 
 Tue, 05 May 2020 06:49:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypLwi8y+eJcQSzR4tdRpHLEEtU7NLWYor3RQOGC/4ZVXhhhdEa4Zbs5WruWzpOOY1bcvFXHVwQ==
X-Received: by 2002:adf:a35c:: with SMTP id d28mr3675895wrb.37.1588686587478; 
 Tue, 05 May 2020 06:49:47 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id d133sm4354934wmc.27.2020.05.05.06.49.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 06:49:46 -0700 (PDT)
Subject: Re: [PATCH v2 04/13] acpi: move acpi_build_facs to acpi-common.c
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-5-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bb20fc46-da9d-b424-81de-d60c0332d4aa@redhat.com>
Date: Tue, 5 May 2020 15:49:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505134305.22666-5-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 3:42 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   hw/i386/acpi-common.h |  1 +
>   hw/i386/acpi-build.c  | 11 +----------
>   hw/i386/acpi-common.c |  7 +++++++
>   3 files changed, 9 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
> index 9cac18dddf5b..583c320bbe7d 100644
> --- a/hw/i386/acpi-common.h
> +++ b/hw/i386/acpi-common.h
> @@ -11,5 +11,6 @@
>   void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>                        X86MachineState *x86ms, AcpiDeviceIf *adev,
>                        bool has_pci);
> +void acpi_build_facs(GArray *table_data);
>  =20
>   #endif
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 4cce2192eeb0..a69b85a266e7 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -316,15 +316,6 @@ static void acpi_align_size(GArray *blob, unsigned a=
lign)
>       g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
>   }
>  =20
> -/* FACS */
> -static void
> -build_facs(GArray *table_data)
> -{
> -    AcpiFacsDescriptorRev1 *facs =3D acpi_data_push(table_data, sizeof *=
facs);
> -    memcpy(&facs->signature, "FACS", 4);
> -    facs->length =3D cpu_to_le32(sizeof(*facs));
> -}
> -
>   static void build_append_pcihp_notify_entry(Aml *method, int slot)
>   {
>       Aml *if_ctx;
> @@ -2417,7 +2408,7 @@ void acpi_build(AcpiBuildTables *tables, MachineSta=
te *machine)
>        * requirements.
>        */
>       facs =3D tables_blob->len;
> -    build_facs(tables_blob);
> +    acpi_build_facs(tables_blob);
>  =20
>       /* DSDT is pointed to by FADT */
>       dsdt =3D tables_blob->len;
> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
> index ab9b00581a15..5187653893a8 100644
> --- a/hw/i386/acpi-common.c
> +++ b/hw/i386/acpi-common.c
> @@ -154,3 +154,10 @@ void acpi_build_madt(GArray *table_data, BIOSLinker =
*linker,
>                    table_data->len - madt_start, 1, NULL, NULL);
>   }
>  =20
> +/* FACS */
> +void acpi_build_facs(GArray *table_data)
> +{
> +    AcpiFacsDescriptorRev1 *facs =3D acpi_data_push(table_data, sizeof *=
facs);
> +    memcpy(&facs->signature, "FACS", 4);
> +    facs->length =3D cpu_to_le32(sizeof(*facs));
> +}
>=20


