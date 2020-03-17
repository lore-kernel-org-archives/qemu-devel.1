Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4507EC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C3620714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+fWi2+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C3620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEDBt-0005cV-Nu
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jEDBA-0005Bw-Fk
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jEDB9-0002lP-8J
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:26:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24559)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jEDB9-0002iK-2z
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584455206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+nqmrpAt8Bq6pO2wrCPcySJDZASLb5ZeXMdvNMe4ZU8=;
 b=H+fWi2+KcJRcGZFWcGaL3gIEV6r6m10GgJGAIDCqEXvHYl3QZVmkk6nYp/Cwi7tBg0u32+
 Iu0SJOHfgvdIYKHDpyTcKhxWvaD484NWuKQImuQD59RigFu/BRjXjIXo40YlHn4oa0S7e3
 KFfisqLG0z9HpljbgjynyWPHW0Y2ycY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-a1qLYOdlP-CFuXxCUq3s6g-1; Tue, 17 Mar 2020 10:26:44 -0400
X-MC-Unique: a1qLYOdlP-CFuXxCUq3s6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3385BDB25;
 Tue, 17 Mar 2020 14:26:37 +0000 (UTC)
Received: from localhost (ovpn-114-232.ams2.redhat.com [10.36.114.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEF7360C81;
 Tue, 17 Mar 2020 14:26:36 +0000 (UTC)
Date: Tue, 17 Mar 2020 14:26:35 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/61] Misc patches for soft freeze
Message-ID: <20200317142635.GB517094@stefanha-x1.localdomain>
References: <1584396375-31278-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-W=7LQyKvy-Pxv7eUh-tLoYu5jLiObTST0-Ee0wrCX7g@mail.gmail.com>
 <da99ee7c-49fb-057e-a6bb-b2c89de86ffa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <da99ee7c-49fb-057e-a6bb-b2c89de86ffa@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gatW/ieO32f1wygP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2020 at 01:02:48PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing Stefan
>=20
> On 3/17/20 12:03 PM, Peter Maydell wrote:
> > On Mon, 16 Mar 2020 at 22:07, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> > >=20
> > > The following changes since commit a98135f727595382e200d04c2996e868b7=
925a01:
> > >=20
> > >    Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pul=
l-request' into staging (2020-03-16 14:55:59 +0000)
> > >=20
> > > are available in the git repository at:
> > >=20
> > >=20
> > >    git://github.com/bonzini/qemu.git tags/for-upstream
> > >=20
> > > for you to fetch changes up to 9d04fea181318684a899fadd99cef7e0409745=
6b:
> > >=20
> > >    hw/arm: Let devices own the MemoryRegion they create (2020-03-16 2=
3:02:30 +0100)
> > >=20
> > > ----------------------------------------------------------------
> > > * Bugfixes all over the place
> > > * get/set_uint cleanups (Felipe)
> > > * Lock guard support (Stefan)
> > > * MemoryRegion ownership cleanup (Philippe)
> > > * AVX512 optimization for buffer_is_zero (Robert)
> >=20
> > Hi; this generates a new warning on netbsd:
> >=20
> > /home/qemu/qemu-test.N42OXz/src/util/qemu-timer.c: In function
> > 'timerlist_expired':
> > /home/qemu/qemu-test.N42OXz/src/util/qemu-timer.c:197:12: warning:
> > 'expire_time' may be used uninitialized in this function
> > [-Wmaybe-uninitialized]
> >       return expire_time <=3D qemu_clock_get_ns(timer_list->clock->type=
);
> >              ^
> > /home/qemu/qemu-test.N42OXz/src/util/qemu-timer.c: In function
> > 'timerlist_deadline_ns':
> > /home/qemu/qemu-test.N42OXz/src/util/qemu-timer.c:235:11: warning:
> > 'expire_time' may be used uninitialized in this function
> > [-Wmaybe-uninitialized]
> >       delta =3D expire_time - qemu_clock_get_ns(timer_list->clock->type=
);
> >             ^
> >=20
> > This is probably just the compiler being not smart enough
> > to figure out that there's no code path where it's not
> > initialized.

Yes, looks like the compiler can't figure out the control flow on
NetBSD.

We could drop the WITH_QEMU_LOCK_GUARD() macro and use this idiom
instead:

  {
      QEMU_LOCK_GUARD(&mutex);
      ...
  }

But it's unusual for C code to create scopes without a statement (for,
if, while).

Opinions?

Stefan

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5w3hsACgkQnKSrs4Gr
c8j9Rwf+PC44PXBs1ou2CQuthdpk8epqeMu69AksJlNepD5nWLGqX8Bwok6c2MIa
7+ERm9hXZ1yi0228rTKD3S5RdXsggk5O8vABZIl3F7KJpuR6jLK919Vgwbb0G6Yv
xhECbLo2rkXdyXpxxTPGgliDhkSFeNP29Z+iYjWccQJHpC1VPOQtA5XTMAOHiKTG
erSHoJ2yyreibF7A6MLawVB4Bk4+yVrO6kpQM8LGY8ew4OrBxleO7ySTj5Ga/Kpz
P2kMJ9M+DsvP5t3ncSsZRkvhlLQzbT5kF7BXmb299TR7AgmqT+Qu61XH8UuNVQNU
6PG91HC6idLGNzaaUWc2NfXqWgzyiQ==
=54je
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--


