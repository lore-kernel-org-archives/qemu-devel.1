Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EBEC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E02520675
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="HIYiXKVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E02520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60351 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL9HB-00051K-4P
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 12:37:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bp@alien8.de>) id 1hL9GI-0004hp-LV
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bp@alien8.de>) id 1hL9GH-0002hE-JH
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:36:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bp@alien8.de>) id 1hL9GH-0002dK-2V
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:36:13 -0400
Received: from zn.tnic (p200300EC2F073600329C23FFFEA6A903.dip0.t-ipconnect.de
	[IPv6:2003:ec:2f07:3600:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id
	B87D01EC027B; Mon, 29 Apr 2019 18:36:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1556555763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:in-reply-to:in-reply-to: references:references;
	bh=fismiO90X9ow0flqEFvKG4xZhSvKMbYdUPumKyUhM9Q=;
	b=HIYiXKVApvDpTbHt+PlhAFHoIKD7hjuzVMbirqjxzgyuu3MmYXciLwQeByWfBXIi8n7ZGG
	JmqEiMLFwgc5z7qaUypuJWTpYU3D/FWlSEOzl2WFSZfumc32qPYes0/yxrryhUSKtuex8Y
	eN+dlETiFUgSwoU/eKGsdygENq9nAQY=
Date: Mon, 29 Apr 2019 18:36:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190429163602.GE2324@zn.tnic>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<20190424160942.13567-2-brijesh.singh@amd.com>
	<20190426141042.GF4608@zn.tnic>
	<e6f8da38-b8dd-a9c5-a358-5f33b6ea7b37@amd.com>
	<20190426204327.GM4608@zn.tnic>
	<2b63d983-a622-3bec-e6ac-abfd024e19c0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <2b63d983-a622-3bec-e6ac-abfd024e19c0@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.9.137.197
Subject: Re: [Qemu-devel] [RFC PATCH v1 01/10] KVM: SVM: Add KVM_SEV
 SEND_START command
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
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>, "x86@kernel.org" <x86@kernel.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429163602.OxKNqxJ28gfg1EhB_33BErT6pTmorQWLW84zoZIHpGQ@z>

On Mon, Apr 29, 2019 at 03:01:24PM +0000, Singh, Brijesh wrote:
> Practically I don't see any reason why caller would do that but
> theoretically it can. If we cache the len then we also need to consider
> adding another flag to hint whether userspace ever requested length.
> e.g an application can compute the length of session blob by looking at
> the API version and spec and may never query the length.
> 
> > I mean I'm still thinking defensively here but maybe the only thing that
> > would happen here with a bigger buffer is if the kmalloc() would fail,
> > leading to eventual failure of the migration.
> > 
> > If the code limits the allocation to some sane max length, the migration
> > won't fail even if userspace gives it too big values...

So what about this? Limiting to a sane length...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

