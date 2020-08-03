Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EC3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E749720738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGxMoyxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E749720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2X4F-0004tO-Rq
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 05:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2X2W-00031D-IX
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:45:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2X2T-0008JD-Ql
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596447947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kHpAB4B1L0sscSclIwg5TIEo6mZtF2tYOC8x8Zn5DXM=;
 b=EGxMoyxpACNmJK1FlxkTeC7g6DeGzwDk5uLJIm6L91208VBgryF0+U4+kFJt0TosmOYQr5
 AnzCFYkaN11iyTDHQlZIrEd7Fw5PqWVzdtfUbiWGRyjAMlOzOH3rkpEteeDwrr6ubaHz1m
 Yeiy8XDuF9epWaoS6is8UOQvyocxQqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-O1Xo6gj2Ok61DdakfUVJ1g-1; Mon, 03 Aug 2020 05:45:42 -0400
X-MC-Unique: O1Xo6gj2Ok61DdakfUVJ1g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90C6E100945B
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 09:45:41 +0000 (UTC)
Received: from localhost (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3B8D10013C1;
 Mon,  3 Aug 2020 09:45:37 +0000 (UTC)
Date: Mon, 3 Aug 2020 10:45:36 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 0/5] virtiofsd: Add a unprivileged passthrough mode
Message-ID: <20200803094536.GC244853@stefanha-x1.localdomain>
References: <20200730194736.173994-1-vgoyal@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200730194736.173994-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:09:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: berrange@redhat.com, vromanso@redhat.com, dwalsh@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, virtio-fs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2020 at 03:47:31PM -0400, Vivek Goyal wrote:
> Hi,
>=20
> This is V2 of patches. Only change since last version is handling of
> lock/pid file creation as per the comments from Daniel Berrange.
>=20
> I can't think of any more changes needed. As a unpriviliged user
> inside VM I can do simple operations like create/remove/read/write
> files.
>=20
> For more testing, I probably need a testsuite which runs as unpriviliged
> user. pjdfstests needs to run as root and this does not work in this
> setup as creation of files as root fails. (On host, daemon tries to
> switch to root uid and that fails).
>=20
> So as of now, I think these are the minimum changes needed to support
> unprivileged passthrough mode of virtiofsd.

Ideas for testing user file I/O:

  $ git clone https://git.qemu.org/git/qemu.git
  $ find qemu -name \*.c
  $ grep -r vhost_user_fs qemu
  $ rm -rf qemu

  $ pip install --user Django
  $ .local/bin/django-admin

Stefan

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8n3MAACgkQnKSrs4Gr
c8hoIgf/ZTByOdimELMej45C/RGvU3uhcdkojdd51N6vDiVmVRpqUqlIX3hVYHu1
cTfluSOAFrqLnP0708FteI8Lr+aIPx2n+LxGbyHpJkv2KRkZnBaj69Vpg8BAsump
EIRcTdDBr7FeZfeacNtoprJ2Y4WAZTjRKM5wgZRpZGMqI95uzJ72v4xESws+5eVy
wVdYOq0q+w02kcSlMTWVUh730k4uBQINPQpBT1fTmm7Q/me7izRJrsPaVTdtSjCz
5hv/RAnquvbUWO0XZLiwpPkzdbG1UeemaBC6S0QM1AdNzNKFBgBnPnA5Wk5MluVF
/hl01NZyK4teidhtq3uQZk8wyjpAgQ==
=PYhx
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--


