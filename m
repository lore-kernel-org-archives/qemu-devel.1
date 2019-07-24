Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81D9C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 06:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79331227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 06:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeuZ2PCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79331227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqAXk-0007gn-JH
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 02:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53423)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <liq3ea@gmail.com>) id 1hqAXa-0007I3-IF
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 02:14:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1hqAXZ-0000rF-H3
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 02:14:18 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hqAXZ-0000qb-A5
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 02:14:17 -0400
Received: by mail-oi1-x244.google.com with SMTP id m202so34204735oig.6
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 23:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LUWBbDI1llUWzonTNUFk9JIcoW8lUkTxzj/0DpqokOg=;
 b=TeuZ2PCdgBxuDMZP0OKPQa+9YV/2JB/wozK/ALSlYJjcbeFMvHrAKaVkl70JOZAc9x
 p9v7GP+T/TeNcNF3nihkNFIuy9IvACD+46Mf7HJReWa6MmoxUCJYwwQnexKS1fXkt9Yo
 /zynWvC4pQMChPIAaDvL+Za0kZ+Kh4nxiGv+rrVHV2au1vTqHVAEcX+BQ/hudDOs3933
 9MB4jPcGusNFwIkaagqMBaxtLCCfByIEc8Lj+Cqxu+uf6knMTEtOCXALTUrS3QGzazdd
 XcZNYsTESSPQLlCG0u+wdH91ZiN8CxOR8mbzy9vE4m33MjqVOjDa+5KJ2nsJq4Y3eAi8
 Kq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LUWBbDI1llUWzonTNUFk9JIcoW8lUkTxzj/0DpqokOg=;
 b=Rlv2OtAIRgFMrfkI3XMtYsi6rQecEcy2a0tXW5mr1TRLnw2SeaBkcvsD04ZaSSv7/4
 Hkmdl8DycvGSW8Tyu/X3l/c8CUWQLHDK4wZfp1ZJDfPlRjeAY9l1LsG+0enR5noaODUl
 fIXtGPMzbomqDMQy5ELnQdmLGAtyj1PoBCQiTyCnxKBW/MT+TpEYN1T78Lz1G+Qqk3/z
 zmYBW9G0XI+Uh7ni4LYPpZ22ppcYB4gaXswS+mQYqyqO4Jj4vzgBgZipMeJ+SH1vXgNt
 unL51UvYWtXPyGktBfpFr3dW2iJI5ggce/wtSRrrsMFCjEwkwLJ11offyMNoFqxfX3tf
 Db8A==
X-Gm-Message-State: APjAAAUEryC/H5XY1M3FdI3y9ijBkG8A3OTdkzwTOsxq4pam/eQgjnZL
 QqeA43wgoUsHscbBCHjxxGhplWTI3eOlLppQTIc=
X-Google-Smtp-Source: APXvYqw31hkDbEDxjekleKdvzpkTV2rrYoK0knhSuI/cBl26ROpAJkvnmGAqfU32cv3yHUwAQh1rNGgoPANE54PHhPQ=
X-Received: by 2002:aca:3602:: with SMTP id d2mr36848870oia.150.1563948856414; 
 Tue, 23 Jul 2019 23:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190723160859.27250-1-imammedo@redhat.com>
In-Reply-To: <20190723160859.27250-1-imammedo@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 24 Jul 2019 14:13:40 +0800
Message-ID: <CAKXe6SK58sLQ98VOACi+K=UC4XG-LSN89WBsAn4DQivtDf-VPg@mail.gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] pc-dimm: fix crash when invalid slot
 number is used
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Igor Mammedov <imammedo@redhat.com> =E4=BA=8E2019=E5=B9=B47=E6=9C=8824=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:09=E5=86=99=E9=81=93=EF=BC=9A

> QEMU will crash with:
>   Segmentation fault (core dumped)
> when negative slot number is used, ex:
>   qemu-system-x86_64 -m 1G,maxmem=3D20G,slots=3D256 \
>       -object memory-backend-ram,id=3Dmem1,size=3D1G \
>       -device pc-dimm,id=3Ddimm1,memdev=3Dmem1,slot=3D-2
>
> fix it by checking that slot number is within valid range.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/mem/pc-dimm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index b1239fd0d3..29c785799c 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -38,6 +38,13 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState
> *machine,
>
>      slot =3D object_property_get_int(OBJECT(dimm), PC_DIMM_SLOT_PROP,
>                                     &error_abort);
> +    if ((slot < 0 || slot >=3D machine->ram_slots) &&
> +         slot !=3D PC_DIMM_UNASSIGNED_SLOT) {
> +        error_setg(&local_err, "invalid slot number, valid range is [0-%=
"
> +                   PRIu64 "]", machine->ram_slots - 1);
> +        goto out;
> +    }
> +
>      slot =3D pc_dimm_get_free_slot(slot =3D=3D PC_DIMM_UNASSIGNED_SLOT ?=
 NULL :
> &slot,
>                                   machine->ram_slots, &local_err);
>      if (local_err) {
> --
> 2.18.1
>
>
>
