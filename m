Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34382C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C0D20727
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LT6vgFl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C0D20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWfPC-0000cW-UI
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 06:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iWfO1-0007p4-E3
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iWfO0-0007cE-Cy
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:40:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44384
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iWfO0-0007c2-9R
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574077203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pg1/bvbhHvcRVPwsEkyPTDDEKMMYw49cVJ9kAzRM1ok=;
 b=LT6vgFl5vzUfcAsCukQcpWYKSSD/nCd3xsHc9M6lxhsV6cc/1kgpOp13hUPzLWbljvgEpl
 WgzJ0wz2dJTGAiqGzGFct3H58ctap7d5wVpoi4M+/1UU3toXJ/A27iW4UOHLUsY2EJ1d6O
 yUz/ptlmPHATLoUMr3+xmXrCw8H/NSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-zHiEwF4rN5O8e9liX62qhg-1; Mon, 18 Nov 2019 06:40:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 851B8107ACC9;
 Mon, 18 Nov 2019 11:39:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 409594B6;
 Mon, 18 Nov 2019 11:39:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6367B16E2D; Mon, 18 Nov 2019 12:39:58 +0100 (CET)
Date: Mon, 18 Nov 2019 12:39:58 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] buildfix: update texinfo menu
Message-ID: <20191118113958.y4z6upzjzvxtkjwe@sirius.home.kraxel.org>
References: <20191023101956.19120-1-kraxel@redhat.com>
 <ba8b74e7-8c37-dc76-a77e-33448b698777@redhat.com>
 <87blt9y2c4.fsf@dusky.pond.sub.org>
 <CAFEAcA8yQm7B7Cdif8GtzL_67io_-DvHZzV6H+Aiy+L0CaP2Rg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8yQm7B7Cdif8GtzL_67io_-DvHZzV6H+Aiy+L0CaP2Rg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: zHiEwF4rN5O8e9liX62qhg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Laszlo Ersek <lersek@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 18, 2019 at 11:08:52AM +0000, Peter Maydell wrote:
> On Mon, 18 Nov 2019 at 09:13, Markus Armbruster <armbru@redhat.com> wrote=
:
> >
> > Laszlo Ersek <lersek@redhat.com> writes:
> >
> > > On 10/23/19 12:19, Gerd Hoffmann wrote:
> > >> Build error message:
> > >> qemu-doc.texi:34: node `Top' lacks menu item for `Recently removed f=
eatures' despite being its Up target
> > >>
> > >> Fixes: 3264ffced3d0 ("dirty-bitmaps: remove deprecated autoload para=
meter")
> > >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > >> ---
> > >>  qemu-doc.texi | 1 +
> > >>  1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/qemu-doc.texi b/qemu-doc.texi
> > >> index 3c5022050f0f..3ddf5c0a6865 100644
> > >> --- a/qemu-doc.texi
> > >> +++ b/qemu-doc.texi
> > >> @@ -44,6 +44,7 @@
> > >>  * Security::
> > >>  * Implementation notes::
> > >>  * Deprecated features::
> > >> +* Recently removed features::
> > >>  * Supported build platforms::
> > >>  * License::
> > >>  * Index::
> > >>
> > >
> > > Can this patch be included in v4.2.0-rc2 please?
> >
> > Cc'ing qemu-trivial again, might be a workable path into -rc2.
>=20
> I've just applied it directly to master. (Not sure why none
> of my build test machines complain about the error.)

Probably some build dependency for --enable-docs is missing.
sphinx maybe?

cheers,
  Gerd


