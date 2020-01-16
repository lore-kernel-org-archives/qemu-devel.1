Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA52C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA232075B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIQmdh16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA232075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6IQ-0001g3-FN
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1is6H2-0000AV-76
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:37:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1is6Gy-00031y-9z
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:37:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24466
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1is6Gy-00031a-62
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579185443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53/LJhBfY0lsBITPviBXohU3Ioy3jeHVU0BJGPFBez0=;
 b=YIQmdh16ZO36QLNLH0ZKyAdSFokVn4FU/zoqWg2nhSQVuillc6Kvw3AN0ZmRUZGQBzitBr
 uzuZZlzHYz66g8yYcxmt0VLcCgUOwisexYnlhuPfTtOOynz2ldXwJ399E2BqlMwX7+7pit
 fEEirFcClyce3HSA2RHTuDJsPyoZ/AM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-svwj0Z9hOZmzljeb37R12A-1; Thu, 16 Jan 2020 09:37:14 -0500
X-MC-Unique: svwj0Z9hOZmzljeb37R12A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7B8B108594D
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 14:37:13 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF7FA63764;
 Thu, 16 Jan 2020 14:37:09 +0000 (UTC)
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-52-dgilbert@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 051/104] virtiofsd: Parse flag FUSE_WRITE_KILL_PRIV
In-reply-to: <20191212163904.159893-52-dgilbert@redhat.com>
Date: Thu, 16 Jan 2020 15:37:07 +0100
Message-ID: <87o8v3wjqk.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: Vivek Goyal <vgoyal@redhat.com>
>
> Caller can set FUSE_WRITE_KILL_PRIV in write_flags. Parse it and pass it
> to the filesystem.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  tools/virtiofsd/fuse_common.h   | 6 +++++-
>  tools/virtiofsd/fuse_lowlevel.c | 4 +++-
>  2 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4gdRMACgkQ9GknjS8M
AjUfGA/+LjfjF8cvENovS6L8NU7/MsSPGgqeTypzhjUn4EMsJupdIzPEhBd8M+TL
6P3QghIDOwajSlWHVagZJYzzMB3Dayu8YltIgnhffFVHb6gc6GERoeB18QVlTLIm
DKpaso9aaOQ9Kmpo1zuaOdCj/gNTL3ofmHoCvKD188bIjrCBEx3WOqivE12IMaDZ
rSxwO1OykOzFBFJ1o3g8cZ+8kJw+VrqaZWx98QmO4r2PlN2wPqCGOuZFETcdY6NP
CsZF1oToczVrAQQZoBl6vLyOEv/dyyj0rYc8JqTDs/BDR6h8Q4yfFTCmhdJ4g8YC
kY2hJp8Rbxsb4xxxnozsiSm8XIQFjFrIbw71t22BTgkMjr9L1qZaabDwrXZCMntW
CeHPohcKMeIX1pNH6iCBfDN7iJ7nQ+16Dtxsjy5JX/U6EqXT7dKi8TZxEdqME2sY
rZW80op/0M8NDkzEJ9rrQrTACJASCGOn/6bcKj3FEDZs3bPD4zwdiHeLyifxEgfK
fH6To2KKCznpM9ETtFDBP1vNlxBaj/uW0nn+22IpIU7CU8Mgjet2lXZHbnAXH8JF
AJzxrtocPXPETwZTM79FYEFZivjcKQ0R0BWxNC2sCUwaAJY/9S0JfLKRIrCE19sm
Mlh5BHlUIzQq2QB3nUimmYJIegzCE12VAZg7chzi++iWsdGez+k=
=t8IJ
-----END PGP SIGNATURE-----
--=-=-=--


