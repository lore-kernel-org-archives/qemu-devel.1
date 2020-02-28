Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4113C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3CE24691
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsCcw+j9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3CE24691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7d5C-0005U4-Qz
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32951)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j7d4T-0004fd-UT
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:40:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j7d4S-000340-SR
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:40:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36864
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j7d4S-000336-Ol
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:40:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582886440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjXZYgVMYS9HYhIynJ+DtQWdZtpQygbf+02zwFFdriI=;
 b=OsCcw+j93vwtoK5PNLH/4RnSchXqWOyfQA5nvyrOMUDLBzMb042tOF5p9mIo7rHz1rrZGi
 72kcSPnX2sWE0wYRs8WGapdIPHiGIjF/pU6ClE34AmamQ0lZ0hfRFIkVM7aDkBDM+foWwg
 hIhL4UissmdgrqHqLMxFSMOn7h95+Ig=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-OIXS2_DONZaHXIyPsNDUQA-1; Fri, 28 Feb 2020 05:40:35 -0500
X-MC-Unique: OIXS2_DONZaHXIyPsNDUQA-1
Received: by mail-wm1-f72.google.com with SMTP id d129so991165wmd.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 02:40:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=heyyN7weG3TiKSqFTiBsmETw+4JQx1i7XhKY4p5O9nc=;
 b=h2cEbGA6ER3i4aqq5MGxryvfti6pwoEmdyLX4ddysoHFx7mLdBcTxLP3mxH3GUvRP0
 cGyeOwDUGq4pmvd/dn0va4AvrNQpZMWqhwDnERzth2xSbK6fBI1d5A04Q4JvgtRyPogQ
 FEbGdCGpu9a77gpeR/a6v0qth41YAPzs6Qo9BjccOZPZYPzkR0b8oILVH6DEzZdNLHrX
 /D/Kj8Z1+z7J/+BlTyzY224SgfeBwiEk2kA7znGrlmbdf9O6fl3fxgX+VbeyvoIcS1I6
 xdm0q/0bbLXsZ9Z/8Mj0Ryq2z+/vhlTQHVNgxWofFTwIU601YRLtB2Dkq9u6xlWtOoTk
 UgcQ==
X-Gm-Message-State: APjAAAVR2w7VZc0xNrjcIy39oPPbJ6Vb9VEPK9gOOWBUc2/d0uLPIPVy
 T7J1LT5JfEzwRyQTvDaYGRp9Rh9wX9R8N8CjHjIOWwhK1yFkJCbRxxBvCfRV2n5WN5VE/BQGlp4
 q1ZanevevOp9Oam0=
X-Received: by 2002:a5d:494c:: with SMTP id r12mr4032637wrs.50.1582886434069; 
 Fri, 28 Feb 2020 02:40:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcg138t5RVp7omIEz+5Xw0Iqho0rWsIess+bRxzm91Tw9rUl/8JBfEiChp+RXw9FdaS4UlwA==
X-Received: by 2002:a5d:494c:: with SMTP id r12mr4032611wrs.50.1582886433781; 
 Fri, 28 Feb 2020 02:40:33 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f?
 ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id t187sm1677423wmt.25.2020.02.28.02.40.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2020 02:40:33 -0800 (PST)
Subject: Re: [PATCH v2] hw/i386/intel_iommu: Simplify
 vtd_find_as_from_bus_num() logic
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200226201030.22583-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ba1d3a0b-f1ae-21d2-45e9-a3c1fae650df@redhat.com>
Date: Fri, 28 Feb 2020 11:40:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226201030.22583-1-philmd@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Liu Yi L <yi.l.liu@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-trivial@nongnu.org, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/02/20 21:10, Philippe Mathieu-Daud=C3=A9 wrote:
> The vtd_find_as_from_bus_num() function was introduced (in commit
> dbaabb25f) in a code format that could return an incorrect pointer,
> which was later fixed by commit a2e1cd41ccf.
> We could have avoid this by writing the if() statement differently.
> Do it now, in case this function is re-used. The code is easier to
> review (harder to miss bugs).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Since v2: Re-worded commit description, patch sent without -w.
>=20
> This patch is easier to review with 'git-diff -w' (--ignore-all-space):
>=20
> @@ -987,14 +987,17 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, =
uint32_t level)
>  static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_=
num)
>  {
>      VTDBus *vtd_bus =3D s->vtd_as_by_bus_num[bus_num];
> -    if (!vtd_bus) {
> +    GHashTableIter iter;
> +
> +    if (vtd_bus) {
> +        return vtd_bus;
> +    }
> +
>      /*
>       * Iterate over the registered buses to find the one which
>       * currently hold this bus number, and update the bus_num
>       * lookup table:
>       */
> -        GHashTableIter iter;
> -
>      g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
>      while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
>          if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
> @@ -1002,9 +1005,8 @@ static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUS=
tate *s, uint8_t bus_num)
>              return vtd_bus;
>          }
>      }
> -        vtd_bus =3D NULL;
> -    }
> -    return vtd_bus;
> +
> +    return NULL;
>  }
> ---
>  hw/i386/intel_iommu.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6258c58ac9..e720a8939c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -987,24 +987,26 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, =
uint32_t level)
>  static VTDBus *vtd_find_as_from_bus_num(IntelIOMMUState *s, uint8_t bus_=
num)
>  {
>      VTDBus *vtd_bus =3D s->vtd_as_by_bus_num[bus_num];
> -    if (!vtd_bus) {
> -        /*
> -         * Iterate over the registered buses to find the one which
> -         * currently hold this bus number, and update the bus_num
> -         * lookup table:
> -         */
> -        GHashTableIter iter;
> +    GHashTableIter iter;
> =20
> -        g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
> -        while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
> -            if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
> -                s->vtd_as_by_bus_num[bus_num] =3D vtd_bus;
> -                return vtd_bus;
> -            }
> -        }
> -        vtd_bus =3D NULL;
> +    if (vtd_bus) {
> +        return vtd_bus;
>      }
> -    return vtd_bus;
> +
> +    /*
> +     * Iterate over the registered buses to find the one which
> +     * currently hold this bus number, and update the bus_num
> +     * lookup table:
> +     */
> +    g_hash_table_iter_init(&iter, s->vtd_as_by_busptr);
> +    while (g_hash_table_iter_next(&iter, NULL, (void **)&vtd_bus)) {
> +        if (pci_bus_num(vtd_bus->bus) =3D=3D bus_num) {
> +            s->vtd_as_by_bus_num[bus_num] =3D vtd_bus;
> +            return vtd_bus;
> +        }
> +    }
> +
> +    return NULL;
>  }
> =20
>  /* Given the @iova, get relevant @slptep. @slpte_level will be the last =
level
>=20

Queued, thanks.

Paolo


