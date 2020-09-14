Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BB6C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:27:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00C32193E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+TBicWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00C32193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrKZ-0007Qj-R9
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHqhU-00087D-T2
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHqhT-0006jH-AZ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600098446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uItXr708QI3jf9ZZTFLlzxBGtQOO6WfIXYpJjbfg6i8=;
 b=O+TBicWQLCpRXslx/dert3JEpADJ2x+Gt/pIufs1K6JNDkDnYb32/G7EUk8/7moVsVp3+q
 remO/jzTNFC1A1RlfnRnfJ0zywKWzIw77b3OKVbNpzlTPzR8sCH5zl+ivUprUjSZ38M32E
 mcxEqO3Yrl4YJjplZzhgDeVtsGy2nZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-Hd678L7uPEOtPdVbpAWmxg-1; Mon, 14 Sep 2020 11:47:22 -0400
X-MC-Unique: Hd678L7uPEOtPdVbpAWmxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE59E104D3F5;
 Mon, 14 Sep 2020 15:47:19 +0000 (UTC)
Received: from localhost (ovpn-114-32.ams2.redhat.com [10.36.114.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 547A968D61;
 Mon, 14 Sep 2020 15:46:49 +0000 (UTC)
Date: Mon, 14 Sep 2020 16:46:48 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v9 03/20] multi-process: setup PCI host bridge for remote
 device
Message-ID: <20200914154648.GB629589@stefanha-x1.localdomain>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
 <20200827181231.22778-4-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20200827181231.22778-4-elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2020 at 11:12:14AM -0700, elena.ufimtseva@oracle.com wrote:
> From: Jagannathan Raman <jag.raman@oracle.com>
>=20
> PCI host bridge is setup for the remote device process. It is
> implemented using remote-pcihost object. It is an extension of the PCI
> host bridge setup by QEMU.
> Remote-pcihost configures a PCI bus which could be used by the remote
> PCI device to latch on to.
>=20
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  MAINTAINERS                  |  8 ++++
>  hw/pci-host/meson.build      |  1 +
>  hw/pci-host/remote.c         | 75 ++++++++++++++++++++++++++++++++++++
>  include/hw/pci-host/remote.h | 30 +++++++++++++++
>  4 files changed, 114 insertions(+)
>  create mode 100644 hw/pci-host/remote.c
>  create mode 100644 include/hw/pci-host/remote.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9fkGgACgkQnKSrs4Gr
c8iJLQf/Z0sMg3/0S0eHNxCvfU+a9sdgjksy2S8YgFYwNScDQLA3tcj0yzpBBIx3
7ZwCR14efH/nfkxaHnSC3Y/rkE18GIYw06KA3RqjZ7bF1Rxn6ArhQWFY1xbi2Ugb
33I/Ei/dWT32AXjsPdHSuAA/TehweR+yWMzN/D9ps7fpOnh3WoVkn5jPQsoLepWz
2XZTyfsyAeHXF4d7Bcsh0jRdqqPtonuXP93MPnCIul5MfbO/wkVDNQ6YRH34cOk9
Oiz5gazmWlJvdF0rYdKcM3GTFSU0P2tlUISRGqu5q6Glrk6t6Zfyz8gRLPz3edhQ
yW7cOe9t0xtqGtooKeYx+xosEoDF0Q==
=zDdA
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--


