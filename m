Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64334C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 378F821907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 11:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 378F821907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAuJH-00025C-BA
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 07:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iAuBl-0003mb-4R
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iAuBg-0006K6-5g
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 07:01:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1iAuBg-0006Iz-0A; Thu, 19 Sep 2019 07:01:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1365518C8935;
 Thu, 19 Sep 2019 11:01:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com
 [10.36.116.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A703360C80;
 Thu, 19 Sep 2019 11:01:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9E9081747D; Thu, 19 Sep 2019 13:01:20 +0200 (CEST)
Date: Thu, 19 Sep 2019 13:01:20 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190919110120.l7s4hvpqmcgqofhi@sirius.home.kraxel.org>
References: <20190914145155.19360-1-chewi@gentoo.org>
 <457c3a3c-d1b3-9f73-e156-24add1347e07@vivier.eu>
 <20190919083708.mwqjq6qzyemqlxpq@sirius.home.kraxel.org>
 <8dad2ef4-87ed-27ca-da22-a9ef4fa87cde@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8dad2ef4-87ed-27ca-da22-a9ef4fa87cde@vivier.eu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Thu, 19 Sep 2019 11:01:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] configure: Add xkbcommon
 configure options
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
Cc: qemu-trivial@nongnu.org, James Le Cuirot <chewi@gentoo.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 19, 2019 at 12:16:43PM +0200, Laurent Vivier wrote:
> Le 19/09/2019 =E0 10:37, Gerd Hoffmann a =E9crit=A0:
> > On Mon, Sep 16, 2019 at 10:15:15AM +0200, Laurent Vivier wrote:
> >> Le 14/09/2019 =E0 16:51, James Le Cuirot a =E9crit=A0:
> >>> This dependency is currently "automagic", which is bad for distribu=
tions.
> >>>
> >>> Signed-off-by: James Le Cuirot <chewi@gentoo.org>
> >>> ---
> >>>  configure | 5 +++++
> >>>  1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/configure b/configure
> >>> index 30aad233d1..30544f52e6 100755
> >>> --- a/configure
> >>> +++ b/configure
> >>> @@ -1521,6 +1521,10 @@ for opt do
> >>>    ;;
> >>>    --disable-libpmem) libpmem=3Dno
> >>>    ;;
> >>> +  --enable-xkbcommon) xkbcommon=3Dyes
> >>> +  ;;
> >>> +  --disable-xkbcommon) xkbcommon=3Dno
> >>> +  ;;
> >>>    *)
> >>>        echo "ERROR: unknown option $opt"
> >>>        echo "Try '$0 --help' for more information"
> >>> @@ -1804,6 +1808,7 @@ disabled with --disable-FEATURE, default is e=
nabled if available:
> >>>    capstone        capstone disassembler support
> >>>    debug-mutex     mutex debugging support
> >>>    libpmem         libpmem support
> >>> +  xkbcommon       xkbcommon support
> >>> =20
> >>>  NOTE: The object files are built at the place where configure is l=
aunched
> >>>  EOF
> >>>
> >>
> >> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> >>
> >> cc: Gerd Hoffmann <kraxel@redhat.com>
> >=20
> > Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> >=20
>=20
> Gerd,
>=20
> do you take this through your ui branch or should I take through the
> trivial patches branch?

Trivial branch is fine (have not picked this up b/c I saw qemu-trivial
on cc).

cheers,
  Gerd

>=20
> Thanks,
> Laurent

