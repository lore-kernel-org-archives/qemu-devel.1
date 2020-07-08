Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A98C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:27:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EDB20772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2060sBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EDB20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIX8-0004ME-FH
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtIH3-0003el-9z
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:10:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtIH0-0007qg-G7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k7M30QulHmUZ/Pj6WA2VZSdKxfe/j9VBSbxSx1e28Y8=;
 b=O2060sBlwNZIVHKbxdZOex9ykgsXVH+h+bvqtZlsjQ+6OPz3SorMBkIa3EnM4970HO63Ut
 EYwYr2KxDDuqnKohcWOXMqqpgQYYYUUidueI6Rl5Fgsz6eQgFZiTy52sY4I/LMf5Z5W/so
 oKDG7zaouGPcyzRXYJiPvfNrQXcE4vA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-oKQovDrmM7WGwHpXMk2Tqg-1; Wed, 08 Jul 2020 09:08:19 -0400
X-MC-Unique: oKQovDrmM7WGwHpXMk2Tqg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21F30108E;
 Wed,  8 Jul 2020 13:08:18 +0000 (UTC)
Received: from localhost (ovpn-115-17.ams2.redhat.com [10.36.115.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDEE71001901;
 Wed,  8 Jul 2020 13:08:14 +0000 (UTC)
Date: Wed, 8 Jul 2020 14:08:13 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v5 3/5] virtio-scsi: default num_queues to -smp N
Message-ID: <20200708130813.GE487183@stefanha-x1.localdomain>
References: <20200706135650.438362-1-stefanha@redhat.com>
 <20200706135650.438362-4-stefanha@redhat.com>
 <20200707174453.50c3ec85.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200707174453.50c3ec85.cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2020 at 05:44:53PM +0200, Cornelia Huck wrote:
> On Mon,  6 Jul 2020 14:56:48 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> Maybe mention 'pci' in the subject as well?

Actually splitting up the patch is hard due to the nvectors dependency
on num_queues. I will leave it as a single patch and rewrite the commit
message.

Stefan

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8FxT0ACgkQnKSrs4Gr
c8gGvAf/ZvwW1+lKekaQCJ/fgLr33ARcpr4/JrgmNCaPRAmzyPlfNr7/KYcVBkHw
i0HYKNc2skNMLDS0HSyu9NTj6QMkuLvss/HDacS6mN6TKjcU/pGOm0meBtWq8qJl
xcfLKNMmw+OVG6uwk/V4KvD4K536guA7vxrUoBeAhvNO1Iht77ZwbUR3CI5ZTKqa
HI0uFINLT3BCAbd2Yl5Swc9EN1zGyPMSaq2/TUVPjjl/BY55NU0WMJPdAu1vEC7n
v9JSbyaooYYp3fNbFcH4+TbkkKNHxY48cHccmptoxfiNaLFFlUjo42DZeuK0Cr9U
Tps7U0m804pfnBqAIClUPw7M3mEcWA==
=xeG5
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--


