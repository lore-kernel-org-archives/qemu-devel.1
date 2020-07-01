Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F74EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:13:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D9EE207FB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Te5Zh5/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9EE207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfMP-0000HP-6n
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqfIh-0002kB-Oh
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:09:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35754
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqfIb-0005kq-QD
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593619764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SaX4PzBLMh2sV67u3LvcgIJHlW7iqHLXaKWN6OT15pc=;
 b=Te5Zh5/88Nj0I2PLjeMq+fgm4yN6Z4mqvJaJQLkc66UZ/ByMvu4+C7weZT+fLw7dJLDgt1
 Zim/tC70aIs/8y8P41xGUyQFkMTKgGF8bbCv1TpmyUS/ucyHKHG86EOf2sroITk9Qm3Pdj
 JyhBAV/H4xwEuF7TsTnxunEVoFKkuEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-XFtC70awMqOFZsHojpu0iA-1; Wed, 01 Jul 2020 12:09:22 -0400
X-MC-Unique: XFtC70awMqOFZsHojpu0iA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0EDEA0BEE;
 Wed,  1 Jul 2020 16:09:15 +0000 (UTC)
Received: from localhost (ovpn-113-121.ams2.redhat.com [10.36.113.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BA55CF921;
 Wed,  1 Jul 2020 16:09:08 +0000 (UTC)
Date: Wed, 1 Jul 2020 17:09:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 3/3] trace: Example of "centralized" recorder tracing
Message-ID: <20200701160906.GT126613@stefanha-x1.localdomain>
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-4-dinechin@redhat.com>
 <20200630124136.GM1370404@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200630124136.GM1370404@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Nx8xdmI2KD3LNVVP"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Christophe de Dinechin <dinechin@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Nx8xdmI2KD3LNVVP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 01:41:36PM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, Jun 26, 2020 at 06:27:06PM +0200, Christophe de Dinechin wrote:
> IMHO the whole point of having the pluggable trace backend impls, is
> precisely that we don't have to add multiple different calls in the
> code. A single trace_qemu_mutex_unlock() is supposed to work with
> any backend.

I think an exception is okay when the other trace backends do not offer
equivalent functionality.

Who knows if anyone other than Christophe will use this functionality,
but it doesn't cost much to allow it.

Stefan

--Nx8xdmI2KD3LNVVP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl78tSIACgkQnKSrs4Gr
c8j/GQgAgNy/SWFiJbP6myrwfWhGl88K9kXdSPztNHnBEi0UUFEId5jlymb5+fi8
7mAPWb0T5BDhro0wIbW4vnGFNj+i4htDBCdwY5nFEj7b24LW8gd/buyOWFqtM7GI
l4k12yroc0piasmO/suVbkLxakln7u9K5t+BBdt1qc9BuBS3QwD/ZFuZMCoZq4v5
Mmqr6QB4GZoXuQHQREL7Kw4TMj0+I7noUQN8ZjzdS7W8GTbTTBmiNa35tgw8fJk6
7rdI7lT/wk+NGXmO0OLOuJkc18cZDWvObz6ZX1tkXMz6Zia2piDT4Ud594YNuGjG
Q3/zOj6AjuyG+DedLosKmJnzQtcgGg==
=owWv
-----END PGP SIGNATURE-----

--Nx8xdmI2KD3LNVVP--


