Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C87DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 12:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5162078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 12:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpBRLrSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5162078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6CBl-0007E7-4w
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 08:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k6CB5-0006cp-Qn
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 08:17:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42722
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k6CB4-0002TI-A7
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 08:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597321069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DnbtrnFl35hLAfcQH1sSiHleh7rcpckqO2IPgfwNpVc=;
 b=KpBRLrSSCS+QKbeNWBNuNLDUYvdEssFj7Uyr8Ds6WbJBvHhjHGo5nf2bVKJV74p1Npo+un
 Gf8I/FFwBsUkmc2rAA72KMjrR3yKHnS8OpyEarSAcaCwLsu4NrJBvOHRCydkBHYDMCNHzL
 wg+wcj0x04ATPlswjlQR5ZHy5FfINZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-2lM74kmQMFWUrl-WB6_dkQ-1; Thu, 13 Aug 2020 08:17:44 -0400
X-MC-Unique: 2lM74kmQMFWUrl-WB6_dkQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E99D1854FC2;
 Thu, 13 Aug 2020 12:17:42 +0000 (UTC)
Received: from localhost (ovpn-114-3.ams2.redhat.com [10.36.114.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1515A600C5;
 Thu, 13 Aug 2020 12:17:24 +0000 (UTC)
Date: Thu, 13 Aug 2020 13:17:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 0/9] Tracing patches
Message-ID: <20200813121723.GB6559@stefanha-x1.localdomain>
References: <20200813052257.226142-1-stefanha@redhat.com>
 <159731563394.15736.4645467986235495124@66eaa9a8a123>
MIME-Version: 1.0
In-Reply-To: <159731563394.15736.4645467986235495124@66eaa9a8a123>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:03:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, lizhijian@cn.fujitsu.com, mst@redhat.com,
 jasowang@redhat.com, Alistair.Francis@wdc.com, kraxel@redhat.com,
 sagark@eecs.berkeley.edu, qemu-block@nongnu.org, quintela@redhat.com,
 david@redhat.com, aleksandar.qemu.devel@gmail.com, marcandre.lureau@redhat.com,
 aleksandar.rikalo@syrmia.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, kwolf@redhat.com,
 qemu-riscv@nongnu.org, kbastian@mail.uni-paderborn.de, mreitz@redhat.com,
 chen.zhang@intel.com, palmer@dabbelt.com, pbonzini@redhat.com,
 aurelien@aurel32.net, stefanb@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 13, 2020 at 03:47:16AM -0700, no-reply@patchew.org wrote:
>   TEST    check-unit: tests/test-char
> Unexpected error in object_property_try_add() at /tmp/qemu-test/src/qom/object.c:1181:
> attempt to add duplicate property 'serial-id' to object (type 'container')
> ERROR test-char - too few tests run (expected 38, got 9)

Pre-existing issue. This error is also affecting other patch series.

Stefan

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl81L1MACgkQnKSrs4Gr
c8hf0wf/ZZYPwVleiFbu0kpZbbmwOBYPaD1wlZULiBai+ZhqVhyG/b0jt1PJ6NTi
mmUOFkf3PQxPRPFRG01JP7oJ9jFAXHjdf4R3L2IuECAQMYM9Q7akfSpYfGh8Fg8m
HlhsbTxWHrR4nfvh6jhyniP5ufO2l//p4pk+kqun4S10/ZMVZwJe7pZ68CCf3aTJ
+8wzf1aHNCrjFHnR7fHBJJHMDU/ESTWnpDrufbOtbK/ecCEHRUj89fDxQUdkSXHd
G7/ochGHD3+nSsj4kcLmPXs+GEGtVT233b7ZgJlQlwrt/4KkPPuOnhmp/eW8Jdts
f3y0Nez94ypqiYlyIYTn7EnNlnyR+Q==
=AGIO
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--


