Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A59C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 18:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D4620869
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 18:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D4620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41283 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hF1Ed-0007nG-OS
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 14:49:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hF1DU-0007Ei-UV
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hF1DU-00049I-1V
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:48:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hF1DM-00044x-5G; Fri, 12 Apr 2019 14:47:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 543BA30B0869;
	Fri, 12 Apr 2019 18:47:50 +0000 (UTC)
Received: from localhost (ovpn-116-78.gru2.redhat.com [10.97.116.78])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5DBBF60603;
	Fri, 12 Apr 2019 18:47:45 +0000 (UTC)
Date: Fri, 12 Apr 2019 15:47:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190412184743.GC31999@habkost.net>
References: <20190411102025.22559-1-cohuck@redhat.com>
	<155497852263.12882.17138118894178379111@76452e4e88f2>
	<20190411125655.7feab799.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190411125655.7feab799.cohuck@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 12 Apr 2019 18:47:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw: add compat machines for 4.1
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
Cc: fam@euphon.net, peter.maydell@linaro.org, mst@redhat.com, david@redhat.com,
	qemu-devel@nongnu.org, pasic@linux.ibm.com,
	borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
	qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com,
	david@gibson.dropbear.id.au, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412184743.wU6NFyUiz95NMSx3aWg2EOtjTthX1uWd0e-k7C6J8_c@z>

On Thu, Apr 11, 2019 at 12:56:55PM +0200, Cornelia Huck wrote:
> On Thu, 11 Apr 2019 03:28:46 -0700 (PDT)
> no-reply@patchew.org wrote:
> 
> > === OUTPUT BEGIN ===
> > ERROR: spaces required around that '=' (ctx:WxV)
> > #58: FILE: hw/i386/pc.c:118:
> > +GlobalProperty pc_compat_4_0[] ={};
> >                                 ^
> > 
> > total: 1 errors, 0 warnings, 160 lines checked
> 
> Yeah; trivial to fix by whoever applies this.

Fixed manually after committing.  Thanks!

-- 
Eduardo

