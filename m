Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB71C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 09:36:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C62B20811
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 09:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C62B20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50736 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIrrE-0005nV-Ow
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 05:36:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hIrpl-0004g9-IY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hIrgo-00074v-9y
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:26:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hIrgn-00074a-SY
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:26:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03C9187622;
	Tue, 23 Apr 2019 09:26:09 +0000 (UTC)
Received: from localhost (ovpn-117-214.ams2.redhat.com [10.36.117.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EB9B51001E7C;
	Tue, 23 Apr 2019 09:26:04 +0000 (UTC)
Date: Tue, 23 Apr 2019 10:26:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190423092603.GE32465@stefanha-x1.localdomain>
References: <20190422004849.26463-1-richardw.yang@linux.intel.com>
	<20190422004849.26463-3-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline
In-Reply-To: <20190422004849.26463-3-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 23 Apr 2019 09:26:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v14 2/2] docs: Added MAP_SYNC documentation
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pagupta@redhat.com, xiaoguangrong.eric@gmail.com, mst@redhat.com,
	qemu-devel@nongnu.org, yi.z.zhang@linux.intel.com,
	yu.c.zhang@linux.intel.com, imammedo@redhat.com,
	pbonzini@redhat.com, dan.j.williams@intel.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423092603.PRIkqMOU5fKVn27lV2G7uFDYfzVqxv0HA6Dv9sRhBEc@z>


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 08:48:49AM +0800, Wei Yang wrote:
> From: Zhang Yi <yi.z.zhang@linux.intel.com>
>=20
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> ---
>  docs/nvdimm.txt | 22 +++++++++++++++++++---
>  qemu-options.hx |  5 +++++
>  2 files changed, 24 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcvtorAAoJEJykq7OBq3PI2r8H/jT/ST7qNSmTpa42VotxXjCM
c71URkIRAY4bjjiZcqf+IiSZV4/Gqq4Zb9NzSBrPLfLhaNOnp6stDXHWZdB/fR3O
kRvCa9mUX21UsunWiAMoE869u9GX+oRo78JpYdZvvPm/6XkVoJ4QTQf51H9now3M
iieoqSpTldiyxOcnBEQf8bibcMwlQO8zoyY9/LEedvo36GWrDvHFMp+IOZURj4C/
rzPf54X6mbKYG1FJZdW9g/VLrfrx1eUs50P5PhOmXsE2IDf8bYIBCfiF+tuHomKC
pVc+UblnOs7RTIhj48ZnK/dTRimsIJh7YIjffa6ie4QzEEA9xm4LTeZRN7tMW0k=
=UwDf
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--

