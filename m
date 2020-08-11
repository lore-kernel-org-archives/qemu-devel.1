Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F441C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8B72083B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 14:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKUeWUN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8B72083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Vj5-00051R-Bk
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 10:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5ViN-0004L2-BN
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:57:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k5ViK-0006iV-39
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 10:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597157838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YkeNvYiiLS8ifcoAJjKC6JHntXP7YC/mj2alLCnzZbg=;
 b=OKUeWUN6EuYoa5fhtS279dGG+k3rCQfVKI01yzELggo8w0gwaXmyj4Dit8H7ilaXF752HI
 fETRGwTjFiwkeQn5MwWr047qyoaGXdzVZdfzHPs38B/zavSbnhysgxPBIx1ukg5jfyf5YD
 f5Xof+C0DWsAn06cF4XwahZS0/Nxv94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-mbqhZ19uOeSa6cd1zOSuBw-1; Tue, 11 Aug 2020 10:57:11 -0400
X-MC-Unique: mbqhZ19uOeSa6cd1zOSuBw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE7CF79EC1;
 Tue, 11 Aug 2020 14:57:08 +0000 (UTC)
Received: from localhost (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A7811A888;
 Tue, 11 Aug 2020 14:56:59 +0000 (UTC)
Date: Tue, 11 Aug 2020 15:56:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v8 00/20] Initial support for multi-process qemu
Message-ID: <20200811145658.GD18223@stefanha-x1.localdomain>
References: <cover.1596217462.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 06:40:20
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have finished reviewing this revision.

Please update the wiki page with the latest status, especially
limitations like no dirty memory logging (used by migration, TCG, VGA),
no MSI interrupts, no PCIe, no IOMMU support, etc.

https://wiki.qemu.org/Features/MultiProcessQEMU

Please name the machine type x-remote and the object -object
x-remote-object. "x-" is the convention for experimental features in
QEMU. It means that the interface is not stable and might change between
releases.

Stefan

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ysboACgkQnKSrs4Gr
c8j+DggAwdFsbVMDtGUDfFU/2BHskUIG6j9hvlP7KARR9nEa+IP7/dG8eiyAld1l
9qfbjDyPtEQtKmHpsjtyjFYCtnGUrsVKYZL4flU/fmig0JRUkHdnaXqQ6lEvvQUK
9Jso5LxxImN1Yh8pIeEvLbYNfI5GvqR/Scbr0P0PLy7pj+6HW0qo9wRnGWXFPbf2
OhcWcndIirgqt/qczB5Il2dRS2o0rICQ9E5YaVbw2MT6mqpegPjLfm3GCp7W9Vrf
AWlayb5cUzgN2OHUewSMhfN/bP4gMezISSkmeIs+HniUTjeRnxj6ZgKxdLc1zoXu
OAq4dLmAgscMn7GNB0u0KDoK8dAzkw==
=FYJI
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--


