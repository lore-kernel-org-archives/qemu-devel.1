Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DB7ECE58D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:00:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FC4218DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FC4218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJ4X-00028w-56
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iIIxM-0002v2-Nz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 16:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iIIxI-0002rm-CY
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 16:53:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iIIxH-0002pq-K8
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 16:53:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2138D4FCC9;
 Wed,  9 Oct 2019 20:53:03 +0000 (UTC)
Received: from localhost (ovpn-116-5.gru2.redhat.com [10.97.116.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 607FF5EE1D;
 Wed,  9 Oct 2019 20:52:52 +0000 (UTC)
Date: Wed, 9 Oct 2019 17:52:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 00/10] Introduce the microvm machine type
Message-ID: <20191009205251.GA4084@habkost.net>
References: <20191004093752.16564-1-slp@redhat.com>
 <20191005180721-mutt-send-email-mst@kernel.org>
 <87sgo4oek7.fsf@redhat.com>
 <20191009152109-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009152109-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 09 Oct 2019 20:53:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sergio Lopez <slp@redhat.com>, lersek@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 09, 2019 at 03:21:46PM -0400, Michael S. Tsirkin wrote:
> On Mon, Oct 07, 2019 at 03:44:40PM +0200, Sergio Lopez wrote:
> > 
> > Michael S. Tsirkin <mst@redhat.com> writes:
> > 
> > > On Fri, Oct 04, 2019 at 11:37:42AM +0200, Sergio Lopez wrote:
> > >> Microvm is a machine type inspired by Firecracker and constructed
> > >> after the its machine model.
> > >> 
> > >> It's a minimalist machine type without PCI nor ACPI support, designed
> > >> for short-lived guests. Microvm also establishes a baseline for
> > >> benchmarking and optimizing both QEMU and guest operating systems,
> > >> since it is optimized for both boot time and footprint.
> > >
> > > Pls take a look at patchew warnings and errors.
> > > Both coding style issues and test failures need to be
> > > addressed somehow I think.
> > 
> > I've fixed the issue with the test suite, but I'm not sure what to do
> > about the coding style errors. Every one of them (except perhaps one at
> > xen-hvm.c) comes from code I've moved from pc.c to x86.c. I'd say fixing
> > those are outside the scope of the corresponding patches, but please
> > correct me if I'm wrong.
> 
> Yea if you refactor code you have to kick it into shape
> at the same time. Can be a separate patch to ease review.

I don't think it is reasonable to require code to be 100%
CODING_STYLE-compliant before being moved to a new file.  We can
still encourage cleaning it up, of course, but I don't see the
benefit of making it a requirement.

-- 
Eduardo

