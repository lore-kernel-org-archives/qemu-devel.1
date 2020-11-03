Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CC9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29D5520E65
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvbHxIOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D5520E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzud-0002c2-7s
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZztq-000211-3e
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:15:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZzto-0004hu-Gs
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604423711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DnKtQ25ZhyvNzyRAGpetjcC/qDZMdfc25zT/VFEDofc=;
 b=YvbHxIOaCVkC4hP5uctFiVZS6l+/SlefIjQT7Q5kn34/Kv41K/vku3FznxSXCsqe6sa6I/
 Y3JkDJE6qTpnxKsOIyhs1OcdxZGbg/1r5jY2xIey5SoYvE8R+5HblSh1QjUx+eAIakIenL
 uJNBBBJC25V6x2I7daqnXaHdWErR+YE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-BzukcTQlN76FpiOmGzNUFg-1; Tue, 03 Nov 2020 12:15:06 -0500
X-MC-Unique: BzukcTQlN76FpiOmGzNUFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47C33186DD33;
 Tue,  3 Nov 2020 17:15:05 +0000 (UTC)
Received: from localhost (ovpn-115-37.ams2.redhat.com [10.36.115.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CBF61002C3A;
 Tue,  3 Nov 2020 17:15:00 +0000 (UTC)
Date: Tue, 3 Nov 2020 17:14:57 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 v2 00/25] block/nvme: Fix Aarch64 or big-endian
 hosts
Message-ID: <20201103171457.GB259481@stefanha-x1.localdomain>
References: <20201029093306.1063879-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201029093306.1063879-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2020 at 10:32:41AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Add a bit of tracing, clean around to finally fix few bugs.
> In particular, restore NVMe on Aarch64 host.
>=20
> Since v1:
> - addressed Stefan and Eric review comments
> - dropped unnecessary patches
> - added BE fix reported by Keith
>=20
> Patches missing review: #10, #24, #25
>=20
> Supersedes: <20201027135547.374946-1-philmd@redhat.com>
>=20
> Eric Auger (4):
>   block/nvme: Change size and alignment of IDENTIFY response buffer
>   block/nvme: Change size and alignment of queue
>   block/nvme: Change size and alignment of prp_list_pages
>   block/nvme: Align iov's va and size on host page size
>=20
> Philippe Mathieu-Daud=E9 (21):
>   MAINTAINERS: Cover 'block/nvme.h' file
>   block/nvme: Use hex format to display offset in trace events
>   block/nvme: Report warning with warn_report()
>   block/nvme: Trace controller capabilities
>   block/nvme: Trace nvme_poll_queue() per queue
>   block/nvme: Improve nvme_free_req_queue_wait() trace information
>   block/nvme: Trace queue pair creation/deletion
>   block/nvme: Move definitions before structure declarations
>   block/nvme: Use unsigned integer for queue counter/size
>   block/nvme: Make nvme_identify() return boolean indicating error
>   block/nvme: Make nvme_init_queue() return boolean indicating error
>   block/nvme: Introduce Completion Queue definitions
>   block/nvme: Use definitions instead of magic values in add_io_queue()
>   block/nvme: Correctly initialize Admin Queue Attributes
>   block/nvme: Simplify ADMIN queue access
>   block/nvme: Simplify nvme_cmd_sync()
>   block/nvme: Set request_alignment at initialization
>   block/nvme: Correct minimum device page size
>   block/nvme: Fix use of write-only doorbells page on Aarch64 arch
>   block/nvme: Fix nvme_submit_command() on big-endian host
>   block/nvme: Simplify Completion Queue Command Identifier field use
>=20
>  include/block/nvme.h |  18 ++--
>  block/nvme.c         | 213 ++++++++++++++++++++++++-------------------
>  MAINTAINERS          |   2 +
>  block/trace-events   |  30 +++---
>  4 files changed, 150 insertions(+), 113 deletions(-)
>=20
> --=20
> 2.26.2
>=20
>=20

Thanks, applied the 5.2 patches to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+hkBEACgkQnKSrs4Gr
c8ileggArs55IPlNdr3tVQK2KWnj3kjugOzJppqbH0OiKUizHUClKx/vWhsBTTWk
Hoo414rVWcqOJYt/9XeGkGF8w8izb1LAwzgq6W14tqi3OsPBEKHDMDdB6Opjchgk
u7jW5maLdJyHxWuv9mUvrLZkqJL/LHQLWRgnHM/5IU+uc+HRrx8X3cxF4e3nEYQB
+LM7OiLPpk7F3k+VRVIMl8IrksPcS1OMQDZx7ZdgjTkxuyPFTcKHkn5wpcXeaUum
mCrWoQlGz9In1El0H/703BmUk1XMsu+HfnzWCXopBZlXj3exD97rv/lToS1I1sp5
6vAKsA0e7p12rvb51tTMA4DFeatHag==
=E1MZ
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--


