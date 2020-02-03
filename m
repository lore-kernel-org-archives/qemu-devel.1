Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71E3C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23A120658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSL8E3bq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23A120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZRI-00087r-1g
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 05:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iyZQg-0007iY-EH
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iyZQf-0002yT-3v
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:58:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27074
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iyZQe-0002uu-Vm
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580727488;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3wHcIu0764/YGu7WKZ7yArQEcjKk7IGWvNX32L8D1Q4=;
 b=FSL8E3bq/70sQe8PdZmjgzG9VZuBLqwZhtKjMfqGo5+jgKun+hiwBCTzLG9JzhlIEoM+SV
 iNTusqzDXzqYT5euqF8tfomKUhpQkuBngp8TxZB/WCn0V/tdfgx7A5lIPFwBataplFi2hl
 MnUvccd8Shd8/SKIryNIukmLlxUG3VY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-24YUKCO4PnKy7wlAxK8qIg-1; Mon, 03 Feb 2020 05:57:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D710A13E6;
 Mon,  3 Feb 2020 10:57:57 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 43B8410013A7;
 Mon,  3 Feb 2020 10:57:47 +0000 (UTC)
Date: Mon, 3 Feb 2020 10:57:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v2 2/4] virtio-scsi: default num_queues to -smp N
Message-ID: <20200203105744.GD1922177@redhat.com>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-3-stefanha@redhat.com>
 <20200127141031.6e108839.cohuck@redhat.com>
 <20200129154438.GC157595@stefanha-x1.localdomain>
 <bc9680fc-c382-301f-a1fe-21740c918570@redhat.com>
 <20200130105235.GC176651@stefanha-x1.localdomain>
 <20200203102529.3op54zggtquoguuo@dritchie>
MIME-Version: 1.0
In-Reply-To: <20200203102529.3op54zggtquoguuo@dritchie>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 24YUKCO4PnKy7wlAxK8qIg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 03, 2020 at 11:25:29AM +0100, Sergio Lopez wrote:
> On Thu, Jan 30, 2020 at 10:52:35AM +0000, Stefan Hajnoczi wrote:
> > On Thu, Jan 30, 2020 at 01:29:16AM +0100, Paolo Bonzini wrote:
> > > On 29/01/20 16:44, Stefan Hajnoczi wrote:
> > > > On Mon, Jan 27, 2020 at 02:10:31PM +0100, Cornelia Huck wrote:
> > > >> On Fri, 24 Jan 2020 10:01:57 +0000
> > > >> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > >>> @@ -47,10 +48,15 @@ static void vhost_scsi_pci_realize(VirtIOPCIP=
roxy *vpci_dev, Error **errp)
> > > >>>  {
> > > >>>      VHostSCSIPCI *dev =3D VHOST_SCSI_PCI(vpci_dev);
> > > >>>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> > > >>> -    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
> > > >>> +    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.parent_obj.co=
nf;
> > > >>> +
> > > >>> +    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs */
> > > >>> +    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> > > >>> +        conf->num_queues =3D current_machine->smp.cpus;
> > > >> This now maps the request vqs 1:1 to the vcpus. What about the fix=
ed
> > > >> vqs? If they don't really matter, amend the comment to explain tha=
t?
> > > > The fixed vqs don't matter.  They are typically not involved in the=
 data
> > > > path, only the control path where performance doesn't matter.
> > >=20
> > > Should we put a limit on the number of vCPUs?  For anything above ~12=
8
> > > the guest is probably not going to be disk or network bound.
> >=20
> > Michael Tsirkin pointed out there's a hard limit of VIRTIO_QUEUE_MAX
> > (1024).  We need to at least stay under that limit.
> >=20
> > Should the guest have >128 virtqueues?  Each virtqueue requires guest
> > RAM and 2 host eventfds.  Eventually these resource requirements will
> > become a scalability problem, but how do we choose a hard limit and wha=
t
> > happens to guest performance above that limit?
>=20
> From the UX perspective, I think it's safer to use a rather low upper
> limit for the automatic configuration.
>=20
> Users of large VMs (>=3D32 vCPUs) aiming for the optimal performance are
> already facing the need of manually tuning (or relying on a software
> to do that for them) other aspects of it, like vNUMA, IOThreads and
> CPU pinning, so I don't think we should focus on this group.

Whether they're runing manually, or relying on software to tune for
them, we (QEMU maintainers) still need to provide credible guidance
on what todo with tuning for large CPU counts. Without clear info
from QEMU, it just descends into hearsay and guesswork, both of which
approaches leave QEMU looking bad.

So I think we need to, at the very least, make a clear statement here
about what tuning approach should be applied vCPU count gets high,
and probably even apply that  as a default out of the box approach.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


