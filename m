Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01EBC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B01216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B01216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49119 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOcqo-0008Uf-M3
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:48:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOcpu-0008B9-LS
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOcpt-00034I-Gr
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:47:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hOcpt-000340-BP
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:47:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 401B6307D8BE;
	Thu,  9 May 2019 06:47:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6120760BFB;
	Thu,  9 May 2019 06:47:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 8718F11AA3; Thu,  9 May 2019 08:47:16 +0200 (CEST)
Date: Thu, 9 May 2019 08:47:16 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>
Message-ID: <20190509064716.pcxsg3lbbfqv5ltl@sirius.home.kraxel.org>
References: <20190508085645.11595-1-kraxel@redhat.com>
	<20190508085645.11595-12-kraxel@redhat.com>
	<461b0a0f-2843-afc3-6289-db08d6415771@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461b0a0f-2843-afc3-6289-db08d6415771@gmx.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 09 May 2019 06:47:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 11/13] tests/vm: netbsd autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> I recommend to add one extra step into generated image:
> 
> echo security.pax.mprotect.enabled=0 >> /etc/sysctl.conf

Done.

> Alternatively (and preferably) enhance qemu to handle RWX allocation for
> JIT on NetBSD.
> 
> Example in libffi.
> 
> https://github.com/libffi/libffi/commit/2bfcd29955c02b67fa10a68cc4200f6838181e0f

So, from looking at the patch it seems you need two mappings of the same
page, one writable and one executable.

Or, maybe it is also possible with one mapping which is writable first
when you fill it with code, then gets flipped over to executable when
you are done with the initialization and want use it.

Is that correct?

I suspect supporting that in tcg isn't exactly trivial.
Does OpenBSD work the same way btw?

cheers,
  Gerd


