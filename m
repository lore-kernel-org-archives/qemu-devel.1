Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D86C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 18:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1ADE206B6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 18:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1ADE206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGSQz-0006po-0q
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 14:03:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGSPh-0006N2-PC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hGSPg-00027u-Ol
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:02:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hGSPg-00027G-Gs
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:02:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3612E7CDEA;
	Tue, 16 Apr 2019 18:02:28 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4EB4E5D9D3;
	Tue, 16 Apr 2019 18:02:22 +0000 (UTC)
Date: Tue, 16 Apr 2019 15:02:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Pavel Hrdina <phrdina@redhat.com>
Message-ID: <20190416180220.GH32317@habkost.net>
References: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
	<20190416141700.GR18986@antique-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190416141700.GR18986@antique-laptop>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Tue, 16 Apr 2019 18:02:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] i386: Add new Hygon 'Dhyana' CPU model
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
Cc: Pu Wen <puwen@hygon.cn>, rth@twiddle.net, pbonzini@redhat.com,
	qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416180220.o1VqUyPhyFAgLORCw2KuF17dBT75HzKJJUBW-Scufw4@z>

On Tue, Apr 16, 2019 at 04:17:00PM +0200, Pavel Hrdina wrote:
> On Tue, Apr 16, 2019 at 08:06:13PM +0800, Pu Wen wrote:
> > Add a new base CPU model called 'Dhyana' to model processors from Hygon
> > Dhyana(family 18h), which derived from AMD EPYC(family 17h).
> > 
> > The following features bits have been removed compare to AMD EPYC:
> > aes, pclmulqdq, sha_ni
> > 
> > The Hygon Dhyana support to KVM in Linux is already accepted upstream[1].
> > So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
> > CPU model.
> 
> I have once question that we will have to solve for EPYC CPUs as well.
> The name should not be based on the Product name or Model name as that
> usually doesn't change with introduction of new microarchitecture.
> 
> With EPYC we made a mistake to name the CPU like that, luckily with
> Intel we already use the microarchitecture name, so the EPYC CPU should
> have been named ZEN-Server and for Ryzen CPUs there should be ZEN-Client
> if there is any difference or otherwise we can simply use ZEN.
> 
> The issue here is what happens once the ZEN2 microarchitecture is out
> wihch introduces new features and we will have to come up with a CPU
> name.
> 
> Obviously we cannot change/remove the EPYC models so the question is
> what is the difference between the AMD EPYC CPU and this new Dhyana CPU
> if they are both based on the ZEN microarchitecture?
> 
> In addition is there any way how we can introduce ZEN-Server &
> ZEN-Client or simply ZEN, if there is no difference, as an alias or a
> new model next to the EPYC?

Currently there's no CPU model alias or inheritance system in x86
(yet), but feel free to submit a CPU model that's a copy of EPYC,
including the justification above.

When we implement CPU model versioning, we can make "EPYC" be
translated to "ZEN" by the CPU model version resolution API.

-- 
Eduardo

