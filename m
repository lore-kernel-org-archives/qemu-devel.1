Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA91BCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:14:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CC92064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VF5iUgui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CC92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJH7-0007g4-7r
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iNIV2-0002YZ-IO
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iNIV1-0001RC-Fc
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:24:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43650
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iNIV1-0001Qb-BJ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571844274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GkE+hDlB5fFKLn+2E0jRJ3qxFPV0UL3vNbXeQOwxfpk=;
 b=VF5iUgui6cofgC16pk3bzVH5VNhklE/W7pdbBj011EbqI0ysOeJk/lXQ+EoVbQzZzhoYcR
 iHtVLEWnGHgSEBpbhdf6iMtfFICj2u+nvHfxsAdQE7UNEeehZl0DgideoLOsCPMxmVi2tl
 LOMxbBydwaleJXdET40j1DzgZDKzDwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-cqJ1O4tgOSaouQeKXqJRhw-1; Wed, 23 Oct 2019 11:24:29 -0400
X-MC-Unique: cqJ1O4tgOSaouQeKXqJRhw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B6A8107AD40;
 Wed, 23 Oct 2019 15:19:13 +0000 (UTC)
Received: from localhost (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 793D160166;
 Wed, 23 Oct 2019 15:19:04 +0000 (UTC)
Date: Wed, 23 Oct 2019 16:19:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "yezhenyu (A)" <yezhenyu2@huawei.com>
Subject: Re: [RFC PATCH] iothread: add set_iothread_poll_* commands
Message-ID: <20191023151903.GI9574@stefanha-x1.localdomain>
References: <5DAEB9D3.3080503@huawei.com>
MIME-Version: 1.0
In-Reply-To: <5DAEB9D3.3080503@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kH8JNVvasRCCW1Oz"
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
Cc: dgilbert@redhat.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org,
 jiangyiwen <jiangyiwen@huawei.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--kH8JNVvasRCCW1Oz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2019 at 04:12:03PM +0800, yezhenyu (A) wrote:
> Since qemu2.9, QEMU added three AioContext poll parameters to struct
> IOThread: poll_max_ns, poll_grow and poll_shrink. These properties are
> used to control iothread polling time.
>=20
> However, there isn't properly hmp commands to adjust them when the VM is
> alive. It's useful to adjust them online when observing the impact of
> different property value on performance.
>=20
> This patch add three hmp commands to adjust iothread poll-* properties
> for special iothread:
>=20
> set_iothread_poll_max_ns: set the maximum polling time in ns;
> set_iothread_poll_grow: set how many ns will be added to polling time;
> set_iothread_poll_shrink: set how many ns will be removed from polling
> time.
>=20
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
> hmp-commands.hx | 42 ++++++++++++++++++++
> hmp.c | 30 +++++++++++++++
> hmp.h | 3 ++
> include/sysemu/iothread.h | 6 +++
> iothread.c | 80 +++++++++++++++++++++++++++++++++++++++
> qapi/misc.json | 23 +++++++++++
> 6 files changed, 184 insertions(+)

poll-max-ns, poll-grow, poll-shrink are properties of IOThread objects.
They can already be modified at runtime using:

  $ qemu -object iothread,id=3Diothread1
  (qemu) qom-set /objects/iothread1 poll-max-ns 100000

I think there is no need for a patch.

Stefan

--kH8JNVvasRCCW1Oz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2wb2cACgkQnKSrs4Gr
c8j+TQf9GOdblXMO8mK7BVUu9vQ1TQkWGGGDAwJNU/cWmFglAOf3cnV7pZupKrcO
9Mx8hVe7guURupVflHNPWu8YTKDbFUabETz01dOiTgAvZ9RL4GRDBd2Eg8T/a7UY
Xa5hsR9ppepmLu2xjh0B0Ua6Sh832dJQTfNOxFkZTtqzLTpYfLpRSNsB+me8UiS/
v2Kq4utPgwETRnFEawivN9aLDyiB9cRtNCoVan7hXXgcazmoJXREsokxC2vmVrt+
s7JbXCsZMBSyj/y+mgY3SBybVl/GlJRbyoeLpo8sqRmNtQ6FLUArlpzXOheg1TyP
fSFwsPoLIGYfN7oV6IDg4k37FsF8QQ==
=9778
-----END PGP SIGNATURE-----

--kH8JNVvasRCCW1Oz--


