Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE1DC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A3C20656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDAOlhsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A3C20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iopBQ-0006af-SV
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iop3g-0001zz-SU
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:38:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iop3e-0000fh-B7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:38:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48336
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iop3e-0000ea-7I
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 08:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578404285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=lyiBJWX71aFYoJlr3Qq2ST4rm3bkbSJNd4fsMCMwF2o=;
 b=LDAOlhsLISKbVdfBNFChx407fBDowqY/lZKKeG4J8bMtcTQvqmhexLg2Ey0qIISqTB/ScU
 abe4NbBzaWtux6OAXujIQ4mdDArkChh8+aNX0zNf3Ma/BbDNYasBw/csWWqzf+C4Nw6SIw
 uG74lsC0vS4wXT/lcP/NkCesAPP7ug8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-WUxZLKGGMAywbbg7qQ9Uvg-1; Tue, 07 Jan 2020 08:38:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B19A801E72;
 Tue,  7 Jan 2020 13:37:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED13F7C015;
 Tue,  7 Jan 2020 13:37:55 +0000 (UTC)
Subject: Re: [PATCH v1 38/59] s390x/sclp.c: remove unneeded label in
 sclp_service_call()
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-39-danielhb413@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1d26e2d6-4a94-5d57-ef22-c46699c5781b@redhat.com>
Date: Tue, 7 Jan 2020 14:37:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200106182425.20312-39-danielhb413@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: WUxZLKGGMAywbbg7qQ9Uvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/01/2020 19.24, Daniel Henrique Barboza wrote:
> 'out' label can be replaced by 'return' with the appropriate
> value. The 'r' integer, which is used solely to set the
> return value for this label, can also be removed.
> 
> CC: Cornelia Huck <cohuck@redhat.com>
> CC: Halil Pasic <pasic@linux.ibm.com>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/s390x/sclp.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> index f57ce7b739..af0bfbc2ec 100644
> --- a/hw/s390x/sclp.c
> +++ b/hw/s390x/sclp.c
> @@ -197,24 +197,20 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>  {
>      SCLPDevice *sclp = get_sclp_device();
>      SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
> -    int r = 0;
>      SCCB work_sccb;
>  
>      hwaddr sccb_len = sizeof(SCCB);
>  
>      /* first some basic checks on program checks */
>      if (env->psw.mask & PSW_MASK_PSTATE) {
> -        r = -PGM_PRIVILEGED;
> -        goto out;
> +        return -PGM_PRIVILEGED;
>      }
>      if (cpu_physical_memory_is_io(sccb)) {
> -        r = -PGM_ADDRESSING;
> -        goto out;
> +        return -PGM_ADDRESSING;
>      }
>      if ((sccb & ~0x1fffUL) == 0 || (sccb & ~0x1fffUL) == env->psa
>          || (sccb & ~0x7ffffff8UL) != 0) {
> -        r = -PGM_SPECIFICATION;
> -        goto out;
> +        return -PGM_SPECIFICATION;
>      }
>  
>      /*
> @@ -226,8 +222,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>  
>      /* Valid sccb sizes */
>      if (be16_to_cpu(work_sccb.h.length) < sizeof(SCCBHeader)) {
> -        r = -PGM_SPECIFICATION;
> -        goto out;
> +        return -PGM_SPECIFICATION;
>      }
>  
>      switch (code & SCLP_CMD_CODE_MASK) {
> @@ -257,8 +252,7 @@ out_write:
>  
>      sclp_c->service_interrupt(sclp, sccb);
>  
> -out:
> -    return r;
> +    return 0;
>  }
>  
>  static void service_interrupt(SCLPDevice *sclp, uint32_t sccb)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


