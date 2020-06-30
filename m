Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FE5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12EA20672
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUVMiVUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12EA20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFJG-0001PK-Un
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqFIR-0000b1-J2
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:23:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25327
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqFIN-0002Gr-FC
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593519804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4kTriSS8St9gEVE6brlz4V6tvs9K7xUCWT0SR914JLU=;
 b=iUVMiVUVr1GPOTv5jZB01DXzCTriux0v6ifyhsHZ+l05gyJF12OlWqKKe8RXTqJP4ip1o2
 JsVub4Sj6MuM6S1qSlMpTrLhq5fPTFpRH2W2NUghNyjXY77vyu4kFSdMhIEFW63eRkhZgl
 bBNL+bUYllcYoyjkUDTjcdrzG4Xv7i8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-48Be7FepOxuGts-d4xiAVQ-1; Tue, 30 Jun 2020 08:23:20 -0400
X-MC-Unique: 48Be7FepOxuGts-d4xiAVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72BD5A0C00;
 Tue, 30 Jun 2020 12:23:19 +0000 (UTC)
Received: from localhost (ovpn-115-106.ams2.redhat.com [10.36.115.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4C5219C4F;
 Tue, 30 Jun 2020 12:23:15 +0000 (UTC)
Date: Tue, 30 Jun 2020 13:23:14 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v2 1/3] Makefile: Compute libraries for libqemuutil.a and
 libvhost-user.a
Message-ID: <20200630122314.GD91444@stefanha-x1.localdomain>
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-2-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200626162706.3304357-2-dinechin@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
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
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 06:27:04PM +0200, Christophe de Dinechin wrote:
> In util/Makefile.objs, there is a setting for dbus.o-libs.
> Trying to copy-paste that to add a library for module.o that was was
> not otherwise linked yields link errors on a number of binaries,
> e.g. qemu-ga, with unsatisfied symbols in libqemuutil.a(module.o).
> The reason is that library dependencies are not propagated to the .a
> files automatically.
>=20
> Adding a call to extract-libs to get the libraries for the two .a
> files that are used elsewhere.
>=20
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index a0092153af..b29b0eeefa 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -589,6 +589,8 @@ Makefile: $(version-obj-y)
>  ######################################################################
>  # Build libraries
> =20
> +libqemuutil.a-libs +=3D $(call extract-libs, $(util-obj-y) $(trace-obj-y=
) $(stub-obj-y))
> +libvhost-user.a-libs +=3D $(call extract-libs, $(libvhost-user-obj-y) $(=
util-obj-y) $(stub-obj-y))
>  libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
>  libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)

Please see https://patchwork.kernel.org/patch/11608247/#23440227.

If this change causes all libraries from .a object files to be linked
then this patch is incomplete. The purpose of the .a file is to link
only the subset of .o files required by the program. Unused .o files in
the .a file are not linked into the program. The libraries must also be
linked as needed but this patch seems to extract them unconditionally.

Stefan

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl77LrIACgkQnKSrs4Gr
c8iFqgf9GDLkr1syG/RG+b0n3M5eG/5v4EATIqNPnB8mb29/YZX1jyCDpv2ps4+d
jVh2ubxeXth4aMP7cMLjQdPOTbrjCAykcye00g29q7hSRjzNXBz5cvgeWcfbcd+x
VbRXb9kakYaRyy78AGeRYAd+bX8XzRunwQ3jKivl5xUCDHTL4ifIRMv7Ojt3KuU7
cefOBwtM/hOFic2nFYuyXd/UDvmVnqjIU0sVuLjEjrLHMEJQIfOn7AhuwcoXdvfl
4uEsPmu7E5mhYqW2G4bidvIEnvWV2f5hVmRkFjMjaknI0c3lO//vmOfl0U5NNpqM
fxdstuNsJjh3F3EpbCCEA1MAex18DQ==
=tAOl
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--


