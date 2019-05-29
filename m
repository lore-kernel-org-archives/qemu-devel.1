Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F61C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF71223431
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 14:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF71223431
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55077 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVzDx-0002TP-4a
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 10:06:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1hVzAb-0000YM-9f
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1hVzAZ-0003jA-Du
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:03:09 -0400
Received: from mail.ispras.ru ([83.149.199.45]:39420)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1hVzAX-0003cz-TM
	for qemu-devel@nongnu.org; Wed, 29 May 2019 10:03:07 -0400
Received: from PASHAISP (unknown [85.142.117.226])
	by mail.ispras.ru (Postfix) with ESMTPSA id 01CD3540081;
	Wed, 29 May 2019 17:03:02 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: "'Dr. David Alan Gilbert'" <dgilbert@redhat.com>
References: <003a01d51611$6251a2b0$26f4e810$@ru>
	<20190529113045.GE2882@work-vm>
	<5c55c39b-694b-5d4e-d420-5df0feabc1e8@redhat.com>
	<003f01d51615$16270d40$427527c0$@ru>
	<20190529123643.GF2882@work-vm>
In-Reply-To: <20190529123643.GF2882@work-vm>
Date: Wed, 29 May 2019 17:03:06 +0300
Message-ID: <004601d51627$3dd284c0$b9778e40$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdUWGzNsNFva9FqMTcyMmsU9OSpzCAAC/V+g
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
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

> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]
> * Pavel Dovgalyuk (dovgaluk@ispras.ru) wrote:
> > > From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> > > On 29/05/19 13:30, Dr. David Alan Gilbert wrote:
> > > >> Should we add a section for i386, which duplicates efer, or just version_id of the main
> > > VMSD should
> > > >> be updated?
> > > >
> > > > You could do:
> > > >
> > > > #ifdef TARGET_X86_64
> > > >         VMSTATE_UINT64(env.efer, X86CPU),
> > > >         VMSTATE_UINT64(env.star, X86CPU),
> > > > ...
> > > >
> > > > to become:
> > > >
> > > >         VMSTATE_UINT64_TEST(env.efer, X86CPU, efer_needed)
> > > > #ifdef TARGET_X86_64
> > > >         VMSTATE_UINT64(env.star, X86CPU),
> > > >
> > > >
> > > > and then make efer_needed a function that returns true if
> > > > TARGET_X86_64 or it's a new machine type that knows about whatever
> > > > you're going to do with it.
> > >
> > > I prefer adding a subsection for 32-bit, so that EFER is saved/restored
> > > if nonzero.
> >
> > The question is: should we remove EFER from the original VMSD?
> 
> No, because that would break 64bit compat.

Thanks. Already posted a patch here:
https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06796.html

Pavel Dovgalyuk


