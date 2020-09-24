Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5EAC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5292221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDXBjSHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5292221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLMWw-00067s-KN
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 04:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLMVl-0005MN-FN
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLMVh-0006R6-Eh
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:21:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600935707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hrqeDHOowpuGx13cQBSQYQTyFo/pfO/cs4zcegKqf2k=;
 b=hDXBjSHU9xTN2c1DuoKORa6EzbhMYPEeSmfGXH6beQ8iY/Qlxath4uN0CIrd4da6KI1Yl0
 hcMfpFYYz2Z3acdYmHjB2DuRHdwm5L4docU4SlEVlfhACuHRs2frUiHXR7rWeRhmwTPC5s
 tfjtKmP5D3Q6tHwI6/09eNqX8AErfNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-qJ-2EUxqPtWUIxZ4nnmkiA-1; Thu, 24 Sep 2020 04:21:45 -0400
X-MC-Unique: qJ-2EUxqPtWUIxZ4nnmkiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7148F393B1;
 Thu, 24 Sep 2020 08:21:43 +0000 (UTC)
Received: from localhost (ovpn-114-133.ams2.redhat.com [10.36.114.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD79473662;
 Thu, 24 Sep 2020 08:21:33 +0000 (UTC)
Date: Thu, 24 Sep 2020 09:21:32 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH v4] introduce vfio-user protocol specification
Message-ID: <20200924082132.GJ62770@stefanha-x1.localdomain>
References: <1594984851-59327-1-git-send-email-thanos.makatos@nutanix.com>
 <1600180157-74760-1-git-send-email-thanos.makatos@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <1600180157-74760-1-git-send-email-thanos.makatos@nutanix.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pWOmaDnDlrCGjNh4"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: benjamin.walker@intel.com, elena.ufimtseva@oracle.com,
 tomassetti.andrea@gmail.com, John G Johnson <john.g.johnson@oracle.com>,
 jag.raman@oracle.com, james.r.harris@intel.com, swapnil.ingle@nutanix.com,
 "Michael S. Tsirkin" <mst@redhat.com>, yuvalkashtan@gmail.com,
 konrad.wilk@oracle.com, qemu-devel@nongnu.org, raphael.norwitz@nutanix.com,
 ismael@linux.com, alex.williamson@redhat.com, Kanth.Ghatraju@oracle.com,
 felipe@nutanix.com, xiuchun.lu@intel.com, marcandre.lureau@redhat.com,
 tina.zhang@intel.com, changpeng.liu@intel.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pWOmaDnDlrCGjNh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 07:29:17AM -0700, Thanos Makatos wrote:
> This patch introduces the vfio-user protocol specification (formerly
> known as VFIO-over-socket), which is designed to allow devices to be
> emulated outside QEMU, in a separate process. vfio-user reuses the
> existing VFIO defines, structs and concepts.
>=20
> It has been earlier discussed as an RFC in:
> "RFC: use VFIO over a UNIX domain socket to implement device offloading"
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>

The approach looks promising. It's hard to know what changes will be
required when this is implemented, so let's not worry about getting
every detail of the spec right.

Now that there is a spec to start from, the next step is patches
implementing --device vfio-user-pci,chardev=3D<chardev> in
hw/vfio-user/pci.c (mirroring hw/vfio/).

It should be accompanied by a test in tests/. PCI-level testing APIS for
BARs, configuration space, interrupts, etc are available in
tests/qtest/libqos/pci.h. The test case needs to include a vfio-user
device backend interact with QEMU's vfio-user-pci implementation.

I think this spec can be merged in docs/devel/ now and marked as
"subject to change (not a stable public interface)".

After the details have been proven and any necessary changes have been
made the spec can be promoted to docs/interop/ as a stable public
interface. This gives the freedom to make changes discovered when
figuring out issues like disconnect/reconnect, live migration, etc that
can be hard to get right without a working implementation.

Does this approach sound good?

Also please let us know who is working on what so additional people can
get involved in areas that need work!

Stefan

--pWOmaDnDlrCGjNh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9sVwwACgkQnKSrs4Gr
c8iRzQf/UiksrzObxIAH0oZwXPL0bqu76th6AgnH+eLxBLG5OKe8U+YYVCoSO8iU
VYiCkROkGg8bDIyZ9ZpZ7tKwSkclaTeT03IgdHgnMiQhoYFnwANU/ePFaD6aPnJM
vMf1RDs7HtOwrwnrXAKNM0HgazRiHam370ZaAGJg/ABfnxbKXLn9RfIZpILCFxoM
flvYD5iV7WpZ0sqqjol9m+S1jWnwp57KRAUhZEImVVhuwIikSc3DGKqL4VZn3kP2
+e2qxG63Txg6SO8A+POkR5juXm7aZbI5+5TlXcuUFY/pdn31ZCWk/uJKO20a5QvM
B3aKno/IkRVoqqE1bVd1o7p+YSv/sA==
=eHHE
-----END PGP SIGNATURE-----

--pWOmaDnDlrCGjNh4--


