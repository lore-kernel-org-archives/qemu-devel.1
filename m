Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8C8C63699
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB2A208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 13:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJm8bb8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB2A208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVxaV-0006le-GB
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 09:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVxZZ-0005uC-7W
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 09:57:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVxZX-00060T-Hr
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 09:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603461454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c1oPkyWVl1LvY1s+IdUH6WjkliYvzVfQgIy4/RkUxKA=;
 b=IJm8bb8OkuWxutQZRzDkymEqJdvubD3mgkleO4cGiUedjKhMGjEWstFsJCT5GNGRb81hlQ
 /vpqL9aihdbfscygowZbKRm8N8Rksr7r/YDBUV7UIedMz4NjUAbEyF6I8xpva1VH36aMo9
 DUFOpU04Co9saiDl0jKSzMRwGYk4oJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-laW3cVRTPVewd_Ff0NJdNQ-1; Fri, 23 Oct 2020 09:57:30 -0400
X-MC-Unique: laW3cVRTPVewd_Ff0NJdNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1AC91882FAB;
 Fri, 23 Oct 2020 13:57:28 +0000 (UTC)
Received: from localhost (ovpn-114-178.ams2.redhat.com [10.36.114.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36CA055776;
 Fri, 23 Oct 2020 13:57:28 +0000 (UTC)
Date: Fri, 23 Oct 2020 14:57:27 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v11 00/19] Initial support for multi-process Qemu
Message-ID: <20201023135727.GG812157@stefanha-x1.localdomain>
References: <cover.1602784930.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IuhbYIxU28t+Kd57"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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

--IuhbYIxU28t+Kd57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2020 at 02:04:53PM -0400, Jagannathan Raman wrote:
> Hello,
>=20
> This is the v11 of the patchset. Thank you very much for the
> review of the v10 of the series. We are glad to hear the
> patchset is getting in a better shape.
>=20
> We made changes to the following patches in this series.
>=20
> [PATCH v10 06/19] multi-process: define MPQemuMsg format and transmission=
 functions
> [PATCH v10 08/19] multi-process: Associate fd of a PCIDevice with its obj=
ect
> [PATCH v10 10/19] multi-process: introduce proxy object

I have reviewed these patches and posted a comment about a possible
buffer overflow.

Stefan

--IuhbYIxU28t+Kd57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+S4UYACgkQnKSrs4Gr
c8jViQf/dJX38ZZXXqu11usftjaFjKpsTV9eERnkGU00bqoxy+u/3IHT//nIONY2
NivdL7jG/ScP6J9d1DVep0zremFSuGgTlZ/JJdilPx8lSQAJ1jyzpmH7wb3/vo6s
B2J6B+VfxoANQrjBcfsVNJMdtNhJOfWKIOc7ihWTREPmr6959bTCeJnPkl6QfJsg
4fA5EnS04HaER8aIa3uRgxnUC8fE+h9Rc3Pbby6kzdt1INFt0wKj30HZ8SpFmcFn
W7GpJcM1G95euDlPSe4O2YgGXL8Lsge/9T1wiHaaQJMHuYQ9JDnYJEBxjWVU6G16
wmrNG63Ryd4hydg2fVduWbPKOqyI5Q==
=eMXE
-----END PGP SIGNATURE-----

--IuhbYIxU28t+Kd57--


