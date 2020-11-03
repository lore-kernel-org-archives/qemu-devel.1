Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52379C388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6078206DB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTem5KKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6078206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxqS-0000Wi-UY
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZxVH-0004qu-UX
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:41:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZxVF-0000X7-99
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZjiCBeoPx5hVsOUjoNhw5vQl5KCgy3G8W/PupiZ0LsY=;
 b=GTem5KKDCoHrUcEy54RNWw5XBgo3c2M3xVIhSDC4MHch6LwqEsKlD5339MfxHaeWPJxldC
 zN+qJpqSzCBdp+LcqE0ZFoydXxblZisxuWyIp7IY0xpS8AS/NKYWzt7QdtkTEjCkTegHFJ
 +LYPkkzqLjxKdvg+Tnp4UoyCgBjUgAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-9w4UpIEyPKqT-TsvLT3shA-1; Tue, 03 Nov 2020 09:41:36 -0500
X-MC-Unique: 9w4UpIEyPKqT-TsvLT3shA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4535191E2AD;
 Tue,  3 Nov 2020 14:41:35 +0000 (UTC)
Received: from localhost (ovpn-115-37.ams2.redhat.com [10.36.115.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6E9121E8D;
 Tue,  3 Nov 2020 14:41:31 +0000 (UTC)
Date: Tue, 3 Nov 2020 14:41:30 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Yu, Jin" <jin.yu@intel.com>
Subject: Re: [PATCH] Revert "vhost-blk: set features before setting inflight
 feature"
Message-ID: <20201103144130.GA253848@stefanha-x1.localdomain>
References: <20201102165709.232180-1-stefanha@redhat.com>
 <DM6PR11MB37234EA5646AF3693B66E7C180110@DM6PR11MB3723.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB37234EA5646AF3693B66E7C180110@DM6PR11MB3723.namprd11.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2020 at 05:11:18AM +0000, Yu, Jin wrote:
> 	I have sent a version 2 and it should fix this issue.

Great, thanks! Michael can review and consider it for merge instead of
this patch.

Stefan

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+hbBoACgkQnKSrs4Gr
c8jktQgApn1AYkd0baEVxP7eDwLz3zaBbYfZpFWOcd4Fyk4dBAFcU0OmBugQ+wIY
GwT4KyylAZgucQgPp2lJVPudLfj3OSjxV7kJDxHfEVx5oFrOsW9IsgjjHzvypUjm
JlgTUDL4qF9lTWzD2qQ4Df9zblc77nSXIZo9sCDjPmc/5S5in8LNgZpZMskYT3RF
rYVHcQRrrCHR0y8RpJ8iD78Y65kUYUsZWnRNCObpLWJhV0ub0B6/arGYIbVp3H1i
LhNv+k5KJ/mfl+rpS7PlGQuorjgk9DgABYsyPhE//BMPscAGYHwIYmoVD0xaFUyg
FoEeqfJXMqRAqB+hTLsVewZH0XfDtA==
=wsQl
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--


