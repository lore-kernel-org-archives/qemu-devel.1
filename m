Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCFEC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 07:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A849721736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 07:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6d4dUyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A849721736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaapX-0000BM-OJ
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 02:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46317)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iaaij-000558-1f
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iaaih-0003fx-O3
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:29:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52602
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iaaih-0003XA-JG
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 02:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575012577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myiM2jB3BAAt+97hTTYInGs4H8+sWsiz2awia6JDoGY=;
 b=H6d4dUyI9EpSoo5OWSvlfc2P9x4k9n3kYk+Ty6b5UDgsngRS3VbzgwzBhx9kTOjC3Hf9SP
 EgMdVolruRYsQLXT4B8/A/bur+BQZz5zgnVt3/BvVFjNqzFm5v/Xe3Q6jtEzRaswb4/WlP
 UlXAZzYk7nXBDReit2/N29J1e+vhWCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-7QyO11nNObmT_7vW29Bs_Q-1; Fri, 29 Nov 2019 02:29:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46010800D41;
 Fri, 29 Nov 2019 07:29:31 +0000 (UTC)
Received: from gondolin (ovpn-116-140.ams2.redhat.com [10.36.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1B6860900;
 Fri, 29 Nov 2019 07:29:25 +0000 (UTC)
Date: Fri, 29 Nov 2019 08:29:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] hw: add compat machines for 5.0
Message-ID: <20191129082923.1c4d72fc.cohuck@redhat.com>
In-Reply-To: <20191128203811.GD14595@habkost.net>
References: <20191112104811.30323-1-cohuck@redhat.com>
 <20191128183706.21b1fe0e.cohuck@redhat.com>
 <20191128203811.GD14595@habkost.net>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 7QyO11nNObmT_7vW29Bs_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 17:38:11 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Thu, Nov 28, 2019 at 06:37:06PM +0100, Cornelia Huck wrote:
> > On Tue, 12 Nov 2019 11:48:11 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> > > Add 5.0 machine types for arm/i440fx/q35/s390x/spapr.
> > > 
> > > For i440fx and q35, unversioned cpu models are still translated
> > > to -v1; I'll leave changing this (if desired) to the respective
> > > maintainers.
> > > 
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > ---
> > > 
> > > also pushed out to https://github.com/cohuck/qemu machine-5.0
> > > 
> > > x86 folks: if you want to change the cpu model versioning, I
> > > can do it in this patch, or just do it on top yourselves  
> > 
> > So, do we have a final verdict yet (keep it at v1)?
> > 
> > If yes, I'll queue this via the s390 tree, unless someone else beats me
> > to it.  
> 
> We won't change default_cpu_version in 5.0, so:
> 
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> 

Thanks!

Will queue through the s390 tree.


