Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB2FC07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 07:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608512075B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 07:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608512075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41479 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVAP6-00039x-EF
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 03:50:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bwiedemann@suse.de>) id 1hVAOJ-0002mB-Am
	for qemu-devel@nongnu.org; Mon, 27 May 2019 03:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bwiedemann@suse.de>) id 1hVAOH-0005GU-Di
	for qemu-devel@nongnu.org; Mon, 27 May 2019 03:49:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:35152 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bwiedemann@suse.de>) id 1hVAOH-0005Dl-0M
	for qemu-devel@nongnu.org; Mon, 27 May 2019 03:49:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id E6743B011;
	Mon, 27 May 2019 07:49:49 +0000 (UTC)
To: Eduardo Habkost <ehabkost@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190516125807.17025-1-bwiedemann@suse.de>
	<20190523185737.GB2994@work-vm> <20190523212708.GD10764@habkost.net>
From: "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=bwiedemann@suse.de; prefer-encrypt=mutual; keydata=
	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
	12bW2FfpiwAGOQ==
Message-ID: <bc805d17-f773-08d1-6b01-fcbffcd659b6@suse.de>
Date: Mon, 27 May 2019 09:49:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523212708.GD10764@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic]
X-Received-From: 195.135.220.15
Subject: Re: [Qemu-devel] [PATCH] i386: Fix nested SVM on older Opterons
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
Cc: bsd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/05/2019 23.27, Eduardo Habkost wrote:
> On Thu, May 23, 2019 at 07:57:38PM +0100, Dr. David Alan Gilbert wrote:
>> * Bernhard M. Wiedemann (bwiedemann@suse.de) wrote:
>>> Without this patch, a VM on a Opteron G3 host will have the svm flag,=
 but
>>> the kvm-amd module fails to load in there, complaining that it needs
>>> cpuid 0x8000000a
>>>
>>> I have successfully built and tested this for 3+ years in production
>>> on Opteron G3 servers.
>=20
> Have you reproduced the bug on QEMU 2.8 or newer?  The problem
> you describe should be fixed by the following commit (from ~2.5
> years ago).
>=20
> commit 0c3d7c0051576d220e6da0a8ac08f2d8482e2f0b
>     target-i386: Enable CPUID[0x8000000A] if SVM is enabled

I was still on qemu-2.6.2 so it is good to know that this might work out
of the box with 2.8+

Thanks for the pointer.

