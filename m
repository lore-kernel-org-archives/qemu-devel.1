Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FB5C83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DB62074A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 14:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzYxoFiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DB62074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUAKn-0004O1-QV
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 10:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jUAH1-0007Vg-Cp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jUAGz-0006VJ-8h
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:34:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37670
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jUAGy-0006V1-S1
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 10:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588257283;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gr9mZHYm1mbvL06H8cfLy/QWvH+yZ284xFyWZ9hXbS4=;
 b=AzYxoFiVOELguQjFatXAgu4gKjPBPPoNWMKUUiB84Lv5LMC95Ff5XJ0Icegcon1udplHw3
 vSOX9OgMvF270BltiGuMoI0LlmLmGZt5nnEa5KCRgmqc5O3IVLhqzoQ/gL3CvDxiRIgJrV
 1NONcYa0z+NSe0vRvddx8Gh31QEjRR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-WS6IB-f0MCW-QvhnR72ygw-1; Thu, 30 Apr 2020 10:34:37 -0400
X-MC-Unique: WS6IB-f0MCW-QvhnR72ygw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32C6C80B70C
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 14:34:36 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9D4260C87;
 Thu, 30 Apr 2020 14:34:28 +0000 (UTC)
Date: Thu, 30 Apr 2020 15:34:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] virtiofsd: Show submounts
Message-ID: <20200430143425.GD2184629@redhat.com>
References: <20200424133516.73077-1-mreitz@redhat.com>
 <20200427175902.GM2923@work-vm> <20200429145720.GA2835@work-vm>
 <8c73f374-fcc8-1684-b581-84a9ab501aa9@redhat.com>
 <20200430085812.GC2874@work-vm>
 <20200430135639.GA260081@redhat.com>
 <20200430142013.GI2874@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200430142013.GI2874@work-vm>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, Vivek Goyal <vgoyal@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 30, 2020 at 03:20:13PM +0100, Dr. David Alan Gilbert wrote:
> * Vivek Goyal (vgoyal@redhat.com) wrote:
> > On Thu, Apr 30, 2020 at 09:58:12AM +0100, Dr. David Alan Gilbert wrote:
> > [..]
> > > > > Even without this patch, the SLAVE stuff worked so if you start t=
he
> > > > > daemon and *then* mount under the shared directory, the guest see=
s it
> > > > > with or without this patch.
> > > >=20
> > > > Hm, I don=E2=80=99t.  Do you really?
> > >=20
> > > Yes! With your patch reverted:
> > >=20
> > > Start virtiofsd, mount in the guest:
> > >=20
> > > host:
> > > # ./virtiofsd --socket-path=3D/tmp/vhostqemu -o source=3D/home/dgilbe=
rt/virtio-fs/fs  -o log_level=3Dwarn -o no_writeback
> > >=20
> > > guest:
> > > # mount -t virtiofs myfs /sysroot
> > >=20
> > > host:
> > > # findmnt -o +PROPAGATION -N 6100
> > > TARGET SOURCE                                                        =
      FSTYPE OPTIONS                                                      P=
ROPAGATION
> > > /      /dev/mapper/fedora_dgilbert--t580-root[/home/dgilbert/virtio-f=
s/fs] xfs    rw,relatime,seclabel,attr2,inode64,logbufs=3D8,logbsize=3D32k,=
no private,slave
> > > # mount -t tmpfs /dev/null /home/dgilbert/virtio-fs/fs/tmp
> > > # findmnt -o +PROPAGATION -N 6100
> > > TARGET SOURCE                                                        =
      FSTYPE OPTIONS                                                      P=
ROPAGATION
> > > /      /dev/mapper/fedora_dgilbert--t580-root[/home/dgilbert/virtio-f=
s/fs] xfs    rw,relatime,seclabel,attr2,inode64,logbufs=3D8,logbsize=3D32k,=
no private,slave
> > > =E2=94=94=E2=94=80/tmp /dev/null                                     =
                      tmpfs  rw,relatime,seclabel                          =
               private,slave
> >=20
> > Why is it showing a mount point at "/tmp". If mount point propagated, t=
hen
> > inside guest we should see a mount point at /sysroot/tmp?
>=20
> That findmnt is on the host.
>=20
> > So there are two things.
> >=20
> > A. Propagation of mount from host to virtiofsd.
> > B. Visibility of that mount inside guest over fuse protocol (submount
> >   functionality).
> >=20
> > I think A works for me without any patches. But don't think B is workin=
g
> > for me. I don't see the submount inside guest.=20
> >=20
> > > # touch /home/dgilbert/virtio-fs/fs/tmp/hello
> > >=20
> > > guest:
> > > # ls -l /sysroot/tmp
> > > total 0
> > > -rw-r--r-- 1 root root 0 Apr 30 08:50 hello
> >=20
> > Do a "findmnt /sysroot/tmp" inside guest and see what do you see.
> >=20
> > You will be able to see "hello" as long as virtiofsd sees the new
> > mount point, I think. And guest does not have to see that mount point
> > for this simple test to work.
>=20
> Right, the guest just sees:
>=20
> `-/sysroot                            myfs       virtiof rw,relatime

That is a good thing surely ? If I'm exporting "/sysroot" from the host,
I want the content in "/sysroot/some/sub/mount" to be visible to the
guest, but I don't want the guest to see "/sysroot/some/sub/mount"
as an actual mount point. That would be leaking information about the
host storage setup into the guest. The host admin should be free to
re-arrange submounts in the host OS, to bring more storage space online,
and have this be transparent to the guest OS.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


