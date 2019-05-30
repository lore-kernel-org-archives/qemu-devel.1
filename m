Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB83FC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 09:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3895254EA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 09:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3895254EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWGxD-0002Yt-Tc
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 05:02:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWGvv-0001qZ-I2
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hWGvt-00052h-Ij
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:01:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hWGvt-0004oH-C3
	for qemu-devel@nongnu.org; Thu, 30 May 2019 05:01:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BC2BF74CF;
	Thu, 30 May 2019 09:00:40 +0000 (UTC)
Received: from xz-x1 (ovpn-12-221.pek2.redhat.com [10.72.12.221])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E1B703AC8;
	Thu, 30 May 2019 09:00:33 +0000 (UTC)
Date: Thu, 30 May 2019 17:00:28 +0800
From: Peter Xu <peterx@redhat.com>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Message-ID: <20190530090028.GB28587@xz-x1>
References: <003a01d51611$6251a2b0$26f4e810$@ru> <20190530005243.GA28587@xz-x1>
	<000901d516ac$2b1a7d80$814f7880$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000901d516ac$2b1a7d80$814f7880$@ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Thu, 30 May 2019 09:00:40 +0000 (UTC)
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
Cc: ehabkost@redhat.com, quintela@redhat.com, dgilbert@redhat.com,
	qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 30, 2019 at 08:54:38AM +0300, Pavel Dovgalyuk wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > On Wed, May 29, 2019 at 02:26:39PM +0300, Pavel Dovgalyuk wrote:
> > > Hello!
> > >
> > >
> > >
> > > I found this while debugging the inconsistent saved/restored state of the virtual machine.
> > >
> > >
> > >
> > > i386 (32 bit) emulation uses this register (in wrmsr and in MMU fault processing).
> > 
> > Sorry if this question is elementary, but... why would a 32bit guest
> > use IA32_EFER?  From SDM I only see 4 bits defined in this MSR (SCE,
> > LME, LMA, NXE) but is there any of them that should be set in a 32bit
> > guest?
> 
> Ubuntu server 16.04 (32 bit) sets NXE while booting.
> NXE affects the MMU fault processing and exception generation.

But this is what I read from the spec (SDM 4.6.1):

Instruction fetches:

  - Access rights depend on the mode of the linear address, the paging
    mode, and the value of IA32_EFER.NXE:

    - For 32-bit paging or if IA32_EFER.NXE = 0, instructions may be
      fetched from any user-mode address.

    - For PAE paging or 4-level paging with IA32_EFER.NXE = 1,
      instructions may be fetched from any user-mode address with a
      translation for which the XD flag is 0 in every paging-structure
      entry controlling the translation.

    - Instructions may not be fetched from any supervisor-mode address.

I'm not an expert of x86 arch but it seems to me that no matter what
NXE bit should be meaningless on x86 32bit according to above.

Also, above spec seems to match with the kvm code too, since in
init_kvm_tdp_mmu() where kvm_mmu.nx is only set with either long mode
or PAE, but never 32bit.  So I'm a bit confused on why that should be
migrated for 32bit (or even, whether should EFER MSR be visible to
such a guest at all?).

Regards,

-- 
Peter Xu

