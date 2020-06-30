Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0685AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4952085B
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPHiLDxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4952085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFqr-0005KH-UT
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqFq3-0004WI-BG
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:58:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56901
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqFq0-00088b-UL
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593521892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OE/wS0p1IZK6WUHNkZzoCVazzqmnS/Z9LYKNzt+JLWU=;
 b=JPHiLDxLpQ3AoaGucdE0znn4ChvFj1zck191VuoZxOsT0fgmo1YhM363Tw+c8oUaml81BA
 VZ38b29QNgp9je53Z6qvgFMFLRCdhpckBeitgNt4BVyyHaTtgaf3ztdfzljpFveNF9LBCX
 pjUNrnwl7uBu4AqCDX2Uy5+7ByceXZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-4yLXwrNpPBWZ-TI3uekJCg-1; Tue, 30 Jun 2020 08:58:09 -0400
X-MC-Unique: 4yLXwrNpPBWZ-TI3uekJCg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D800618B9FC4;
 Tue, 30 Jun 2020 12:58:08 +0000 (UTC)
Received: from localhost (ovpn-115-106.ams2.redhat.com [10.36.115.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C89310013C1;
 Tue, 30 Jun 2020 12:58:05 +0000 (UTC)
Date: Tue, 30 Jun 2020 13:58:04 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v2 3/3] trace: Example of "centralized" recorder tracing
Message-ID: <20200630125804.GF91444@stefanha-x1.localdomain>
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-4-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200626162706.3304357-4-dinechin@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GV0iVqYguTV4Q9ER"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--GV0iVqYguTV4Q9ER
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 06:27:06PM +0200, Christophe de Dinechin wrote:
> This is an example showing how the recorder can be used to have one
> "topic" covering multiple entries. Here, the topic is "lock".
>=20
> Here are a few use cases:
>=20
> - Checking locks:
>     RECORDER_TRACES=3Dlock qemu
> - Graphic visualization of locks:
>     RECORDER_TRACES=3D"lock=3Dstate,id" qemu &
>     recorder_scope state
>     <Hit the 't' key to toggle timing display>
>     <Hit the 'c' key to dump the screen data as CSV>
>     cat recorder_scope_data-1.csv
>=20
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  util/qemu-thread-common.h | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GV0iVqYguTV4Q9ER
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl77NtwACgkQnKSrs4Gr
c8jHZgf/aJv+TLGvdO69Kt7Lky52o/ntZaRRk8St/amzoTzCPHBpYRTqLNBCDFL3
eR6Dad6+Ig1+jckhCbj9Mfc1dpkbgPjQeatZp9AEUe/6YIwXiMvqRVasK3B0HKSI
RO/hNREmz82kWrdxWGHCAPsUOterIl7nCBNuqv8UcVOY9Q02bmu0QNXVM5IEiQx+
J2y+WxNqbA4nswmqwX+l/B72jOHKd6OPfC4FebcQryBnJq1D4cGGUWxkUPxBVNZ1
qFWGkebY7S2CFsJkCk7NaEJrYTz8hncR/M0KNYmesJd56JD7vNIy28/Zl8OoiRZP
7pQOBGX+zN7S5ox0CshZWoBRMksWBg==
=fLLu
-----END PGP SIGNATURE-----

--GV0iVqYguTV4Q9ER--


