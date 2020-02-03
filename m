Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A9C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AADA2080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFOxlqTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AADA2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZ5v-0004Bz-Dx
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 05:36:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyZ51-0003il-Uz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:35:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyZ4z-0005wv-U7
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:35:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47240
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyZ4z-0005vv-Q2
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580726144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UwvhKJscBu/jvSvATBPkQXHVs+z1Yz4LiRb+sW4N7Oo=;
 b=iFOxlqTZ4kwe60EIJyT3zbXH66Cf0rn67IIzwUwp6LtcnZqQy4Cpu71GQz8vZC+Mtnz9hx
 nA9dNxYstG7Go4uECtUeIpdCdXi/apLX766gXacfDmf5/cdei7RqtIuQOHnETiEJGjpj+M
 ejYcIU7w6l8MkmXLPzvl4woYTAPnBDo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-lFHGe4R1MzWvBL2WLJtzuQ-1; Mon, 03 Feb 2020 05:35:43 -0500
Received: by mail-qt1-f199.google.com with SMTP id m8so9611328qta.20
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 02:35:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fE7Ko1jeOyOaVjCGOPKByJePPozUbhpAbAiZqcUsF5s=;
 b=JYswMGTxF1+MWGLNK/NKoDLGK2xDZzFSZz4Q1GpbZuuRkxH7/crxw9z8vMcRdETwk2
 IfUhpuCURaYV9/Bn+l2r7hVauuHwqMYLJYW1B4vDnx/fmSqj3nKwGNC98VlMVWc01fNx
 0/sjxfYNs+wwjKIti1m/WR50rhK4d/usBUmLmiux8LjU6TYugajoWPA8iFkz5NY5hXNu
 hpnhAMqdvLH9GIoMOE0zb5Jj/2tzeaX31XBoeCe/pMy9qpPKe5pZlOx0gZr9CxFKXtFJ
 AEt2sCFyEm4TtFgSyE1Sxt2jxFNScoGwU8FctIccT2hZqTrTZm5LlLE7h4xE8TJOJTFf
 b2gg==
X-Gm-Message-State: APjAAAXKhElVA6ezxPdNLr0hqJ1d0WlsjCzOdPA5lIF34jNd0QRfyboS
 tyLo9PzRIQKhli+Fav/emGUXXYCCp7mbaPQEkAAKi0iEhZfWN2duXRtF62sCiS76TAYGcmV/kZA
 f+I8S92H7miietVI=
X-Received: by 2002:ac8:70d3:: with SMTP id g19mr22631311qtp.209.1580726142645; 
 Mon, 03 Feb 2020 02:35:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbS5Gq8QJ3EOpiTDllDY48yoZdVWnJyY2NUq9WKBlqThhqZsWkNxwtULhX9WS8zXF9arUFuQ==
X-Received: by 2002:ac8:70d3:: with SMTP id g19mr22631299qtp.209.1580726142398; 
 Mon, 03 Feb 2020 02:35:42 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id u24sm9049976qkm.40.2020.02.03.02.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 02:35:41 -0800 (PST)
Date: Mon, 3 Feb 2020 05:35:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Subject: Re: [PATCH v2 2/4] virtio-scsi: default num_queues to -smp N
Message-ID: <20200203053205-mutt-send-email-mst@kernel.org>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-3-stefanha@redhat.com>
 <20200127141031.6e108839.cohuck@redhat.com>
 <20200129154438.GC157595@stefanha-x1.localdomain>
 <bc9680fc-c382-301f-a1fe-21740c918570@redhat.com>
 <20200130105235.GC176651@stefanha-x1.localdomain>
 <20200203102529.3op54zggtquoguuo@dritchie>
MIME-Version: 1.0
In-Reply-To: <20200203102529.3op54zggtquoguuo@dritchie>
X-MC-Unique: lFHGe4R1MzWvBL2WLJtzuQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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
>=20
> On the other hand, the increase in host resource requirements may have
> unforeseen in some environments, specially to virtio-blk users with
> multiple disks.
>=20
> All in all, I don't have data that would justify setting the limit to
> one value or the other. The only argument I can put on the table is
> that, so far, we only had one VQ per device, so perhaps a conservative
> value (4? 8?) would make sense from a safety and compatibility point
> of view.
>=20
> Thanks,
> Sergio.
>=20

A bit more testing with different vcpu values can't hurt here ...
Stefan?

--=20
MST


