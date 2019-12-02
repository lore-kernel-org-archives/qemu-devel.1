Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87906C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:20:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F9A20833
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bw3KXNwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F9A20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibkgR-0004D3-EU
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 07:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49621)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1ibkfR-0003HB-GU
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1ibkfO-00076B-Dc
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:19:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43670
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ibkfO-00075f-9R
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575289141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXI6FVHSSTkGPDVpkIsTnkCCtFb+jaXFpCDz8AIyH+0=;
 b=bw3KXNwWABhsKxGzKCELyKjyy713b4FWFPA9H6KV3F7iavlVEARYCg2z3hOd4V1Z8t5a0W
 V+b7QJrK1JuIa94uQtualRle4c1Rp2WFZI9DLzfYYMyYWoLxGLaGu+kvJDTjRbUVRIH2V/
 gqAj4zsMMPdLyGsyfse1XgRKojRyzyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-2aTf_Q_iOJWuI3pl9wh0MQ-1; Mon, 02 Dec 2019 07:18:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E96CD8017CC
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 12:18:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B24B19C6A;
 Mon,  2 Dec 2019 12:18:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3D92F16E05; Mon,  2 Dec 2019 13:18:53 +0100 (CET)
Date: Mon, 2 Dec 2019 13:18:53 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: iPXE: update submodule
Message-ID: <20191202121853.shigtyrko725vmmg@sirius.home.kraxel.org>
References: <d33644db-ec7e-0b51-b6e6-b5fc15f37665@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d33644db-ec7e-0b51-b6e6-b5fc15f37665@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 2aTf_Q_iOJWuI3pl9wh0MQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 02, 2019 at 12:19:50PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Hi Gerd,
>=20
> 'make -C roms efirom' is failing on Fedora 30.
>=20
> Can you update the iPXE submodule so we get these buildsys commits:
>=20
> c742c576 [build] Move predefined all-drivers build shortcut to Makefile
> a4f8c6e3 [build] Do not apply WORKAROUND_CFLAGS for host compiler
> 1dd56dbd [build] Workaround compilation error with gcc 9.1
> 412acd78 [build] Fix "'%s' directive argument is null" error

Hmm.  Sure, can do that, but the question is for 4.2 or 5.0.  Updating
ipxe that close to the release makes me nervous, but shipping a ipxe
version which doesn't build with recent compilers in the release tarball
isn't great either.

I'd tend to go the 5.0 route.
Comments?
Suggestions?

cheers,
  Gerd


