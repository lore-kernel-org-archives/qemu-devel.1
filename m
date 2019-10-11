Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88B5ECE58E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 06:02:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824DE20659
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 06:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824DE20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIo0m-00080z-Jy
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 02:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iIo08-0007c3-EQ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 02:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iIo06-0000jL-0h
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 02:02:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54274)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iIo05-0000gy-RW
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 02:02:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 05D493090FE0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:02:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DF601001B11;
 Fri, 11 Oct 2019 06:02:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB3F61138619; Fri, 11 Oct 2019 08:01:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] trace: avoid "is" with a literal Python 3.8 warnings
References: <20191010122154.10553-1-stefanha@redhat.com>
Date: Fri, 11 Oct 2019 08:01:58 +0200
In-Reply-To: <20191010122154.10553-1-stefanha@redhat.com> (Stefan Hajnoczi's
 message of "Thu, 10 Oct 2019 13:21:54 +0100")
Message-ID: <87v9svlt0p.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 11 Oct 2019 06:02:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "Daniel P . =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefan Hajnoczi <stefanha@redhat.com> writes:

> The following statement produces a SyntaxWarning with Python 3.8:
>
>   if len(format) is 0:
>   scripts/tracetool/__init__.py:459: SyntaxWarning: "is" with a literal. =
Did you mean "=3D=3D"?
>
> Use the conventional len(x) =3D=3D 0 syntax instead.
>
> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/tracetool/__init__.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
> index 04279fa62e..44c118bc2a 100644
> --- a/scripts/tracetool/__init__.py
> +++ b/scripts/tracetool/__init__.py
> @@ -456,12 +456,12 @@ def generate(events, group, format, backends,
>      import tracetool
>=20=20
>      format =3D str(format)
> -    if len(format) is 0:
> +    if len(format) =3D=3D 0:
>          raise TracetoolError("format not set")
>      if not tracetool.format.exists(format):
>          raise TracetoolError("unknown format: %s" % format)
>=20=20
> -    if len(backends) is 0:
> +    if len(backends) =3D=3D 0:
>          raise TracetoolError("no backends specified")
>      for backend in backends:
>          if not tracetool.backend.exists(backend):

For what it's worth, PEP 8 advises

    For sequences, (strings, lists, tuples), use the fact that empty
    sequences are false.

    Yes: if not seq:
         if seq:

    No:  if len(seq):
         if not len(seq):

