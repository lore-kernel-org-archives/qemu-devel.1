Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DE5C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689F4207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5s3G0D2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689F4207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2wq-0007MM-Hq
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ir2vs-0006h4-71
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:51:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ir2vp-0008VA-HA
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:51:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51975
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ir2vp-0008U1-AW
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578934272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMgZ71vUfZS2/RClU+/StStQsA+OK5w96RXGV98Gb94=;
 b=h5s3G0D2EoRFv52UT9d0quhv7TA4kSr0xxTa6Ye4fLj1h59/R64dJA37j6gn59Tkq4sSX5
 BInV7JywXpSuVLKMaB5d/oZizzYVBl5yIyLKmxSrX8T7YiS0sl19KmlzuzP16t5EjgDuIY
 cLBhjPW/7bBjLaDJiwcGnY7QgBtu8QY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-qkFtJKKIM1WoYBiuqVW1vA-1; Mon, 13 Jan 2020 11:51:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B58C564A82;
 Mon, 13 Jan 2020 16:51:07 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59F55A4B60;
 Mon, 13 Jan 2020 16:51:06 +0000 (UTC)
Date: Mon, 13 Jan 2020 17:51:04 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v1 41/59] intc/s390_flic_kvm.c: remove unneeded label in
 kvm_flic_load()
Message-ID: <20200113175104.6daf383e.cohuck@redhat.com>
In-Reply-To: <20200108140046.0682253d.cohuck@redhat.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-42-danielhb413@gmail.com>
 <20200108140046.0682253d.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: qkFtJKKIM1WoYBiuqVW1vA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Jan 2020 14:00:46 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon,  6 Jan 2020 15:24:07 -0300
> Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
> 
> > 'out' label can be replaced by 'return' with the apropriate
> > value that is set by 'r' right before the jump.
> > 
> > Christian Borntraeger <borntraeger@de.ibm.com>  
> 
> I think something went wrong here; adding some cc:s.
> 
> > Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> > ---
> >  hw/intc/s390_flic_kvm.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)

> Looks fine to me; will apply unless someone sees an issue.
> 
> 

Thanks, applied (with the patch description fixed as per Thomas'
comments).


