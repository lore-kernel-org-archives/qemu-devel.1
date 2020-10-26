Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D470C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25252224A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lxa8Ne1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25252224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5lu-0006tZ-Mn
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX5km-0005bv-PZ
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX5kk-0004v6-Bb
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603731229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w+WvarrL7aXAqkWTtfoAsVr15lmSCbTNkuuzYMTUwz8=;
 b=Lxa8Ne1J5o9QDjPm9HuIavRpWNh+HK8AtXJJ5E2a9jcM70O2yT4QFwxWef2ARWkLWFi35s
 4toYqXb9eyuqAPcW3kcQOCnPcmQwzVi47HE71TZNCWVEKYcFlSSxyjiNrh1x+QgNC08xCC
 koOvk2PzDCJIisluLC1lhydhhQ45/eI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-mUn_LrreOJS2WE8bbn8cBw-1; Mon, 26 Oct 2020 12:53:44 -0400
X-MC-Unique: mUn_LrreOJS2WE8bbn8cBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A4EA809DDC;
 Mon, 26 Oct 2020 16:53:43 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA7695C22E;
 Mon, 26 Oct 2020 16:53:42 +0000 (UTC)
Date: Mon, 26 Oct 2020 16:53:41 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jiahui Cen <cenjiahui@huawei.com>
Subject: Re: [PATCH v3 0/9] block-backend: Introduce I/O hang
Message-ID: <20201026165341.GM52035@stefanha-x1.localdomain>
References: <20201022130303.1092-1-cenjiahui@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20201022130303.1092-1-cenjiahui@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kunpHVz1op/+13PW"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, fangying1@huawei.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--kunpHVz1op/+13PW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2020 at 09:02:54PM +0800, Jiahui Cen wrote:
> A VM in the cloud environment may use a virutal disk as the backend stora=
ge,
> and there are usually filesystems on the virtual block device. When backe=
nd
> storage is temporarily down, any I/O issued to the virtual block device w=
ill
> cause an error. For example, an error occurred in ext4 filesystem would m=
ake
> the filesystem readonly. However a cloud backend storage can be soon reco=
vered.
> For example, an IP-SAN may be down due to network failure and will be onl=
ine
> soon after network is recovered. The error in the filesystem may not be
> recovered unless a device reattach or system restart. So an I/O rehandle =
is
> in need to implement a self-healing mechanism.
>=20
> This patch series propose a feature called I/O hang. It can rehandle AIOs
> with EIO error without sending error back to guest. From guest's perspect=
ive
> of view it is just like an IO is hanging and not returned. Guest can get
> back running smoothly when I/O is recovred with this feature enabled.

Hi,
This feature seems like an extension of the existing -drive
rerror=3D/werror=3D parameters:

  werror=3Daction,rerror=3Daction
      Specify which action to take on write and read errors. Valid
      actions are: "ignore" (ignore the error and try to continue),
      "stop" (pause QEMU), "report" (report the error to the guest),
      "enospc" (pause QEMU only if the host disk is full; report the
      error to the guest otherwise).  The default setting is
      werror=3Denospc and rerror=3Dreport.

That mechanism already has a list of requests to retry and live
migration integration. Using the werror=3D/rerror=3D mechanism would avoid
code duplication between these features. You could add a
werror/rerror=3Dretry error action for this feature.

Does that sound good?

Stefan

--kunpHVz1op/+13PW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+W/xUACgkQnKSrs4Gr
c8hxFgf8CgOCj1dic0ybfLWvtP/Ijm75I7X9ZXBaEg+CiQIF+pwk0726/o7RyYV1
Ri8wAXmENKK8dFnCDZnJLfXVdK4vKhlceSzN7vREh0YGhIYJCSDqXxV8MCgwMepW
9noJRZ9E8HY6/lYHp053K6j1siAPeeIxEubldELgBFrehS5SYwOXv/5hMX+kSrTD
Tl6xuiSnae6L/autdoavqKaMdZol1q89OaEFMFXfsMoU2sQjzmLHIzaI0dT6C6mi
YJK2pPQQkiiQ8YwGO1F8zl6GEp9j2wFSbVtIJJmgTxnVuNducfdmUYu2nZMehos2
EEpCD/8HJ1QkFSlZ8BqhSGGIkuLnGg==
=KoV9
-----END PGP SIGNATURE-----

--kunpHVz1op/+13PW--


