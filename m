Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83696C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:39:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528D720786
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0F/qqdv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528D720786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83iK-0006p0-J2
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k82eH-0007Tk-7Y
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:31:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48780
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k82eF-0002BR-D2
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597761094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2jRHxRUkVia0ftUYOeg7xMWInz8RanHouG2wWqz044=;
 b=F0F/qqdvUQz/UZwDxNgO33+QBb5Vuz8IyglZqFQXXlkmdHUoAWWXb00rPBCWQZWDRzkfeP
 G0N9Ui5etpjaftGlH2OEidUkmfA2hSlYGsAYev43m/jDr3wlwEvMwyLTg6GBpYWo6d/BXw
 0ubxK/BS5gAyRkyvT6sb/tfpYBSmJms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-meBSS16qP-uN0e9kZhhe6A-1; Tue, 18 Aug 2020 10:31:30 -0400
X-MC-Unique: meBSS16qP-uN0e9kZhhe6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D84D10082E5;
 Tue, 18 Aug 2020 14:31:14 +0000 (UTC)
Received: from gondolin (ovpn-112-221.ams2.redhat.com [10.36.112.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96F527A406;
 Tue, 18 Aug 2020 14:31:03 +0000 (UTC)
Date: Tue, 18 Aug 2020 16:31:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: virtio-vsock requires 'disable-legacy=on' in QEMU 5.1
Message-ID: <20200818163101.72abd288.cohuck@redhat.com>
In-Reply-To: <20200818140120.c46fsf6cia2ol53v@steredhat>
References: <CAGxU2F7pVNWtJG2BM2bk9qtJ_UHgDw4kjVqRmL-=yme7VX83Vg@mail.gmail.com>
 <20200813112820.62ffd63e.cohuck@redhat.com>
 <20200813102430.vjnc56anqjaxn4tw@steredhat.lan>
 <20200813123737.25ba11d2.cohuck@redhat.com>
 <20200813120415.s5we6mihe6fywm4a@steredhat.lan>
 <20200817122746.0b786372.cohuck@redhat.com>
 <20200817131128.lgxn3pyzuzly4edp@steredhat>
 <20200818144450.0701d68c.cohuck@redhat.com>
 <20200818140120.c46fsf6cia2ol53v@steredhat>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:16:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Halil Pasic <pasic@linux.ibm.com>, Qinghua Cheng <qcheng@redhat.com>,
 qemu devel list <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Aug 2020 16:01:20 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

> On Tue, Aug 18, 2020 at 02:44:50PM +0200, Cornelia Huck wrote:

> > It seems to me that the status before this was "works by accident, but
> > only if we're not negotiating to legacy, or the guest/host are both
> > little endian". IOW, no visible breakage for most people (or we'd
> > probably have heard of it already). Now we have a setup that's correct,
> > but forces users to adapt their QEMU command lines. Option 1 would
> > eliminate the need to do that, but would cause possibly
> > not-really-fixable migration issues (you can probably deal with that
> > manually, detaching and re-attaching the device as a last resort.)
> > 
> > So, force modern, probably also remove the -transitional device type,
> > and put a prominent explanation into the change log?
> >   
> 
> I completely agree with your analysis and solution.
> 
> So, for now we need to patch vhost-vsock-pci and vhost-user-vsock-pci,
> and queue the patches in stable.

I think we should also change -ccw; even though users won't get an
error when starting QEMU, they might still run into the legacy problems
in theory.

Not sure how fast we'll have a stable release, though.

> 
> Do you prefer to send them? Otherwise I can do that.

If you already have something on your disk, please go ahead :)

> 
> Thanks again for the help and the test with s390x guest!

np; especially as it was my patch which started this in the first place
:/


