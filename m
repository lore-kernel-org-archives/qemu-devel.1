Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93164C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13EDA20786
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5Vfp644"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13EDA20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdG8-0005Nl-6m
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:04:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZdCX-0002XC-PR
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:01:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZdCS-0005E3-2X
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604336454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tEkXw2KdJmmMoFG/kfB1HfUTSyvlMvf7yM5w/2Eiy4c=;
 b=a5Vfp644u45c3fzAsNRX9ycAa38EiKfAhH574CaGf4WqG4frYw5qYZ/0wNYVQ2lJiiGjDm
 vqEh43jqftuxuBPXW7mS6eRv9NE0zjmmCTkM/Gqatcl7+3AxSlLa7Lvb9f1q0DT/WkLLE+
 hMZTPiP4Sj/S1jgPhmi/dkvSPM0ZdBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-Rgl1kx-1MD6ngEWGjyu1hg-1; Mon, 02 Nov 2020 12:00:36 -0500
X-MC-Unique: Rgl1kx-1MD6ngEWGjyu1hg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8D0E1007B1F;
 Mon,  2 Nov 2020 17:00:34 +0000 (UTC)
Received: from localhost (ovpn-114-65.ams2.redhat.com [10.36.114.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59AF355772;
 Mon,  2 Nov 2020 17:00:34 +0000 (UTC)
Date: Mon, 2 Nov 2020 17:00:33 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 00/12] block/export: vhost-user-blk server cleanups and
 tests
Message-ID: <20201102170033.GA232286@stefanha-x1.localdomain>
References: <20201027173528.213464-1-stefanha@redhat.com>
 <20201030084155-mutt-send-email-mst@kernel.org>
 <20201102054252-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20201102054252-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Jin Yu <jin.yu@intel.com>, qemu-devel@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 05:43:19AM -0500, Michael S. Tsirkin wrote:
> On Fri, Oct 30, 2020 at 08:42:22AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Oct 27, 2020 at 05:35:16PM +0000, Stefan Hajnoczi wrote:
> > > This patch series solves some issues with the new vhost-user-blk-serv=
er and
> > > adds the qtest test case. The test case was not included in the pull =
request
> > > that introduced the vhost-user-blk server because of reliability issu=
es that
> > > are fixed in this patch series.
> >=20
> >=20
> > Fails make check for me:
> >=20
> > Running test qtest-i386/qos-test
> > Broken pipe
> > ../qemu/tests/qtest/libqtest.c:161: kill_qemu() detected QEMU death fro=
m signal 11 (Segmentation fault) (core dumped)
> > ERROR qtest-i386/qos-test - too few tests run (expected 92, got 65)
> > make: *** [Makefile.mtest:1857: run-test-230] Error 1
>=20
> And here's the coredump:

Thanks! qemu.git/master is broken. The segfault was introduced in
adb29c027341ba095a3ef4beef6aaef86d3a520e ("vhost-blk: set features
before setting inflight feature"). The code in question has no test
coverage so we didn't know that vhost-user-blk is broken in QEMU.

I have sent a patch to revert the commit. Let's do that for QEMU 5.2
unless a straightforward fix can be provided in place of the revert.

Stefan

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+gOzAACgkQnKSrs4Gr
c8gQvwgAmH8Oe6I1x6CpX9GQqyFc6EDIjtcV6NJklndsYLz3jgNgF7xsolgQR3pq
m6sJb+Jbmw+4EXmxc8p6Ay2UTpXMRkr02OyckcurUoA0O9rqtMmpZMvZdyCN/hcH
KsNJHcPUBb75hIFlaEiVwguuyqIX/X/rPDm9SQg3XadRxOiVcZtNNKFm5UifnuWz
KOcWlFmxJ4giGVJmzVpdsuj6kCA0sR1NSHki3l6S5uDQi5Raxtq6BdQjZamDn3PV
Jmp1480Am+tQboy6I1g3U2IyJBT722uYKGXO9RUWpeog2e+SXzmIjtjImUYsGbOI
F5bYSchg9moLoE2b0EV/zFweBa15eA==
=oIJV
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--


