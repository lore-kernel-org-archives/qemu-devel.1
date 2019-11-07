Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B948CC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83790214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhkXh82t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83790214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSgst-0000Mx-JA
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 07:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57287)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iSgrw-0008KK-7N
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iSgru-00025Z-5K
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:26:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29910
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iSgrt-000210-Nm
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573129588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIUbmuqJOqBP5kNPeEPovXNs+OwhtxCbYFiZa+FvCTU=;
 b=KhkXh82tqpcYdN37PxNIBmtw+OxPyckMRF0KvpgPzjBIAfzIozxNKD/gJfoyW0a+thMjJO
 qscKMfsfCCMLqSbz2CEtm/TSkfTGEYpg+HY1S4bBAFaVZpuvSpoWAomRwbHtcsUG8v+09c
 F6kpXCjLAtj7BqraFyaenT95gw512tY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-qMocIRIrOhKkGpyAQjZ4GQ-1; Thu, 07 Nov 2019 07:26:25 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93DDC8017E0;
 Thu,  7 Nov 2019 12:26:24 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C782B5D9E5;
 Thu,  7 Nov 2019 12:26:14 +0000 (UTC)
Date: Thu, 7 Nov 2019 12:26:12 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC 3/3] tests/vhost-user-fs-test: add vhost-user-fs test case
Message-ID: <20191107122612.GJ2816@work-vm>
References: <20191025100152.6638-1-stefanha@redhat.com>
 <20191025100152.6638-4-stefanha@redhat.com>
 <20191029003605.GC2508@work-vm>
 <20191105160252.GF166646@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191105160252.GF166646@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: qMocIRIrOhKkGpyAQjZ4GQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, virtio-fs@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Stefan Hajnoczi (stefanha@gmail.com) wrote:
> On Tue, Oct 29, 2019 at 12:36:05AM +0000, Dr. David Alan Gilbert wrote:
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > +static void after_test(void *arg G_GNUC_UNUSED)
> > > +{
> > > +    unlink(socket_path);
> > > +
> > > +    remove_dir_and_children(shared_dir);
> >=20
> > This scares me. Especially since it's running as root.
> > Can we add a bunch of paranoid checks to make sure it doesn't
> > end up rm -rf / ?
>=20
> Yes, we can resolve the path and check it is not "/".

I suggest checking for "/", ".", ".." and ""
if any of those get in it's probably bad.

> > > +/* Open a file by nodeid using FUSE_OPEN */
> > > +static int32_t fuse_open(QVirtioFS *vfs, uint64_t nodeid, uint32_t f=
lags,
> > > +                         uint64_t *fh)
> > > +{
> > > +    struct fuse_in_header in_hdr =3D {
> > > +        .opcode =3D guest32(FUSE_OPEN),
> > > +        .unique =3D guest64(virtio_fs_get_unique(vfs)),
> > > +        .nodeid =3D guest64(nodeid),
> > > +    };
> > > +    struct fuse_open_in in =3D {
> > > +        .flags =3D guest32(flags),
> > > +    };
> > > +    struct iovec sg_in[] =3D {
> > > +        { .iov_base =3D &in_hdr, .iov_len =3D sizeof(in_hdr) },
> > > +        { .iov_base =3D &in, .iov_len =3D sizeof(in) },
> > > +    };
> > > +    struct fuse_out_header out_hdr;
> > > +    struct fuse_open_out out;
> > > +    struct iovec sg_out[] =3D {
> > > +        { .iov_base =3D &out_hdr, .iov_len =3D sizeof(out_hdr) },
> > > +        { .iov_base =3D &out, .iov_len =3D sizeof(out) },
> > > +    };
> >=20
> > I wonder if anything can be done to reduce the size of the iovec boiler
> > plate?
>=20
> I'm not aware of a clean way to build the iovec array automatically but
> we could do this if you prefer it:
>=20
>   #define IOVEC(elem) { .iov_base =3D &elem, .iov_len =3D sizeof(elem) }
>=20
>   struct iovec sg_in[] =3D {
>     IOVEC(in_hdr),
>     IOVEC(in),
>   };
>=20
> Do you find this nicer?

Only a little; probably not worth it.

Dave

> Stefan


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


