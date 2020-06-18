Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB137C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E6FE20706
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WXCR2Jxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E6FE20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlrwH-0002LT-Rk
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 06:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlru0-00088e-Be
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:36:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28750
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jlrtw-0007p3-Qd
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 06:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592476568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C7gHvRvY9nNUkmf9VtA8p2rNmnge1ZQpYC/0H05afo8=;
 b=WXCR2JxyWYVhM/YfhEAnXZU5GiQogNTUEBCC5Ire5RcpcHjIu/rg0prJu9iDAOXLYvFZce
 wBMXddrG6nM6KeVD0+Hoibr+dGgG5zzExnc9X5EkpSoxO5K7N+x/aIJ7+jQx2NQtQDMk+2
 FQF5QHkfVojFaIaMGcRQe2/zUv6uk20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-TUyYlulAM9CMcfDbr7WiOw-1; Thu, 18 Jun 2020 06:36:06 -0400
X-MC-Unique: TUyYlulAM9CMcfDbr7WiOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB02F18FE866;
 Thu, 18 Jun 2020 10:36:04 +0000 (UTC)
Received: from gondolin (ovpn-113-9.ams2.redhat.com [10.36.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2859310013D6;
 Thu, 18 Jun 2020 10:35:59 +0000 (UTC)
Date: Thu, 18 Jun 2020 12:35:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/1] docs/s390x: fix vfio-ap device_del description
Message-ID: <20200618123557.5c2ad135.cohuck@redhat.com>
In-Reply-To: <38f61553-10d9-2d45-0e10-ef30f9607b0f@redhat.com>
References: <20200617160604.5593-1-borntraeger@de.ibm.com>
 <38f61553-10d9-2d45-0e10-ef30f9607b0f@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:32:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jun 2020 19:17:54 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 17/06/2020 18.06, Christian Borntraeger wrote:
> > device_del requires an id and not a sysfsfile.
> > 
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---
> >  docs/system/s390x/vfio-ap.rst | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/docs/system/s390x/vfio-ap.rst b/docs/system/s390x/vfio-ap.rst
> > index 3cd84179a2df..f441df69edde 100644
> > --- a/docs/system/s390x/vfio-ap.rst
> > +++ b/docs/system/s390x/vfio-ap.rst
> > @@ -606,10 +606,11 @@ action.
> >  
> >  To hot plug a vfio-ap device, use the QEMU ``device_add`` command::
> >  
> > -    (qemu) device_add vfio-ap,sysfsdev="$path-to-mdev"
> > +    (qemu) device_add vfio-ap,sysfsdev="$path-to-mdev",id="$id"
> >  
> >  Where the ``$path-to-mdev`` value specifies the absolute path to a mediated
> >  device to which AP resources to be used by the guest have been assigned.
> > +``$id`` is the name value for the optional id parameter.
> >  
> >  Note that on Linux guests, the AP devices will be created in the
> >  ``/sys/bus/ap/devices`` directory when the AP bus subsequently performs its periodic
> > @@ -632,10 +633,9 @@ or a prior hot plug action.
> >  
> >  To hot unplug a vfio-ap device, use the QEMU ``device_del`` command::
> >  
> > -    (qemu) device_del vfio-ap,sysfsdev="$path-to-mdev"
> > +    (qemu) device_del "id"  
> 
> Do you want to use $id instead of id here?
> >  
> > -Where ``$path-to-mdev`` is the same as the path specified when the vfio-ap
> > -device was attached to the virtual machine's ap-bus.
> > +Where ``$id`` is the same id that was specified at device creation.  
> 
>             ^--- ... since you use $id here.
> 
> >  On a Linux guest, the AP devices will be removed from the ``/sys/bus/ap/devices``
> >  directory on the guest when the AP bus subsequently performs its periodic scan,  
> 
> With the 1 $ question fixed:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Indeed, no reason to skimp on the $s :)

Fixed up and pushed to s390-next, thanks.


