Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D2EC35242
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 22:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B578022522
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 22:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSdPwEu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B578022522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Yyy-0002jA-VI
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 17:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j0YyN-0001KI-L3
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 17:53:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j0YyL-0006St-8j
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 17:53:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29348
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j0YyK-0006Pu-Tk
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 17:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581202387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gxFLU7f/at2iaVKBvXa0GQUb6YmWzKSUTCbS7pcCNos=;
 b=WSdPwEu/rGTDmlsnG14o1Ki1ymwByiiunTzJ6U/b5OYl6vFhmO12TsfQ3zqBqNP19foS/C
 p9Y8Io7LsF06+QdqPnhaYhzCqH0yVjpu79ptCdYtHjBUkdBLmTwcvcoU1GHaOt7U+HitH6
 7qlo8ai46rRd9McrtMqBKX7sHnyZTJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-1c3Ka8LON_CkynwMm9faCQ-1; Sat, 08 Feb 2020 17:53:01 -0500
X-MC-Unique: 1c3Ka8LON_CkynwMm9faCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6D208014C1;
 Sat,  8 Feb 2020 22:53:00 +0000 (UTC)
Received: from lpt (ovpn-200-20.brq.redhat.com [10.40.200.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B28D10013A7;
 Sat,  8 Feb 2020 22:52:52 +0000 (UTC)
Date: Sat, 8 Feb 2020 23:52:49 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 0/7] ui: rework -show-cursor option
Message-ID: <20200208225249.GA1329@lpt>
References: <20200207101753.25812-1-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200207101753.25812-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 jpewhacker@gmail.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 11:17:46AM +0100, Gerd Hoffmann wrote:
>Add -display {sdl,gtk,cocoa},show-cursor=3Don as replacement for
>-show-cursor.  sdl + cocoa are switched over (no change in behavior),
>gtk support is added.
>
>Gerd Hoffmann (7):
>  ui: add show-cursor option
>  ui: wire up legacy -show-cursor option
>  ui/sdl: switch to new show-cursor option
>  ui/cocoa: switch to new show-cursor option
>  ui/gtk: implement show-cursor option
>  ui: drop curor_hide global variable.
>  ui: deprecate legacy -show-cursor option
>
> include/sysemu/sysemu.h |  1 -
> ui/gtk.c                |  8 ++++++--
> ui/sdl2.c               | 16 ++++++++--------
> vl.c                    | 16 ++++++++++++++--
> qapi/ui.json            |  3 +++
> qemu-deprecated.texi    |  5 +++++
> ui/cocoa.m              |  4 ++++
> 7 files changed, 40 insertions(+), 13 deletions(-)
>

Series:
Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl4/O70ACgkQ+YPwO/Ma
t53t5QgAp+vkpNDiOo111iByQyOwb7u3lKn/4xiMHVZoYYiUY8xa6HfYMBPISfSe
jIGQPm0fJ6+jjHgFq6axULqjSyQCGf1Li5dfBqK+a2RcF0Taqh09z50TuuduRWBg
bRXNlAuSk1DTEA3p+2s0A6Rs+rjE1aSouJm8IeKY4sGGG3GUbxW9A6kAh6BDwGi8
7GkP6D1UvT9DZMdC3/I6u9fyfnp8ugGUEQ4LLn7fkjwwBvTygRttPHOanUAdZA82
FSkdoxhO4nr/LqRyFexMm8oFRO7UOuhLE+x8XMnsGyEp3lFR7CGUbdVsYlBWs2uC
hThEnI6eM2f4591T+ffTwodFSZzEEw==
=lVoJ
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--


