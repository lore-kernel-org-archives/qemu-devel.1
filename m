Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E86BC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6A35205C9
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 15:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6A35205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53470 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMDzB-0000Sj-7N
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 11:51:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hMDwR-0006sJ-ID
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hMDwQ-0002Tk-KS
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:48:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hMDwQ-0002T9-Eb; Thu, 02 May 2019 11:48:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C286B307D985;
	Thu,  2 May 2019 15:48:08 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ADCC05D962;
	Thu,  2 May 2019 15:48:07 +0000 (UTC)
Date: Thu, 2 May 2019 17:48:05 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190502174805.383e42c1.cohuck@redhat.com>
In-Reply-To: <20190430203009.GJ28722@habkost.net>
References: <20190425132134.2839-1-cohuck@redhat.com>
	<20190425132134.2839-2-cohuck@redhat.com>
	<CAFEAcA8TvMqZRCrMF5orgaWy-CxTR8fr6yF2W_-Y6LYfi1pGng@mail.gmail.com>
	<20190430203009.GJ28722@habkost.net>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 02 May 2019 15:48:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 01/19] s390 vfio-ccw: Add bootindex property
 and IPLB data
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-s390x <qemu-s390x@nongnu.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502154805.DobTvzVtr_0UhLpR2BGy-aaUWbJVnKmM9PuGPX_trhA@z>

On Tue, 30 Apr 2019 17:30:09 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Apr 30, 2019 at 05:54:49PM +0100, Peter Maydell wrote:
> > On Thu, 25 Apr 2019 at 14:21, Cornelia Huck <cohuck@redhat.com> wrote:  
> [...]
> > > -        SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
> > > -                                                            TYPE_SCSI_DEVICE);
> > > -
> > > -        if (sd) {
> > > +        switch (devtype) {
> > > +        case CCW_DEVTYPE_SCSI:
> > > +            sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
> > > +                                                           TYPE_SCSI_DEVICE);  
> > 
> > Coverity doesn't like the use of object_dynamic_cast() without a
> > check that the return value isn't NULL before we dereference
> > it a few lines further down.
> > 
> > I think that if we know this cast must always succeed, we
> > could instead just write
> >   SCSIDevice *sd = SCSI_DEVICE(dev_st);
> > 
> > On the other hand if the cast might not succeed because dev_st
> > isn't necessarily of the right type, then we should check it
> > for NULL and handle that appropriately.  
> 
> s390_get_ccw_device() will set devtype=CCW_DEVTYPE_SCSI only if
> dev_st is TYPE_SCSI_DEVICE, so the cast must always succeed and
> we should use SCSI_DEVICE(dev_st) here.
> 

Yes; sending a patch.

