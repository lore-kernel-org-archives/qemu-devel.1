Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5250C28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2BA2070D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 09:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2BA2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50801 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVvDg-00076S-Pj
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 05:50:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hVvCG-0006Ts-ES
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hVvCF-0000n2-Lb
	for qemu-devel@nongnu.org; Wed, 29 May 2019 05:48:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hVvCF-0000mW-HL; Wed, 29 May 2019 05:48:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A92E301EA90;
	Wed, 29 May 2019 09:48:34 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1853D60F87;
	Wed, 29 May 2019 09:48:30 +0000 (UTC)
Date: Wed, 29 May 2019 11:48:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Message-ID: <20190529114828.046a832f.cohuck@redhat.com>
In-Reply-To: <192d35fa-12be-c840-e61c-716a3bd80943@linux.ibm.com>
References: <20190507154733.28604-1-cohuck@redhat.com>
	<20190507154733.28604-3-cohuck@redhat.com>
	<f2c65517-f6d8-41a4-3f8a-88a530cdcd41@linux.ibm.com>
	<20190521183235.7c3d0b37.cohuck@redhat.com>
	<192d35fa-12be-c840-e61c-716a3bd80943@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 29 May 2019 09:48:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 2/2] vfio-ccw: support async command
 subregion
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
Cc: Pierre Morel <pmorel@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 May 2019 16:47:45 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 5/21/19 12:32 PM, Cornelia Huck wrote:

> > Why mostly? I'm not sure yet whether we handling multiple requests for
> > passthrough devices correctly yet (virtual should be fine.)
> > 
> > Start vs. (start|halt|clear) is fine, as the code checks whether
> > something is already pending before poking the kernel interface.
> > Likewise, halt vs. (start|halt|clear) is fine, as the code checks for
> > halt or clear and start and halt use different regions. The problematic
> > one is clear, as that's something that's always supposed to go through.
> > Probably fine if clear should always "win", but I need to think some
> > more about that.  
> 
> I suspect you are right, because of the check on the halt side, and
> considering that the clear is the biggest recovery action we have.  So
> this does seem like things are okay.  I'll ponder this overnight and
> finish my review tomorrow.

Ok, what's the verdict here? :)

(I'm trying to clean up my pending stuff :)

