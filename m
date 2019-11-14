Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC287C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:57:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5C4206EF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oan/iMYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5C4206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVCom-0002uk-MV
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iVCnr-0001ry-8N
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:56:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iVCnq-00059B-6J
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:56:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34256
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iVCnq-00058X-2f
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573729001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2YtrN/VVOUlWCJkOfiVDQ00QtneK6qOyPaV7+Xw8CZ0=;
 b=Oan/iMYBp9eVkIW5Sp7CMIkR8wEFs3sriihN611RUh35H1ccfzJhC/WdrHg66eUkk4470B
 CUn56vj1AQh/Kf1jwNahcebFygAI7EcXmzSTdCSqVV9oLC2m0HFBufu8FKHUSlJD0QFWtj
 w+20VOe+WV9XMfgQZjcKo07XISolSFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-M1NzSR3GMLKFjMAWA0uFHg-1; Thu, 14 Nov 2019 05:56:40 -0500
X-MC-Unique: M1NzSR3GMLKFjMAWA0uFHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16E31106BBE2;
 Thu, 14 Nov 2019 10:56:39 +0000 (UTC)
Received: from localhost (unknown [10.36.118.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53A04108F81B;
 Thu, 14 Nov 2019 10:56:37 +0000 (UTC)
Date: Thu, 14 Nov 2019 10:56:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Status of "vhost-user-blk device backend" mentioned on QEMU wiki
Message-ID: <20191114105636.GA580024@stefanha-x1.localdomain>
References: <ac9a9332-4089-f4e0-16e8-43bb165d6310@gmail.com>
MIME-Version: 1.0
In-Reply-To: <ac9a9332-4089-f4e0-16e8-43bb165d6310@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
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
Cc: Bharat Singh <bharatlkmlkvm@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2019 at 02:21:44PM +0530, Bharat Singh wrote:
> I wanted to ask about the status (as in, is someone working on it or is it
> completed) of "vhost-user-blk device backend" project mentioned on QEMU
> wiki. If it isn't assigned to anyone, then I'd like to work on it.

https://wiki.qemu.org/Internships/ProjectIdeas/VhostUserBlkDeviceBackend

Kevin: Is this project idea available for someone to work on?
qemu-storage-daemon seems to be at a stage where your or a colleague
would be working on vhost-user-blk support, so maybe this idea is
already taken.

Stefan

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3NMuQACgkQnKSrs4Gr
c8hytgf+K8u5zyytqz9UpNRB/tvSGaHeMu4x/r66qxJiIxTzY2Yo7NSK6Q3pBpGC
wOCdtYbKGZhA9Kr6bHYtw8XTLZ7kE/0nqWVwZ0mVvpi/N8crJWKJCwBj9drjBB0k
K6X/RW70JdePpMYHQi6yExeIW4QnfDLv7MucS+iDe4rRsH1hgGJGvjX/lWeD8u2o
YYTd1wkFVsqjtvAc0+k99cJFWZkBStd7UiaZA+a2GtqmVX3xzZaajLNmnREsUyHr
u0J1L65s8EaOQz5GnjxkRvnHkcl0pNe10mKUn+CHbmntGFVvj/WS9Mt0Bh+6klqg
xh08tpsFqM+fAmrpZ0wU7W5S+p1JFA==
=jEK9
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--


