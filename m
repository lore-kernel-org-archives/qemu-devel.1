Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E62C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763742082F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763742082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0OhI-0007Xb-CB
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0OfA-0004Ns-Sf
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0OYY-0002aF-9w
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:13:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>)
 id 1i0OYY-0002Zo-4f; Wed, 21 Aug 2019 07:13:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7003F10576DE;
 Wed, 21 Aug 2019 11:13:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE5175D6B0;
 Wed, 21 Aug 2019 11:13:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id D1A5016E1A; Wed, 21 Aug 2019 13:13:29 +0200 (CEST)
Date: Wed, 21 Aug 2019 13:13:29 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190821111329.ho67nz3zrvwinbvq@sirius.home.kraxel.org>
References: <20190812113739.16587-1-philmd@redhat.com>
 <20190812113739.16587-3-philmd@redhat.com>
 <20190821090019.exsa646p7go2cdgn@sirius.home.kraxel.org>
 <9d5079d6-2ab2-8e44-e943-cc801522b018@redhat.com>
 <7b7db4c2-8349-431f-3314-491e160b9780@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7b7db4c2-8349-431f-3314-491e160b9780@vivier.eu>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Wed, 21 Aug 2019 11:13:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/display: Compile various display
 devices as common object
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
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 21, 2019 at 12:47:07PM +0200, Laurent Vivier wrote:
> Le 21/08/2019 =E0 12:31, Philippe Mathieu-Daud=E9 a =E9crit=A0:
> > Hi Gerd,
> >=20
> > On 8/21/19 11:00 AM, Gerd Hoffmann wrote:
> >> On Mon, Aug 12, 2019 at 01:37:38PM +0200, Philippe Mathieu-Daud=E9 w=
rote:
> >>> Various display devices are not target-specific and can
> >>> be compiled once for all the targets.
> >>> After this commit, the 'make world' target is reduced by
> >>> 54 objects
> >>
> >> Doesn't apply, needs a rebase.
> >=20
> > Laurent fixed the trivial conflict in patch #1.
> >=20
> > Since patch #2 depends of patch #1, can you Ack it so Laurent queue i=
t
> > in his trivial queue?
>=20
> Patch #2 applies cleanly once the patch #1 is fixed.
>=20
> Gerd, if you acknowledge it I add it to my queue.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>


