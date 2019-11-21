Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1ACC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DDE2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCsorXyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DDE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXlte-0006BG-C3
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXlsA-0004V4-2n
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:47:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXls7-0002cu-IP
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:47:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36366
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXls7-0002bj-5V
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574340462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3dJ0fFo0GqxPYzSWAaZYFOsQ3psuCq+CXLznFbdd4M4=;
 b=XCsorXyxTK2p4BMsAsmJdTyjtNYQjzPj/gLhvbqMea0fc39MYTJVj4aAzRR0JQHzPuFk+K
 PAkNCTUYKD6KGlMK7AMlANKzQPPaGlfE2H2YiHKDLcZpyyAnU96eWbu93OwtPNmzoYtI5m
 tmtNC1tBO51IjA8KaMI6IAK1SEwwkv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-HwxYetpoPqu7rWhY2kbjLQ-1; Thu, 21 Nov 2019 07:47:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DFD880268B;
 Thu, 21 Nov 2019 12:47:37 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E22C360F9F;
 Thu, 21 Nov 2019 12:47:32 +0000 (UTC)
Date: Thu, 21 Nov 2019 13:47:30 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 03/15] s390x: protvirt: Add diag308 subcodes 8 - 10
Message-ID: <20191121134730.60858c8d.cohuck@redhat.com>
In-Reply-To: <20191120114334.2287-4-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-4-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: HwxYetpoPqu7rWhY2kbjLQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 20 Nov 2019 06:43:22 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

> For diag308 subcodes 8 - 10 we have a new ipib of type 5. The ipib
> holds the address and length of the secure execution header, as well
> as a list of guest components.
>=20
> Each component is a block of memory, for example kernel or initrd,
> which needs to be decrypted by the Ultravisor in order to run a
> protected VM. The secure execution header instructs the Ultravisor on
> how to handle the protected VM and its components.
>=20
> Subcodes 8 and 9 are similiar to 5 and 6 and subcode 10 will finally
> start the protected guest.
>=20
> Subcodes 8-10 are not valid in protected mode, we have to do a subcode
> 3 and then the 8 and 10 combination for a protected reboot.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  hw/s390x/ipl.c      | 48 ++++++++++++++++++++++++++++++++++++++++++---
>  hw/s390x/ipl.h      | 33 +++++++++++++++++++++++++++++++
>  target/s390x/diag.c | 26 ++++++++++++++++++++++--
>  3 files changed, 102 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index ca544d64c5..a077926f36 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -529,15 +529,56 @@ static bool is_virtio_scsi_device(IplParameterBlock=
 *iplb)
>      return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
>  }
> =20
> +int s390_ipl_pv_check_comp(IplParameterBlock *iplb)

s390_ipl_pv_check_components() ?

> +{
> +    int i;
> +    IPLBlockPV *ipib_pv =3D &iplb->pv;
> +
> +    if (ipib_pv->num_comp =3D=3D 0) {
> +        return -EINVAL;
> +    }
> +
> +    for (i =3D 0; i < ipib_pv->num_comp; i++) {
> +
> +        /* Addr must be 4k aligned */
> +        if (ipib_pv->components[i].addr & ~TARGET_PAGE_MASK) {
> +            return -EINVAL;
> +        }
> +
> +        /* Tweak prefix is monotonously increasing with each component *=
/
> +        if (i < ipib_pv->num_comp - 1 &&
> +            ipib_pv->components[i].tweak_pref >
> +            ipib_pv->components[i + 1].tweak_pref) {
> +            return -EINVAL;
> +        }
> +    }
> +    return 1;
> +}
> +

(...)

> @@ -185,4 +211,11 @@ static inline bool iplb_valid_fcp(IplParameterBlock =
*iplb)
>             iplb->pbt =3D=3D S390_IPL_TYPE_FCP;
>  }
> =20
> +static inline bool iplb_valid_se(IplParameterBlock *iplb)

iplb_valid_pv() ?

> +{
> +    return be32_to_cpu(iplb->len) >=3D S390_IPLB_MIN_PV_LEN &&
> +           iplb->pbt =3D=3D S390_IPL_TYPE_PV;
> +}
> +
> +
>  #endif

(...)

> @@ -105,6 +110,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1,=
 uint64_t r3, uintptr_t ra)
>          s390_ipl_reset_request(cs, S390_RESET_REIPL);
>          break;
>      case DIAG308_SET:
> +    case DIAG308_PV_SET: /* Set SE parms */

PV parms?

('SE' makes me think of 'service element' :)

>          if (diag308_parm_check(env, r1, addr, ra, false)) {
>              return;
>          }
> @@ -117,7 +123,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1,=
 uint64_t r3, uintptr_t ra)
> =20
>          cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
> =20
> -        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb)) {
> +        if (!iplb_valid_ccw(iplb) && !iplb_valid_fcp(iplb) &&
> +            !(iplb_valid_se(iplb) && s390_ipl_pv_check_comp(iplb) >=3D 0=
)) {
>              env->regs[r1 + 1] =3D DIAG_308_RC_INVALID;
>              goto out;
>          }
> @@ -128,10 +135,15 @@ out:
>          g_free(iplb);
>          return;
>      case DIAG308_STORE:
> +    case DIAG308_PV_STORE: /* Get SE parms */

Same here.

>          if (diag308_parm_check(env, r1, addr, ra, true)) {
>              return;
>          }
> -        iplb =3D s390_ipl_get_iplb();
> +        if (subcode =3D=3D DIAG308_PV_STORE) {
> +            iplb =3D s390_ipl_get_iplb_secure();
> +        } else {
> +            iplb =3D s390_ipl_get_iplb();
> +        }
>          if (iplb) {
>              cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len)=
);
>              env->regs[r1 + 1] =3D DIAG_308_RC_OK;
> @@ -139,6 +151,16 @@ out:
>              env->regs[r1 + 1] =3D DIAG_308_RC_NO_CONF;
>          }
>          return;
> +        break;
> +    case DIAG308_PV_START: /* SE start */

Also here :)

> +        iplb =3D s390_ipl_get_iplb_secure();
> +        if (!iplb_valid_se(iplb)) {
> +            env->regs[r1 + 1] =3D DIAG_308_RC_NO_PV_CONF;
> +            return;
> +        }
> +
> +        s390_ipl_reset_request(cs, S390_RESET_PV);
> +        break;
>      default:
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          break;

Did not spot anything else.


