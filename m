Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238FFC4BA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90BA1206E6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7vGsZhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BA1206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70rI-0001pU-Fo
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j70qN-0000uW-Md
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j70qM-0008T4-HY
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:51:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j70qM-0008SK-DB
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582739493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYSpSrR/wiJtWczK1CPrmViiuR64xMMBXnpSG2MGvw4=;
 b=K7vGsZhC+w8Xykc6BFnP3vQxB/FcQCKHetcs8sR3OFbizdXcEwxgyJa5SugyzKNVMweCYO
 AdOYtQlgruY5zLIfO9l+kZJF+ONpUz0h/h5+CO3yBss5XnjQ3wNDL5qe2bGvpfh0G6/XzP
 TQ3q91b3SYupgG1UHfTt7A7qY3+3ORo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-mbXsKEovPuac8VJQFdS7UQ-1; Wed, 26 Feb 2020 12:51:29 -0500
X-MC-Unique: mbXsKEovPuac8VJQFdS7UQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2FBB801E53;
 Wed, 26 Feb 2020 17:51:27 +0000 (UTC)
Received: from gondolin (ovpn-117-69.ams2.redhat.com [10.36.117.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78DD460BE2;
 Wed, 26 Feb 2020 17:51:20 +0000 (UTC)
Date: Wed, 26 Feb 2020 18:51:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v5 01/18] s390x: Use constant for ESA PSW address
Message-ID: <20200226185118.316055d5.cohuck@redhat.com>
In-Reply-To: <3d6f7f88-0a77-90f0-4e26-ee826593d55f@redhat.com>
References: <20200226122038.61481-1-frankja@linux.ibm.com>
 <20200226122038.61481-2-frankja@linux.ibm.com>
 <3d6f7f88-0a77-90f0-4e26-ee826593d55f@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 15:27:52 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 26.02.20 13:20, Janosch Frank wrote:
> > Lets make it a bit more clear that we're extracting the 31 bit address

s/Lets/Let's/ :)

> > from the short psw.
> > 
> > Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> > ---
> >  hw/s390x/ipl.c     | 2 +-
> >  target/s390x/cpu.c | 4 ++--
> >  target/s390x/cpu.h | 1 +
> >  3 files changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> > index 7773499d7f..42e21e7a6a 100644
> > --- a/hw/s390x/ipl.c
> > +++ b/hw/s390x/ipl.c
> > @@ -179,7 +179,7 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
> >                  /* if not Linux load the address of the (short) IPL PSW */
> >                  ipl_psw = rom_ptr(4, 4);
> >                  if (ipl_psw) {
> > -                    pentry = be32_to_cpu(*ipl_psw) & 0x7fffffffUL;
> > +                    pentry = be32_to_cpu(*ipl_psw) & PSW_MASK_ESA_ADDR;
> >                  } else {
> >                      error_setg(&err, "Could not get IPL PSW");
> >                      goto error;
> > diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> > index 8da1905485..43360912a0 100644
> > --- a/target/s390x/cpu.c
> > +++ b/target/s390x/cpu.c
> > @@ -78,13 +78,13 @@ static void s390_cpu_load_normal(CPUState *s)
> >      S390CPU *cpu = S390_CPU(s);
> >      uint64_t spsw = ldq_phys(s->as, 0);
> >  
> > -    cpu->env.psw.mask = spsw & 0xffffffff80000000ULL;
> > +    cpu->env.psw.mask = spsw & PSW_MASK_ESA_MASK;
> >      /*
> >       * Invert short psw indication, so SIE will report a specification
> >       * exception if it was not set.
> >       */
> >      cpu->env.psw.mask ^= PSW_MASK_SHORTPSW;
> > -    cpu->env.psw.addr = spsw & 0x7fffffffULL;
> > +    cpu->env.psw.addr = spsw & PSW_MASK_ESA_ADDR;
> >  
> >      s390_cpu_set_state(S390_CPU_STATE_OPERATING, cpu);
> >  }
> > diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> > index 8a557fd8d1..74e66fe0c2 100644
> > --- a/target/s390x/cpu.h
> > +++ b/target/s390x/cpu.h
> > @@ -277,6 +277,7 @@ extern const VMStateDescription vmstate_s390_cpu;
> >  #define PSW_MASK_64             0x0000000100000000ULL
> >  #define PSW_MASK_32             0x0000000080000000ULL
> >  #define PSW_MASK_ESA_ADDR       0x000000007fffffffULL
> > +#define PSW_MASK_ESA_MASK       0xffffffff80000000ULL  
> 
> ..._MASK_..._MASK
> 
> Isn't there a better name for all the bits in the PSW that are not an
> address?
> 
> PSW_MASK_ESA_BITS
> PSW_MASK_ESA_FLAGS
> ...

Hm, the PoP says that the PSW "includes the instruction address,
condition code, and other control fields"; it also talks about the
'short' PSW as being distinct from the 'ESA' PSW (bit 31 may be 0 or 1
in the short PSW). Maybe

PSW_MASK_SHORT_ADDR
PSW_MASK_SHORT_CTRL

(Or keep _ESA_ if renaming creates too much churn.)

> 
> >  
> >  #undef PSW_ASC_PRIMARY
> >  #undef PSW_ASC_ACCREG
> >   
> 
> 

This patch is also independent of the protected virtualization
support... I plan to send a pull request tomorrow, so I can include
this patch, if we agree on a name for the constant :)


