Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582FCC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24378214E0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 15:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtLGCmTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24378214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUBfK-0000Wm-JP
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 10:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iUBcq-00070v-0Y
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iUBcn-0002Pz-Bt
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:29:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40809
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iUBcm-0002Pm-UQ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 10:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573486144;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZUpsan7ynawPn4cZlERvm27mWsq78DDG0gqXnnrob8=;
 b=KtLGCmTmaTAxf8ydn0tAivY/wLDDM5VGn/hMLEAgZ4UMsVBzOes3BIUyUUUvhYVPWpPKi5
 5HP1qpXsTsRMlYA0B7ppHv2BvCsrQMZzgy35qGuF8CExubK7/sd7LZDKsRUtpFD7wrzLM6
 v/RkKtvCQzJNOxZ08CIc+t4CG20XHLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-kNwO3cPvP4G4TGyclD_Uhg-1; Mon, 11 Nov 2019 10:27:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79471106BB8C;
 Mon, 11 Nov 2019 15:27:54 +0000 (UTC)
Received: from redhat.com (ovpn-112-45.ams2.redhat.com [10.36.112.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9878C5D9C9;
 Mon, 11 Nov 2019 15:27:46 +0000 (UTC)
Date: Mon, 11 Nov 2019 15:27:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC][PATCH 2/3] docs/specs: Add specification of ivshmem device
 revision 2
Message-ID: <20191111152743.GM814211@redhat.com>
References: <cover.1573477032.git.jan.kiszka@siemens.com>
 <f5996d934d24775160bcedbf28ac975a95d91101.1573477032.git.jan.kiszka@siemens.com>
 <20191111084327-mutt-send-email-mst@kernel.org>
 <0b0475c1-2564-f433-46d8-ff1a06c13569@siemens.com>
 <20191111100607-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191111100607-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: kNwO3cPvP4G4TGyclD_Uhg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: liang yan <lyan@suse.com>, Jailhouse <jailhouse-dev@googlegroups.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Hannes Reinecke <hare@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 11, 2019 at 10:08:20AM -0500, Michael S. Tsirkin wrote:
> On Mon, Nov 11, 2019 at 02:59:07PM +0100, Jan Kiszka wrote:
> > On 11.11.19 14:45, Michael S. Tsirkin wrote:
> > > On Mon, Nov 11, 2019 at 01:57:11PM +0100, Jan Kiszka wrote:
> > > > +| Offset | Register               | Content                       =
                       |
> > > > +|-------:|:-----------------------|:------------------------------=
-----------------------|
> > > > +|    00h | Vendor ID              | 1AF4h                         =
                       |
> > > > +|    02h | Device ID              | 1110h                         =
                       |
> > >=20
> > > Given it's a virtio vendor ID, please reserve a device ID
> > > with the virtio TC.
> >=20
> > Yeah, QEMU's IVSHMEM was always using that. I'm happy to make this fina=
lly
> > official.
> >=20
>=20
> And I guess we will just mark it reserved or something right?
> Since at least IVSHMEM 1 isn't a virtio device.
> And will you be reusing same ID for IVSHMEM 2 or a new one?

1110h isn't under either of the virtio PCI device ID allowed ranges
according to the spec:

  "Any PCI device with PCI Vendor ID 0x1AF4, and PCI Device
   ID 0x1000 through 0x107F inclusive is a virtio device.
   ...
   Additionally, devices MAY utilize a Transitional PCI Device=20
   ID range, 0x1000 to 0x103F depending on the device type. "

So there's no need to reserve 0x1110h from the virtio spec POV.

I have, however, ensured it is assigned to ivshmem from POV of
Red Hat's own internal tracking of allocated device IDs, under
its vendor ID.

If ivshmem 2 is now a virtio device, then it is a good thing that
it will get a new/different PCI device ID, to show that it is not
compatible with the old device impl.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


