Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1C2C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C9E2068F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 11:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EYPJ56Qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C9E2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXkUS-0007Nd-8U
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 06:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXkSl-0006KZ-C4
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:17:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXkSh-0005Nu-FA
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:17:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55008
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXkSh-0005Mm-BQ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 06:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574335041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FmLUgldfz+MTVOEpvts8mb1nmFasdskmy8Fr9ELdqO8=;
 b=EYPJ56QgIRu3+BKFTVnjDljQhdHUqr0wcXQlHAHrun1dY+qN06OgGnDi7gFaqXHTADPeq7
 rAtgVvGzQaDTUcD5E3Db0ZqjZWLooCEHr1Z33rEyoGlRQbaoB2U1GYSsheNI58dDG7uWc2
 /o3NPaGmuKff0ID91PoUfpvYMmYwUm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-os2H2ll3PZOqXtMeFDeO8A-1; Thu, 21 Nov 2019 06:17:20 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2934E107B103;
 Thu, 21 Nov 2019 11:17:19 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 002455379E;
 Thu, 21 Nov 2019 11:17:02 +0000 (UTC)
Date: Thu, 21 Nov 2019 12:17:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 02/15] s390x: Beautify diag308 handling
Message-ID: <20191121121700.1f8aa81d.cohuck@redhat.com>
In-Reply-To: <20191120114334.2287-3-frankja@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-3-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: os2H2ll3PZOqXtMeFDeO8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

On Wed, 20 Nov 2019 06:43:21 -0500
Janosch Frank <frankja@linux.ibm.com> wrote:

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

Maybe s/RES/RESET/ ? Not that much longer, but clearer IMHO.

> +#define DIAG308_LOAD_CLEAR=09=093
> +#define DIAG308_LOAD_NORMAL_DUMP=094
> +#define DIAG308_SET=09=09=095
> +#define DIAG308_STORE=09=09=096

(...)

Really more readable afterwards.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


