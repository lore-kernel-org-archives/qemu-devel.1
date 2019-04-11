Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415C6C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 18:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11EB42083E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 18:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EB42083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53433 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEeiL-0003sS-6U
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 14:46:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hEehA-0002zc-EW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:45:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hEeh9-0005Hc-Go
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:45:08 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:54862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hEeh9-0005CB-7W
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:45:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id 2FAD0A868;
	Thu, 11 Apr 2019 20:45:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
	by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1FU5m5O0EFeP; Thu, 11 Apr 2019 20:45:03 +0200 (CEST)
Received: from function (105.251.129.77.rev.sfr.net [77.129.251.105])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id 91A9EA864;
	Thu, 11 Apr 2019 20:45:03 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hEeh4-0007UO-TA; Thu, 11 Apr 2019 20:45:02 +0200
Date: Thu, 11 Apr 2019 20:45:02 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190411184502.xvesnriqcocyvuan@function>
References: <20190405184648.17029-1-dgilbert@redhat.com>
	<20190405212501.cdg4u3m7ihldcop4@function>
	<20190408084653.GB2687@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190408084653.GB2687@work-vm>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.233.100.1
Subject: Re: [Qemu-devel] [PATCH] slirp: Gcc 9 -O3 fix
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
Cc: jan.kiszka@siemens.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411184502.YA40qla51cZ5T67N4APaevfoAUsTgBpuzjL760yFlrY@z>

Hello,

Dr. David Alan Gilbert, le lun. 08 avril 2019 09:46:53 +0100, a ecrit:
> 'soread' has the comment:
> 
>         /*
>          * No need to check if there's enough room to read.
>          * soread wouldn't have been called if there weren't
>          */
>         sopreprbuf(so, iov, &n);
> 
> the compiler doesn't realise that, and is moaning about the case
> where the if (len <=0) return happens and the following 
> code tries to use iov.

I see. Perhaps we should make this an assert then? In case this isn't
true, i.e. soread() is called even if no room is available, returning 0
would probably just let the caller just try again, and we should rather
just plainly crash than hang?

Samuel

