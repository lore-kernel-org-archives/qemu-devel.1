Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79406C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A47206E3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVt4Yltw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A47206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKvd-0002Wz-6l
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kOKty-0001aE-Nh
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:15:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kOKtt-0002xJ-7p
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601644504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=7Q2+Dg7abeldWpVMdz/K+uE/ec+umHQILXtvkjCFi5Y=;
 b=UVt4YltwI81LMo0hTqMI0crxLYQ5/PaGy9/RgCK8+ukR00YPlm8xO3u5KX/GhtFpFLoqTZ
 g/MZ7GSvkHXOX033inXJSqYOBlMFBSTVaIYIeoE9mxScV5SALKrlGKsl2tWvUqLpklYevw
 UUuT3dqmlek/qAluU7OIyZGaws+yD/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-AnxVtaU1O_yKgd6zhsBwNQ-1; Fri, 02 Oct 2020 09:14:58 -0400
X-MC-Unique: AnxVtaU1O_yKgd6zhsBwNQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04C681021215;
 Fri,  2 Oct 2020 13:14:56 +0000 (UTC)
Received: from localhost (ovpn-114-195.ams2.redhat.com [10.36.114.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BBC379981;
 Fri,  2 Oct 2020 13:14:55 +0000 (UTC)
Date: Fri, 2 Oct 2020 14:14:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Call for KVM Forum panel discussion topics
Message-ID: <20201002131454.GB574544@stefanha-x1.localdomain>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
You can post questions for the KVM Forum panel discussion until October
13th:
https://etherpad.opendev.org/p/KVMForum_2020_Panel

The panel is a yearly session at KVM Forum for discussing technical and
non-technical topics related to KVM, QEMU, and open source
virtualization in general. The panelists are developers, managers,
researchers, and others involved in open source virtualization.

Questions and topics come from the community, so please participate!

The panelists this year are:
 * Susie Li - Software Engineering Director, Intel
 * Hubertus Franke - Distinguished Research Staff Member, IBM
 * David Kaplan - Fellow, AMD
 * Peter Maydell - Principal Software Engineer, ARM
 * Richard W.M. Jones - Senior Principal Software Engineer, Red Hat

The panel session is on Wednesday, October 28th at KVM Forum 2020:
https://sched.co/eE2D

Last year's session is available for watching here:
https://www.youtube.com/watch?v=8lmiZeh-xC0

Stefan

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl93J84ACgkQnKSrs4Gr
c8iCaAf9GnfOnphKYUzFCJewaJfQm8IRTWlC27e78ilSZxbQPylTK3yRvekVcHFb
zQGy3/AnPcfjrYFMDpzY/T2ko7kp8tFiP+e1Kk8LzlaUlGuK5Y8rUp/Ws6LNNgM1
l75cSEAi+JmbqCJjDPMQC1sObbHugDFpshSC+y2xQByYXXpbMKuZSB7I4YCkeJ61
j5SmkFED821KHyVbjIXlTNDgTPXfw7g2RHcKXeNZHPhUtYrorsxMLbGJZArzcEgs
R+LnU05zCr6CkjOFfBozT/iozww5OKXIDep/gJ3fFY7+3g0I1Vv78v5ysxIOpa0V
5P1EFljNL8NJ/Har3Z2IxuAyg1qiiA==
=R6LZ
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--


