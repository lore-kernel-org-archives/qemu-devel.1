Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82033C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 07:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5720621019
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 07:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5720621019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52590 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ5cn-0004xS-Jx
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 03:43:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hQ5bz-0004bV-9I
	for qemu-devel@nongnu.org; Mon, 13 May 2019 03:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hQ5by-0001kB-Bx
	for qemu-devel@nongnu.org; Mon, 13 May 2019 03:43:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hQ5by-0001jl-5j; Mon, 13 May 2019 03:43:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 89EAA307D91E;
	Mon, 13 May 2019 07:43:00 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3CC206B8C7;
	Mon, 13 May 2019 07:42:59 +0000 (UTC)
Date: Mon, 13 May 2019 09:42:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190513094257.43acf1ec.cohuck@redhat.com>
In-Reply-To: <3c34e021-9bc5-08c0-2aad-f643470fe35f@redhat.com>
References: <20190508094857.21145-1-thuth@redhat.com>
	<20190508094857.21145-3-thuth@redhat.com>
	<04ebd3c0-34e2-d21c-2b04-616d52056a86@de.ibm.com>
	<3c34e021-9bc5-08c0-2aad-f643470fe35f@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 13 May 2019 07:43:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL SUBSYSTEM s390x 2/3] s390-bios:
 Skip bootmap signature entries
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
Cc: jjherne@linux.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 11 May 2019 08:15:21 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 10/05/2019 15.59, Christian Borntraeger wrote:
> > Shall we cc stable this?  
> 
> I think I'd rather not do it unless someone really speaks up that they
> urgently need it. If we could use the binary from the master branch, I'd
> say go for it, but in this case we'd need to build a separate
> s390-ccw.img for this (without the DASD passthrough patches), and since
> the stable branch does not get that much testing attention from all the
> s390x developers, you'd end up with a firmware binary in the stable
> branch that is not very well tested... This does not sound very
> appealing to me.

FWIW, I have rebuilt the bios for the stable tree in the past, when a
bios patch had been picked. In this case, however, I would need to rely
on someone else to sanity-check the binary.

How likely are folks to run -stable QEMU with a bootmap containing
signatures? It would be one more QEMU version with toleration for this,
but I expect distros to pick up this one anyway?

