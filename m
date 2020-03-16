Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3523CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC9420658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ao9OlDEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC9420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv6w-0007mc-W2
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jDuIR-0005gN-D3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jDuIQ-0003zJ-6y
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:17:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27859)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jDuIQ-0003x9-0M
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584382621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ds8ISIFy7wdmyjh1PIcgDdjFLhq5M+HOYAZVCeuMrcY=;
 b=ao9OlDEXE1CygZaSAyKOJ+oyUrHfhvnEz5HyA7cEmzp0FghtjHAVGeWSH6bwjaVJoWquYJ
 h8qdDvkj/9eQC4B+KsAajchYdofU2EWV8iyf0od4XGMlptDz4xegM0KWOVp42rXwG5PYWH
 +wlNjoaiCn+UDrZnPC+a5pTVyoTksX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-sJaKwabAPeiHsr_tGYKLGw-1; Mon, 16 Mar 2020 14:16:56 -0400
X-MC-Unique: sJaKwabAPeiHsr_tGYKLGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA91610C4F9B;
 Mon, 16 Mar 2020 17:57:14 +0000 (UTC)
Received: from gondolin (ovpn-117-70.ams2.redhat.com [10.36.117.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0CF55D9E2;
 Mon, 16 Mar 2020 17:57:10 +0000 (UTC)
Date: Mon, 16 Mar 2020 18:57:08 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v9] fixup! Fix subcode/pbt
Message-ID: <20200316185708.30d23522.cohuck@redhat.com>
In-Reply-To: <a39815f9-6c36-5c7e-39e0-3cd49a66c571@de.ibm.com>
References: <a1ed33c4-91c0-90fa-2f95-417e320e172c@de.ibm.com>
 <20200313095232.2392-1-frankja@linux.ibm.com>
 <20200316152738.4c1c65ee.cohuck@redhat.com>
 <bbbabbb0-2325-406d-a619-f2d03f447c8c@linux.ibm.com>
 <20200316155457.73e97d9c.cohuck@redhat.com>
 <a39815f9-6c36-5c7e-39e0-3cd49a66c571@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: qemu-s390x@nongnu.org, david@redhat.com,
 Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 16:04:00 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 16.03.20 15:54, Cornelia Huck wrote:
> > On Mon, 16 Mar 2020 15:47:41 +0100
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >   
> >> On 3/16/20 3:27 PM, Cornelia Huck wrote:  
> >>> On Fri, 13 Mar 2020 05:52:32 -0400
> >>> Janosch Frank <frankja@linux.ibm.com> wrote:
> >>>     
> >>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >>>> ---
> >>>>  hw/s390x/ipl.h      | 11 +++++++----
> >>>>  target/s390x/diag.c |  2 +-
> >>>>  2 files changed, 8 insertions(+), 5 deletions(-)  
> > 
> >   
> >>>> @@ -118,7 +118,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
> >>>>  
> >>>>          cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
> >>>>  
> >>>> -        if (!iplb_valid(iplb)) {
> >>>> +        if (!iplb_valid(iplb, subcode)) {
> >>>>              env->regs[r1 + 1] = DIAG_308_RC_INVALID;
> >>>>              goto out;
> >>>>          }    
> >>>
> >>> ...because you're basically checking whether you either have a valid
> >>> normal iplb, or a valid pv iplb, with the two being mutually exclusive,
> >>> IIUC. So what about introducing iplb_valid_pv and calling that for the
> >>> pv case? Would be a bit nicer to read, I think, and also matches what
> >>> you do for the STORE case.
> >>>     
> >>
> >> The idea was to get rid of all of these ifs and elses and only have one
> >> iplb_valid function. Your suggestion would defeat hiding that complexity
> >> behind this function.  
> > 
> > I'd argue that this is a complexity we should not hide; for non-pv, we
> > can have several formats, for pv, only one, and we cannot use a pv iplb
> > in a non-pv context and vice versa.  
> 
> So you suggest to split these case statements?
> case DIAG308_STORE:
> case DIAG308_PV_STORE:

Why? Those cases are already done in the way I suggest for these here
as well (i.e. keep common checks, just split the iplb handling.)


