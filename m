Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C094C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:40:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA24E208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 08:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mo2M/+N1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA24E208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9m3R-0008Cb-2m
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 03:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48206)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9m2g-0007g5-Hs
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9m2f-000200-Ec
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:39:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49056
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9m2f-0001zp-B2
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 03:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583397581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEyTdVtWjwAaVkmYGwSQA81sQIQR/wvceP+c2qXs7gQ=;
 b=Mo2M/+N1QfBW57EwCqxS4gRkw/BlGZOTO/p2RHY8vnR3y0fd1HXVw0Trx1KT8frderl0Rk
 Yz8M7osVGhRwscNIQ2nhLAlYsXthqajMbS7SkTRnE2Gwi8/LV/qB5Q2lvEFchSFccRYQe+
 VfAEZkNuEHHUfQAmYS8ZaJHfZmyw1bo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-LkHrzJb0M9SGKuE-QmSmLQ-1; Thu, 05 Mar 2020 03:39:37 -0500
X-MC-Unique: LkHrzJb0M9SGKuE-QmSmLQ-1
Received: by mail-ed1-f71.google.com with SMTP id d11so3798935eds.7
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 00:39:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ECqh01k5JDu2W+cNW6wJLuhKsyXjVUO9M8nOen93SH0=;
 b=Cpst4qRYS/gY7sr0XVb07uBwFnZfEdjs3z8WfUvw+wGgi5xeg/Ob2mUcOi5v/hK+9V
 FP+VqA8/kIalrzwMsBpshAaTvWuZ4RmNmwk0wPllqp58BhXNZ2A+9ddFZmtwTH4pFfPg
 oVnrTabqZKRE6qSe0br4kprQM/gmAp4u564uvbilcLORyseDjFdgMi8qVmXAVtLziuEx
 R3Q3kiEAdHLR1cEUc9z+cgW4zjet51LW7rXBni1Y24N+nxwIsTCrkHi3zkJMH3QTOLwC
 UNNGaMj0q5FZmLG0tmDpQcrO7nWXXOVbemGG8Rctips1RSvVTTudw14KgCAvUXWhl/jW
 m+Gw==
X-Gm-Message-State: ANhLgQ3vweFzawOruF0MitdYDpNcZMVhRfl3OVxlfF9xEQEWRGpYVCvL
 Cc4RZL55Fv56YPzHHXp2eBZ+NlqmR8JOIeIuDK0Vk0HsmktH3vWqiCjLFaMHK8SGexIqsXGbSiY
 9LUavk+IfsLVs8OI=
X-Received: by 2002:a17:906:b30f:: with SMTP id
 n15mr6319307ejz.236.1583397575924; 
 Thu, 05 Mar 2020 00:39:35 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtohzXn26XGcAqSGLXnylsC9k6WJOCEK8ieGo3twpVVzg51XRAvoxUxen045G1tEr+uIIyVNg==
X-Received: by 2002:a17:906:b30f:: with SMTP id
 n15mr6319274ejz.236.1583397575632; 
 Thu, 05 Mar 2020 00:39:35 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id o17sm8197edz.83.2020.03.05.00.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2020 00:39:35 -0800 (PST)
Subject: Re: [PATCH v7 12/17] spapr: Don't use weird units for MIN_RMA_SLOF
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 clg@kaod.org, qemu-devel@nongnu.org, groug@kaod.org
References: <20200303034351.333043-1-david@gibson.dropbear.id.au>
 <20200303034351.333043-13-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2c599e20-1f65-1127-1fc9-943641d086e8@redhat.com>
Date: Thu, 5 Mar 2020 09:39:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303034351.333043-13-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, aik@ozlabs.ru, farosas@linux.ibm.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Igor Mammedov <imammedo@redhat.com>, paulus@samba.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(sorry I missed that due to the change of series cover subject, I was=20
tracking "Fixes for RMA size calculation=E2=80=8B")

On 3/3/20 4:43 AM, David Gibson wrote:
> MIN_RMA_SLOF records the minimum about of RMA that the SLOF firmware
> requires.  It lets us give a meaningful error if the RMA ends up too smal=
l,
> rather than just letting SLOF crash.
>=20
> It's currently stored as a number of megabytes, which is strange for glob=
al
> constants.  Move that megabyte scaling into the definition of the constan=
t
> like most other things use.
>=20
> Change from M to MiB in the associated message while we're at it.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/spapr.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index cc10798be4..510494ad87 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -103,7 +103,7 @@
>   #define FW_OVERHEAD             0x2800000
>   #define KERNEL_LOAD_ADDR        FW_MAX_SIZE
>  =20
> -#define MIN_RMA_SLOF            128UL
> +#define MIN_RMA_SLOF            (128 * MiB)
>  =20
>   #define PHANDLE_INTC            0x00001111
>  =20
> @@ -2956,10 +2956,10 @@ static void spapr_machine_init(MachineState *mach=
ine)
>           }
>       }
>  =20
> -    if (spapr->rma_size < (MIN_RMA_SLOF * MiB)) {
> +    if (spapr->rma_size < MIN_RMA_SLOF) {
>           error_report(
> -            "pSeries SLOF firmware requires >=3D %ldM guest RMA (Real Mo=
de Area memory)",
> -            MIN_RMA_SLOF);
> +            "pSeries SLOF firmware requires >=3D %ldMiB guest RMA (Real =
Mode Area memory)",
> +            MIN_RMA_SLOF / MiB);
>           exit(1);
>       }
>  =20
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


