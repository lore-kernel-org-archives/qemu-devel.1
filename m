Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBACC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BFF420738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 10:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVpRGKa9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BFF420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Xy9-0008DU-AT
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 06:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2XxU-0007nm-3d
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 06:44:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50712
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k2XxS-0000Ux-FZ
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 06:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596451481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zzv3lN4uHLngfyLQRtf3HWNJk+1yk3QdbWSjOw+RNIk=;
 b=VVpRGKa9P7UMJL+BzONG9fP1OvKDZxONwGy0GJzKDqagTA+jf7J2Xup3wTMUhHj1OSnlVg
 qkxu1tZCgRCEpFBnRg/+aKNNZu/SgqR3m3O9AwNLh/mx7GgM4S0n1L7JhhbQCztfsn6oiT
 6fCLorBpkXxWZFXGJ4LG6iTMb2/CFbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-wEKxEki_OHyx6GBMW-P-0w-1; Mon, 03 Aug 2020 06:44:39 -0400
X-MC-Unique: wEKxEki_OHyx6GBMW-P-0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4405110CE780;
 Mon,  3 Aug 2020 10:44:38 +0000 (UTC)
Received: from localhost (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3ACB59;
 Mon,  3 Aug 2020 10:44:34 +0000 (UTC)
Date: Mon, 3 Aug 2020 11:44:32 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v4 2/2] trace: Example of non-tracing recorder use
Message-ID: <20200803104432.GG244853@stefanha-x1.localdomain>
References: <20200723132903.1980743-1-dinechin@redhat.com>
 <20200723132903.1980743-3-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200723132903.1980743-3-dinechin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iAL9S67WQOXgEPD9"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:56:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--iAL9S67WQOXgEPD9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 03:29:03PM +0200, Christophe de Dinechin wrote:
> This patch is a simple example showing how the recorder can be used to
> have one "topic" covering multiple entries. Here, the topic is "lock",
> the idea being to have the latest lock changes for instance in case of
> a crash or hang.
>=20
> Here are a few use cases:
>=20
> * Tracing  lock updates:
>     RECORDER_TRACES=3Dlock qemu
> * Showing lock changes prior to a hang
>     RECORDER_TRACES=3Dlock qemu &
>     # Wait until hang
>     killall -USR2 qemu  # This will trigger a dump
> * Graphic visualization of lock states:
>     RECORDER_TRACES=3D"lock=3Dstate,id" qemu &
>     recorder_scope state
>     # Hit the 't' key to toggle timing display
>     # Hit the 'c' key to dump the screen data as CSV
>     cat recorder_scope_data-1.csv

Dan raised a good point regarding integrating recorder functionality
behind the tracetool interface.

On the other hand, I would like to see where this goes so that we have
enough experience to design the tracetool interface, if necessary.

Therefore I am for merging this as-is and taking action when it's clear
that duplication is taking place.

Stefan

--iAL9S67WQOXgEPD9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8n6pAACgkQnKSrs4Gr
c8jaJwf9EYxgtjaQYu+/ye+2BPctGaLToUjbPjvry/BRyXuTamjefmMZunu67ocZ
kR0K+2Ekh3R3+DTE+rhA5O17pGDFPjRGGlWus1dyBV+tI+vVay9kcT+YgB+xIXLj
TrC9LhzZENVBf527cexdXxC2uDBXukH09+lkOrS0DyAEWNaM4p2iYAlSJsuWLIFq
V1Xd9sxH/I9fAXy59HdVcS2pYu89/Y7geovC78hw9SB5G3Q5cjoS5KKbqHqDGh5y
qJIkLu12mpKlnMeFAWq2OigiKSfO4e83fGG6jMMgS8fevnIwfIXif9Cs14YLT6hr
xyFc3XzjAD/9/PP1ioy7YCisOD5sWg==
=IQAK
-----END PGP SIGNATURE-----

--iAL9S67WQOXgEPD9--


