Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071B9C3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:26:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2EFA20659
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/YZ3fUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2EFA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3RRC-0007jV-0c
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 16:26:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j3RQW-0007IA-O6
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j3RQV-0008JB-OA
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:26:08 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30792
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j3RQV-0008IU-Jd
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581888367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5XNWbUgUF5B3GOhbplshEs7PIYKogx71GNwuO8r1vM0=;
 b=E/YZ3fUXCgyyXEQcWpbSG3yS9NrxNrvt5WvalI9oWNkQY3fG3CIcxTBil+9sX8gUaiQv8R
 Jg3xuQleA4rmNU5gEScqk1cNZfd9riEGLjt3ZmhZqHzhKUJCyh//gInpD+Vk2ACqdo1kEd
 s5XpmRsNtrBN1JUXewdPfEOdJCQNnIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-ECMmS7DHO5Ob13wjvbPs8w-1; Sun, 16 Feb 2020 16:26:04 -0500
X-MC-Unique: ECMmS7DHO5Ob13wjvbPs8w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBC99800D4E
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2020 21:26:03 +0000 (UTC)
Received: from lpt (ovpn-200-18.brq.redhat.com [10.40.200.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E78B8574E;
 Sun, 16 Feb 2020 21:25:56 +0000 (UTC)
Date: Sun, 16 Feb 2020 22:25:52 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 3/3] tools/virtiofsd/fuse_lowlevel: Fix
 fuse_out_header.error value
Message-ID: <20200216212552.GD745061@lpt>
References: <20200215160716.1262-1-philmd@redhat.com>
 <20200215160716.1262-4-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200215160716.1262-4-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2020 at 05:07:16PM +0100, Philippe Mathieu-Daud=E9 wrote:
>Fix warning reported by Clang static code analyzer:
>
>    CC      tools/virtiofsd/fuse_lowlevel.o
>  tools/virtiofsd/fuse_lowlevel.c:195:9: warning: Value stored to 'error' =
is never read
>          error =3D -ERANGE;
>          ^       ~~~~~~~
>
>Fixes: 2de121f01e
>Reported-by: Clang Static Analyzer
>Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>---
>RFC because untested
>---
> tools/virtiofsd/fuse_lowlevel.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5Js2AACgkQ+YPwO/Ma
t51VGgf9E3Lrf2lJMScclsQrZQQdJPxT9CSSk0XvXDcVXdNhKwxsurAeaYGbkdyY
8/ENGudlcZDpS1yWj3D93tSitMCF8awrALHSW/Tr53V1LPIxy3bkcdRofJZmbkHV
WiAKUU71/YB96/1jiQ2HlmLPdVg15cgI/aPcCytLS5CTvf9fHZSu4AENzM/QjcRE
wrJnFIOE/j+lj5KEULWN2gGx/HtcXADG3c6zjz/ADd8uWPWR30P/frOLIEWuADIN
N7U2/aiwIA+P+maH+PUusMSUZ8CHGkMRfvz0SnFNpmnrEQNJzCBqXCSbR/bvsjlD
cgxfxPPF1RQ2MwoNxJrAVcj9ox3pZw==
=85sg
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--


