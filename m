Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BFFC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:21:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5555D205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iyo7oZSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5555D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is61A-0007QC-CX
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1is5xW-0002of-W7
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1is5xT-0008Pv-3l
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:17:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37057
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1is5xS-0008P2-Mr
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:17:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579184233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FkISfMjS34h75Nu6r1yzGIY0abJW5mdb3XVJXEbbn1Y=;
 b=Iyo7oZSL4BMHaCoM5YAfXpiB9hSfR0it1pTfRlRC+jVklIgsev5H8/usROy0cZYGY/3guJ
 BixsutR/2Y5CRUrn64MhVtM8hFNlaS9m0s5LuvplmbUNzALrPybnJzsxXDm8pNGQ3m+/A0
 IDhF9iU6WRwyly+nbRO1Hl0eWG1d4/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-j_Ui2pu7OWaaYsVJtv1n1Q-1; Thu, 16 Jan 2020 09:17:12 -0500
X-MC-Unique: j_Ui2pu7OWaaYsVJtv1n1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2005F107ACC7
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 14:17:11 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD9FE5C28D;
 Thu, 16 Jan 2020 14:17:07 +0000 (UTC)
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-42-dgilbert@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 041/104] virtiofsd: add fuse_mbuf_iter API
In-reply-to: <20191212163904.159893-42-dgilbert@redhat.com>
Date: Thu, 16 Jan 2020 15:17:04 +0100
Message-ID: <87wo9rwknz.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: vgoyal@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: Stefan Hajnoczi <stefanha@redhat.com>
>
> Introduce an API for consuming bytes from a buffer with size checks.
> All FUSE operations will be converted to use this safe API instead of
> void *inarg.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/buffer.c      | 28 ++++++++++++++++++++
>  tools/virtiofsd/fuse_common.h | 49 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 76 insertions(+), 1 deletion(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4gcGAACgkQ9GknjS8M
AjXPMw/8CSrMxOaY/EqW7s+zaK9NgMcu+lNVIEXOM/Q45wBEUnQ+SajkiqZIWPp5
AtSSUne1AZXxqVTD82CfIFfVMAKjijNwfq0aXK6vuJdfYhqDVVdsIgZacdutZrHv
sF5KN1W3jjNe44quecTxSk8J3R5i7UMAzJkPxoP2zq/4+fh2agJC1AMHfQzxkNXN
QMFdWzydpZOSh4pXJm2K9VhBuJH16AZ9ASg4Axz/4YnLHlksbVdMUvr7lGA7dFYu
lC+jcz1esHiA2jc8BDvH0ls8RkrupOG5aZdZE6WomN9klmoGj/iVYfJwDiqYtIuo
JY9zHi0Fp4U7TeSILpZTwsfeRPnir04MiuOXh9P8eLHUWUfIY0KWk2bET9tcUJ2W
BNAoMtuDC7jyANpAomJgyUmzXn6USF8hvlna/xlDSRg2vX+kdobMQXTwvzKKDiL+
wW0c5kEuk4pJxS5qiy9IIBaJrzZU73Bqtcw6nWkPfJR8EDxDXA/HlI6d/JLnUqG4
Y9131LlXg6d8jHrFASZV9dybUekh9cqQrBuSOYl0rwxYtAgqkdpNOAE9JRbgfKgs
4rOLH63X5uAgDDjF2m61fiLW8eP+y5ateF5irArGvjjJDFkadiikffUVf66sP20O
fUu46rfXU207uhzEBH03GSEx7DgaFVLs/6zYOP4mwXKlMoIIj3A=
=enbU
-----END PGP SIGNATURE-----
--=-=-=--


