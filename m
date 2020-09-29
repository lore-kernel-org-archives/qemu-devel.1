Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737AAC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1721207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpDOLjlA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1721207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kND6d-0006s6-3n
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 06:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kND1K-0003Vo-Ms
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kND1J-0007Xu-0G
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:38:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601375883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3hCZFS5e0CHMGCR1cs0FcCqvvpB2dbvwjr2dwAPkAqY=;
 b=fpDOLjlAdym7+YomjORQdp29cHaEv7OJXVVucOB3QCq3TvuDybD7fTlNxg2PO0/9FbU+3r
 78dCG5L5S4bQslxler2abQVonUM4jOteWIc3wWEH5gEBQpfadrk+wcR5JYxO0A+G3EXJLB
 aTwK7hbFe0ksfHT7FJlIv4ne+hvcKnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-1CEPp7b0PGmK93gIolTDyA-1; Tue, 29 Sep 2020 06:37:59 -0400
X-MC-Unique: 1CEPp7b0PGmK93gIolTDyA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBEF51084C81;
 Tue, 29 Sep 2020 10:37:56 +0000 (UTC)
Received: from localhost (ovpn-112-247.ams2.redhat.com [10.36.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A992A5C1BD;
 Tue, 29 Sep 2020 10:37:44 +0000 (UTC)
Date: Tue, 29 Sep 2020 11:37:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH v4] introduce vfio-user protocol specification
Message-ID: <20200929103743.GB181609@stefanha-x1.localdomain>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <1600180157-74760-1-git-send-email-thanos.makatos@nutanix.com>
 <20200924082132.GJ62770@stefanha-x1.localdomain>
 <MW2PR02MB37232E78343B164C2405AC248B350@MW2PR02MB3723.namprd02.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <MW2PR02MB37232E78343B164C2405AC248B350@MW2PR02MB3723.namprd02.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: "benjamin.walker@intel.com" <benjamin.walker@intel.com>,
 "elena.ufimtseva@oracle.com" <elena.ufimtseva@oracle.com>,
 "tomassetti.andrea@gmail.com" <tomassetti.andrea@gmail.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "james.r.harris@intel.com" <james.r.harris@intel.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "yuvalkashtan@gmail.com" <yuvalkashtan@gmail.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "ismael@linux.com" <ismael@linux.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "Kanth.Ghatraju@oracle.com" <Kanth.Ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "xiuchun.lu@intel.com" <xiuchun.lu@intel.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "tina.zhang@intel.com" <tina.zhang@intel.com>,
 "changpeng.liu@intel.com" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2020 at 09:58:37AM +0000, Thanos Makatos wrote:
> > It should be accompanied by a test in tests/. PCI-level testing APIS fo=
r
> > BARs, configuration space, interrupts, etc are available in
> > tests/qtest/libqos/pci.h. The test case needs to include a vfio-user
> > device backend interact with QEMU's vfio-user-pci implementation.
>=20
> We plan to use a libmuser-based backend for testing. This, I suppose, wil=
l
> make libmuser a dependency of QEMU (either as a submodule or as a library=
),
> which for now can be disabled in the default configuration. Is this accep=
table?

If there are no other dependencies and libmuser supports all host
operating systems that QEMU's -device vfio-user supports, then I think
it's a good idea to use libmuser for at least one in-tree test in QEMU.

> > Also please let us know who is working on what so additional people can
> > get involved in areas that need work!
>=20
> Swapnil and I will be working on libmuser and the test in QEMU, John and
> the mp-qemu folks will be working on the patches for implementing
> --device vfio-user-pci.

Great!

John: Will mpqemu use libmuser to implement the remote PCI host
controller?

Stefan

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9zDncACgkQnKSrs4Gr
c8hyXAgAtnUokO8eqsIoKEfuLR3OojY/kB9DNWJZWhvM7pzF0gJy+OeOw5IQuEzv
5aA0mhu9oOU/iIbKClxH9mBIwwW7jGQbJbY596v9n0oa6u5iGFahKjy1OM8w4IE4
M7LGiWvhSW5WHfdk74q6r4ymK+BmQg4vkmNHItEqkoUHuRr5OnbRjAmy84aUXROo
JhhfHkeS6yLLQt3LClsuxk8ZFwTyGhMZth2vfBuJ8zXx/YXeYWHjCWqHVwEYNqZQ
OWuyObWbeKsnbgbJcOPaLkAmPkP0S/PZidOY0mcAKdLmCfR3TXjDBH5+LH1dSG+Q
QOTXCj46qINui8t5wWt1j77Mqn2UoQ==
=If2M
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--


