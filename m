Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBBAC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978AE2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 13:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyH1YzSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978AE2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXmPV-0007zP-Qe
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 08:22:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iXmOA-0006x2-WD
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iXmO4-00009J-Po
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:20:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45823
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iXmO1-00005c-1B
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 08:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574342439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3vpBxkXf/RB/sinJgvoh/t9Fc5dBp5y4q7Gqzw+VtQ=;
 b=LyH1YzSrZcKnPRzeDcS6VQI7JRu2K3erqrhSIOGRNzcD0gD8GDebYgr+kr3GWwaeukoTjq
 C9X3XbSFxs5cVjmgucJG1x0ytxXaIHGA24mjzvFbBWBg9rJ5McV0DOvcoSp4+yeajET4OP
 iuzu28ZlYM/mr2vK10XDEl4ht5lTbZA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-aKJjvQFYMAaVbKk97qN1RQ-1; Thu, 21 Nov 2019 08:20:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51592800054;
 Thu, 21 Nov 2019 13:20:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-86.ams2.redhat.com
 [10.36.116.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80E99537A1;
 Thu, 21 Nov 2019 13:20:28 +0000 (UTC)
Subject: Re: [PATCH 02/15] s390x: Beautify diag308 handling
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <683fd0dc-4888-8566-8fcc-fc7a074d4d12@redhat.com>
Date: Thu, 21 Nov 2019 14:20:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191120114334.2287-3-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: aKJjvQFYMAaVbKk97qN1RQ-1
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/11/2019 12.43, Janosch Frank wrote:
> Let's improve readability by:
> * Using constants for the subcodes
> * Moving parameter checking into a function
> * Removing subcode > 6 check as the default case catches that
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/diag.c | 54 +++++++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 22 deletions(-)
>=20
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 53c2f81f2a..067c667ba7 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -53,6 +53,29 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, u=
int64_t r3)
>  #define DIAG_308_RC_NO_CONF         0x0102
>  #define DIAG_308_RC_INVALID         0x0402
> =20
> +#define DIAG308_RES_MOD_CLR=09=090
> +#define DIAG308_RES_LOAD_NORM=09=091

I think I'd also prefer RESET instead of RES here.

> +#define DIAG308_LOAD_CLEAR=09=093
> +#define DIAG308_LOAD_NORMAL_DUMP=094
> +#define DIAG308_SET=09=09=095
> +#define DIAG308_STORE=09=09=096
> +
> +static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t =
addr,
> +                              uintptr_t ra, bool write)
> +{
> +    if ((r1 & 1) || (addr & ~TARGET_PAGE_MASK)) {
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return -EINVAL;
> +    }
> +    if (!address_space_access_valid(&address_space_memory, addr,
> +                                    sizeof(IplParameterBlock), write,
> +                                    MEMTXATTRS_UNSPECIFIED)) {
> +        s390_program_interrupt(env, PGM_ADDRESSING, ra);
> +        return -EINVAL;

or maybe -EFAULT ? ;-)

> +    }
> +    return 0;
> +}
> +
>  void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintp=
tr_t ra)
>  {
>      CPUState *cs =3D env_cpu(env);
> @@ -65,30 +88,24 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1,=
 uint64_t r3, uintptr_t ra)
>          return;
>      }
> =20
> -    if ((subcode & ~0x0ffffULL) || (subcode > 6)) {
> +    if (subcode & ~0x0ffffULL) {
>          s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          return;
>      }
> =20
>      switch (subcode) {
> -    case 0:
> +    case DIAG308_RES_MOD_CLR:
>          s390_ipl_reset_request(cs, S390_RESET_MODIFIED_CLEAR);
>          break;
> -    case 1:
> +    case DIAG308_RES_LOAD_NORM:
>          s390_ipl_reset_request(cs, S390_RESET_LOAD_NORMAL);
>          break;
> -    case 3:
> +    case DIAG308_LOAD_CLEAR:
> +        /* Well we still lack the clearing bit... */
>          s390_ipl_reset_request(cs, S390_RESET_REIPL);
>          break;
> -    case 5:
> -        if ((r1 & 1) || (addr & 0x0fffULL)) {
> -            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> -            return;
> -        }
> -        if (!address_space_access_valid(&address_space_memory, addr,
> -                                        sizeof(IplParameterBlock), false=
,
> -                                        MEMTXATTRS_UNSPECIFIED)) {
> -            s390_program_interrupt(env, PGM_ADDRESSING, ra);
> +    case DIAG308_SET:
> +        if (diag308_parm_check(env, r1, addr, ra, false)) {
>              return;
>          }
>          iplb =3D g_new0(IplParameterBlock, 1);
> @@ -110,15 +127,8 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1=
, uint64_t r3, uintptr_t ra)
>  out:
>          g_free(iplb);
>          return;
> -    case 6:
> -        if ((r1 & 1) || (addr & 0x0fffULL)) {
> -            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> -            return;
> -        }
> -        if (!address_space_access_valid(&address_space_memory, addr,
> -                                        sizeof(IplParameterBlock), true,
> -                                        MEMTXATTRS_UNSPECIFIED)) {
> -            s390_program_interrupt(env, PGM_ADDRESSING, ra);
> +    case DIAG308_STORE:
> +        if (diag308_parm_check(env, r1, addr, ra, true)) {
>              return;
>          }
>          iplb =3D s390_ipl_get_iplb();
>=20

With RESET instead of RES:

Reviewed-by: Thomas Huth <thuth@redhat.com>


