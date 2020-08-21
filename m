Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D46C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:19:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6346420724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 12:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUth1Znj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6346420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k961S-00022J-Fo
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 08:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k960j-0001Zp-MP
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:19:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51074
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k960g-0007o6-S2
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 08:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598012345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a8uoi7z5+VWASoHvRKRBrbTVEnh6LwLM+HyYys1fVds=;
 b=WUth1Znj7xKnZS9uJp5dh3MPCk6F16eqpFrtc35POU/GowkbN9r6aPd/VKFmWPKfRJgy2l
 Mzbp5n8o9g/8RJJvvj9BE+CD3HCUKrLtCtw6RLOoaxRPt+z4Y9OqwhgNZbH2YmY96rgAj+
 bSOrP5UTJMJTff4QxcjLT6NjZRtnxtI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-gsIshrD_NmugzovYfD2zUA-1; Fri, 21 Aug 2020 08:18:59 -0400
X-MC-Unique: gsIshrD_NmugzovYfD2zUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D168640CB;
 Fri, 21 Aug 2020 12:18:58 +0000 (UTC)
Received: from localhost (ovpn-114-118.ams2.redhat.com [10.36.114.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EEDC756E0;
 Fri, 21 Aug 2020 12:18:54 +0000 (UTC)
Date: Fri, 21 Aug 2020 13:18:53 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 0/3] nvdimm: read-only file support
Message-ID: <20200821121853.GE205318@stefanha-x1.localdomain>
References: <20200804101244.1283503-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200804101244.1283503-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Julio Montes <julio.montes@intel.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 04, 2020 at 11:12:41AM +0100, Stefan Hajnoczi wrote:
> There is currently no way to back an NVDIMM with a read-only file so it c=
an be
> safely shared between untrusted guests.
>=20
> Introduce an -object memory-backend-file,readonly=3Don|off option.
>=20
> Julio Montes sent an earlier patch here:
> https://patchew.org/QEMU/20190708211936.8037-1-julio.montes@intel.com/
>=20
> Eric Ernst requested this feature again for Kata Containers so I gave it =
a try.
>=20
> Stefan Hajnoczi (3):
>   memory: add readonly support to memory_region_init_ram_from_file()
>   hostmem-file: add readonly=3Don|off option
>   nvdimm: honor -object memory-backend-file,readonly=3Don option
>=20
>  docs/nvdimm.txt           |  8 +++++++-
>  include/exec/memory.h     |  2 ++
>  include/exec/ram_addr.h   |  5 +++--
>  include/qemu/mmap-alloc.h |  2 ++
>  backends/hostmem-file.c   | 26 +++++++++++++++++++++++++-
>  exec.c                    | 18 +++++++++++-------
>  hw/mem/nvdimm.c           |  4 ++++
>  softmmu/memory.c          |  7 +++++--
>  util/mmap-alloc.c         | 10 ++++++----
>  util/oslib-posix.c        |  2 +-
>  qemu-options.hx           |  5 ++++-
>  11 files changed, 70 insertions(+), 19 deletions(-)

Ping

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8/u60ACgkQnKSrs4Gr
c8iMVAf/bdblugX3cZF0eD3lhYVJEf79yh9cetkC/w/zqMuM0G12sb3RJ9XYSTRo
qHn10p7xZksLzI4lurbjUfsZxj2CqIbtp0sYZjribx7WpY4GObewMZ2QvpAg5WFg
7e8LiAgSckB9gA4TIw7H0R8TVs3xnWFbPnMAkvyXnJfeIE2sHX88Y0Du9lX9ysEo
YzdynlrlSgqh7CE6G3pt/EESAVb5Cjcq2NGn7kgeU5NBAk8PaWCqu39PRBkLufnM
DAfR4vqTaW0qW1KQv5LguJ27q3yhelDJ9eMJr0oyAMGL5uLY10tVMI/BTIhGDXxi
BqtrgbfmsdyQfJJeYQC5ngulSHvRyA==
=H9jo
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--


