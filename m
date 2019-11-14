Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CE7C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 11:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DFC6206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 11:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAfw2vtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DFC6206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVD5s-0000Pn-JC
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 06:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iVD5D-0008PA-AJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:14:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iVD5A-0005ZU-Mb
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:14:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24859
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iVD5A-0005ZC-DH
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 06:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573730075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j4iqKNAw7Uu8i8Uguh8Co22JSQ27b7LzQk9zwGuvfo8=;
 b=PAfw2vtgasPsaABpv3K9xXbwpnOXtBpQBGRYa1494cbkTEDlMACluNP4KTsyv5OM4wv63L
 4KdCeGE2riE8RZzVVkjP1pwaQR0BkYL+hA3Dqz/6NgfxbOG+9fUoXrZp3KAjlLkkEzd16L
 J5sRmCng0LIC9Nyqhp6sZLuegVeDcr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-rVHKUWpwOqOMcrvYtNsxEg-1; Thu, 14 Nov 2019 06:14:32 -0500
X-MC-Unique: rVHKUWpwOqOMcrvYtNsxEg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AC92189DB01;
 Thu, 14 Nov 2019 11:14:31 +0000 (UTC)
Received: from localhost (unknown [10.36.118.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C2225C8A6;
 Thu, 14 Nov 2019 11:14:30 +0000 (UTC)
Date: Thu, 14 Nov 2019 11:14:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: How to extend QEMU's vhost-user tests after implementing
 vhost-user-blk device backend
Message-ID: <20191114111429.GC580024@stefanha-x1.localdomain>
References: <CAJAkqrXyeVn4iy7NzkR__BS9q9xT4ZWcjJszNBaSKH0U57c4hw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJAkqrXyeVn4iy7NzkR__BS9q9xT4ZWcjJszNBaSKH0U57c4hw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 13, 2019 at 05:23:46PM +0800, Coiby Xu wrote:
> I've implemented vhost-user-blk device backend by following
> https://wiki.qemu.org/Google_Summer_of_Code_2019#vhost-user-blk_device_backend.
> But I'm not sure what kind of tests I should write or to extend to
> take advantage of implemented vhost-user-blk device backend. The
> existing two tests related to vhost user are tests/vhost-user-bridge.c
> and tests/vhost-user-test.c both of which act as vhost user server to
> test QEMU's implementation of vhost user client. Am I supposed to
> extend these two tests? Could you elaborate on the final step "Extend
> QEMU's vhost-user tests to take advantage of your vhost-user-blk
> device backend"?

Hi Coiby,
The following tests/virtio-blk-test.c test cases will also work with
vhost-user-blk: basic, indirect, idx, nxvirtq.  The other test cases
may require more work because they send QMP commands like block_resize
or device_add virtio-blk-pci.

In theory block_resize should work because the vhost-user-blk device
backend can send a VIRTIO Configuration Space changed interrupt
(VHOST_USER_SLAVE_CONFIG_CHANGE_MSG), but I haven't checked if this code
path is fully implemented.

In order to reuse existing test cases you could add new initialization
code to virtio-blk-test.c that:
1. Starts the vhost-user-blk device backend
2. Adds a -device vhost-user-blk-pci connected to that device backend

Please post your patches to qemu-devel even if you don't have test cases
yet.  That way you can get review feedback earlier.

Stefan

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3NNxUACgkQnKSrs4Gr
c8gNCQf/U+FWOmRhjc7m9hsYJLLDM0js4A6NqAc3mC2cUVGlHYb/uNOLQLkOMtqO
w4KogEMrv7Lvb0WGWheyIVXQ623JBoKjMqKgLiIArnXeKdVUJr9KX7GA6EQzGNsh
vUqxBs/XrDgodI3mU4TB/4Gh4E5Zoo+VvQPNZTOB30A3loxWiOSGtp28zUQ4Iw4m
41lTB9XO/uK2TXm51Xyys8XiXZcIakLhIpaCGY7zRMDkGVNVd3p6bCkTdXklNNlm
bJiB9Mpb1usdXluDyHTu23TWNdzXdlSZlGe1DgBH5oOb89sGMvhv62CAOPeIgXWK
AUY3SUerhrKtwW8fwYGj85/oJ/36vA==
=qkM/
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--


