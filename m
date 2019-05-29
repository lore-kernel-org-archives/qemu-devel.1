Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D8EC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6709208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 12:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6709208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53579 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVxpt-0006uD-IV
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 08:37:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hVxp9-0006do-VE
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hVxp9-0001G5-38
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:36:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hVxp8-0001FX-Tj
	for qemu-devel@nongnu.org; Wed, 29 May 2019 08:36:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0490E307D9D1;
	Wed, 29 May 2019 12:36:49 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7768D1001E71;
	Wed, 29 May 2019 12:36:46 +0000 (UTC)
Date: Wed, 29 May 2019 13:36:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <20190529123643.GF2882@work-vm>
References: <003a01d51611$6251a2b0$26f4e810$@ru>
	<20190529113045.GE2882@work-vm>
	<5c55c39b-694b-5d4e-d420-5df0feabc1e8@redhat.com>
	<003f01d51615$16270d40$427527c0$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003f01d51615$16270d40$427527c0$@ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 29 May 2019 12:36:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] i386: EFER vs 32-bit CPU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>, quintela@redhat.com,
	qemu-devel@nongnu.org, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Pavel Dovgalyuk (dovgaluk@ispras.ru) wrote:
> > From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> > On 29/05/19 13:30, Dr. David Alan Gilbert wrote:
> > >> Should we add a section for i386, which duplicates efer, or just version_id of the main
> > VMSD should
> > >> be updated?
> > >
> > > You could do:
> > >
> > > #ifdef TARGET_X86_64
> > >         VMSTATE_UINT64(env.efer, X86CPU),
> > >         VMSTATE_UINT64(env.star, X86CPU),
> > > ...
> > >
> > > to become:
> > >
> > >         VMSTATE_UINT64_TEST(env.efer, X86CPU, efer_needed)
> > > #ifdef TARGET_X86_64
> > >         VMSTATE_UINT64(env.star, X86CPU),
> > >
> > >
> > > and then make efer_needed a function that returns true if
> > > TARGET_X86_64 or it's a new machine type that knows about whatever
> > > you're going to do with it.
> > 
> > I prefer adding a subsection for 32-bit, so that EFER is saved/restored
> > if nonzero.
> 
> The question is: should we remove EFER from the original VMSD?

No, because that would break 64bit compat.

Dave

> Pavel Dovgalyuk
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

