Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F13C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 20:49:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2342084F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 20:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UhdPGQOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2342084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51831 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK7mz-0007zl-UD
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 16:49:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bp@alien8.de>) id 1hK7l6-0006dl-HN
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 16:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bp@alien8.de>) id 1hK7h2-0007Vf-Gx
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 16:43:37 -0400
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457]:53928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bp@alien8.de>) id 1hK7h0-0007Qq-2I
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 16:43:36 -0400
Received: from zn.tnic (p200300EC2F0E4E00943B2A4E3B498EBE.dip0.t-ipconnect.de
	[IPv6:2003:ec:2f0e:4e00:943b:2a4e:3b49:8ebe])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id
	E91221EC0380; Fri, 26 Apr 2019 22:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1556311408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:in-reply-to:in-reply-to: references:references;
	bh=U/CTz5SAE+pabViqpyUk1tFxQ7Z2FiMtt9crX5ZBuxU=;
	b=UhdPGQOLrAf8IGQf0LFY/S4cUffWG3c4g9ftiz6gJMEqqlTKDul2WnVMT5615oZgOgXDnJ
	++VBWOsicl1sJqsDfbbe8zvCah3EZWOKI05JbmK2U00zXthBByudvMSRKV7SFtwhqV+Miv
	zO7NC654c1E1HbrUsIITY8nVh74sj4g=
Date: Fri, 26 Apr 2019 22:43:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Singh, Brijesh" <brijesh.singh@amd.com>
Message-ID: <20190426204327.GM4608@zn.tnic>
References: <20190424160942.13567-1-brijesh.singh@amd.com>
	<20190424160942.13567-2-brijesh.singh@amd.com>
	<20190426141042.GF4608@zn.tnic>
	<e6f8da38-b8dd-a9c5-a358-5f33b6ea7b37@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <e6f8da38-b8dd-a9c5-a358-5f33b6ea7b37@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a01:4f8:190:11c2::b:1457
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
Message-ID: <20190426204327.X7cQtDnT4eTAIkFVSIiuKiGsP4WdCjpoYUZoSOqJqHA@z>

On Fri, Apr 26, 2019 at 02:29:31PM +0000, Singh, Brijesh wrote:
> Yes that's doable but I am afraid that caching the value may lead us to
> wrong path and also divergence from the SEV API spec. The spec says the
> returned length is a minimum length but its possible that caller can
> give a bigger buffer and FW will still work with it.

Does the caller even have a valid reason to give a bigger buffer len?

I mean I'm still thinking defensively here but maybe the only thing that
would happen here with a bigger buffer is if the kmalloc() would fail,
leading to eventual failure of the migration.

If the code limits the allocation to some sane max length, the migration
won't fail even if userspace gives it too big values...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

