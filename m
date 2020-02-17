Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5072C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B60206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 11:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g40sJVcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B60206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3eo3-0005Ky-Oo
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 06:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j3enR-0004ve-Qs
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j3enQ-00087X-VH
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:42:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58833
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j3enQ-00086m-QY
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 06:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581939759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fipMpkfwmp7cWe//1u9zKEqF9XCcQfGU2iOHPWJtDE4=;
 b=g40sJVcGrJ+V022YLHxJTQCddc6OPd6ALqz5pI7brQy+9Uoh8Olv+x/PEMBD8DfDvZz+oo
 44g4prMWxPD8q9WxFUjr3YWmj+wg3IEqHr9riFGaKUnj+xmO9D1hf1rtixsSabqhTM8Pbi
 GhO4386+IZWXJ2tytCPh2u1jiqvGREg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-q5CkIC7TMZyTSy_ro8_p_w-1; Mon, 17 Feb 2020 06:42:37 -0500
X-MC-Unique: q5CkIC7TMZyTSy_ro8_p_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00BD98017DF
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:42:37 +0000 (UTC)
Received: from lpt (unknown [10.43.2.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79FC460BEC;
 Mon, 17 Feb 2020 11:42:30 +0000 (UTC)
Date: Mon, 17 Feb 2020 12:42:28 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/3] tools/virtiofsd/passthrough_ll: Remove unneeded
 variable assignment
Message-ID: <20200217114228.GA7281@lpt>
References: <20200217094240.9927-1-philmd@redhat.com>
 <20200217094240.9927-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200217094240.9927-3-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
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

--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2020 at 10:42:39AM +0100, Philippe Mathieu-Daud=E9 wrote:
>Fix warning reported by Clang static code analyzer:
>
>    CC      tools/virtiofsd/passthrough_ll.o
>  tools/virtiofsd/passthrough_ll.c:925:9: warning: Value stored to 'newfd'=
 is never read
>          newfd =3D -1;
>          ^       ~~
>  tools/virtiofsd/passthrough_ll.c:942:9: warning: Value stored to 'newfd'=
 is never read
>          newfd =3D -1;
>          ^       ~~
>
>Fixes: 7c6b66027
>Reported-by: Clang Static Analyzer
>Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>---
>v2: do not set newfd, use it (jtomko)
>---
> tools/virtiofsd/passthrough_ll.c | 2 --
> 1 file changed, 2 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5KfCAACgkQ+YPwO/Ma
t52hOAf/ViRI/AbPaMf24U13ikuAWDcl0MQbHbNewGTxOzLThOvS25zlhuuIVxVX
6eb0/7YTktKmToU3KmwEIXUGGI8dY03Pdk1I1oj/u9xPVASM8ODnu7erfj/7UeDB
WZV6VnNDICh+2sGbzarS/iwca9oqDB7oorndJOOW6+Z9rOaqOtkvppmOs035eG6W
JlRss/TZiVChVkjRYjp5s5wpTeyICYUb/MeF7eb1inNIdxpTc95kc/BAeqsEojqb
nFdVBm/b+UPNa2qGe0YWLwDqpDboEZ6rFLphDOr/DGwOi73QRvkTdGeLntinduvS
eTzzn6VtytzsRG8iizzN4zalGNmc0Q==
=6SgJ
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--


