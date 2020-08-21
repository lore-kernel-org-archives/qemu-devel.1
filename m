Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CDDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC53020724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDCNfUYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC53020724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95Qw-00039Z-Vf
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k94ua-0007ZQ-BG
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 07:08:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k94uY-00070i-36
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 07:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598008119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=HPT91OStJ7xaQQnCY/LD0gBIVyZinn4YDdhSPg0Yn7U=;
 b=HDCNfUYYBBAzioX0OqkcOt+ed/oBFsrz27O5Ja270tsHkVNmK/5MQpnto0FbsFKoOOl4Kx
 2uI5o+CpJ6h5toZTnaM7THeTPWqG5sVA+dYfWqkkIWxv0/HYaza0c1cWLP1BHtryFnWMfq
 E0fmVBVEESVI4dOf27ruJAjJdTTZiCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-vYQGiLzFPUum6hAcDGmvqA-1; Fri, 21 Aug 2020 07:08:37 -0400
X-MC-Unique: vYQGiLzFPUum6hAcDGmvqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C84F41007469;
 Fri, 21 Aug 2020 11:08:35 +0000 (UTC)
Received: from localhost (ovpn-113-166.ams2.redhat.com [10.36.113.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5C5E7C533;
 Fri, 21 Aug 2020 11:08:23 +0000 (UTC)
Date: Fri, 21 Aug 2020 12:08:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: VHOST_USER_PROTOCOL_F_VDPA
Message-ID: <20200821110822.GA205318@stefanha-x1.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.326
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Tiwei Bie <tiwei.bie@intel.com>, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 qemu-devel@nongnu.org, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 kraxel@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Changpeng Liu <changpeng.liu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The first vDPA ioctls have been added to the vhost-user protocol and I
wonder if it's time to fully change the vhost-user protocol's focus to
providing a full VIRTIO device model like vDPA does.

Initially vhost-user was just used for vhost-net. As a result it didn't
need the full VIRTIO device model including the configuration space and
device status register.

Over the years device-specific messages were added to extend vhost-user
to cover more of the VIRTIO device model. vhost-user-blk needed
configuration space support, for example.

The problem for VMMs and device backend implementors is that the
protocol is currently positioned halfway between the original vhost-net
approach and the full VIRTIO device model. Even if a VMM implements
VHOST_USER_GET_CONFIG, it can only expect it to work with
vhost-user-blk, not vhost-user-net. Similarly, a vhost-user-net device
backend cannot implement VHOST_USER_GET_CONFIG and expect all VMMs to
allow it to participate in configuration space emulation because
existing VMMs won't send that message.

The current approach where each device type uses a undocumented subset
of vhost-user messages is really messy. VMM and device backend
implementors have to look at existing implementations to know what is
expected for a given device type. It would be nice to switch to the
VIRTIO device model so that the VIRTIO specification can be used as the
reference for how device types work.

Now that vDPA is here and extends the kernel vhost ioctls with a full
VIRTIO device model, it might be a good time to revise the vhost-user
protocol.

A vdpa-user protocol (or vhost-user 2.0) would replace the current mess
with a full VIRTIO device model. Both VMMs and device backends would
require changes to support this, but it would be a cleaner path forward
for the vhost-user protocol.

One way of doing this would be a new VHOST_USER_PROTOCOL_F_VDPA feature
bit that indicates all the currently existing Linux vDPA ioctl messages
are available. Legacy vhost-user messages with overlapping functionality
must not be used when this bit is set. Most importantly, device backends
need to implement the full VIRTIO device model, regardless of device
type (net, blk, scsi, etc).

The device type most affected by this change would be virtio-net. The
other device types are already closer to the full VIRTIO device model.

I wanted to share this idea in case someone is currently trying to
figure out how to add more VIRTIO device model functionality to
vhost-user.

Stefan

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8/qx8ACgkQnKSrs4Gr
c8hLsgf+KnFJ3i15fHU4n6xO69ow1wGoU86OAje1BS15wejsMrpwnwNL+hcX6W93
KXGRAqaQHeUwIXaQMIe05RourPl1A0H4IIQNenReWnKDKnoV8qqEN2OG2Q9WxX9q
W8lvXZ8JFmbma2zTotG4teTB558dHwrE++FljudTjWUN0wjVQLA7JHYcGr1561J2
KeVF11Z/a0yDXrEPvc6dIjZqEpmtcR6f8shGRLgcvaOmeugdse1J5tV13MWA9Dv1
g4qPlxlwLHpblEeuUnfpjTYlchIkcdSfu5mGnGgQGS77SIkezqQnBUkZ+wqLwnxM
9Xy+CuAX+wiJXWH4XkkcsXoVLv6BUQ==
=wZNX
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--


