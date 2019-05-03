Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2E1C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 20:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF772081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 20:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF772081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47093 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMf7E-0007lm-CT
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 16:49:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hMf6L-0007T6-BV
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:48:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hMf6J-0003rt-Gd
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:48:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1hMf6J-0003pM-BP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 16:48:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05EFF2DD43;
	Fri,  3 May 2019 20:48:02 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-116-28.ams2.redhat.com [10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D48E600C7;
	Fri,  3 May 2019 20:48:01 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
	id E678F3E0219; Fri,  3 May 2019 22:47:57 +0200 (CEST)
Date: Fri, 3 May 2019 22:47:57 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190503204757.GF4675@paraplu>
References: <20190503154613.4192-1-kchamart@redhat.com>
	<20190503154613.4192-2-kchamart@redhat.com>
	<20190503154905.GJ17905@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190503154905.GJ17905@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 03 May 2019 20:48:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] VirtIO-RNG: Update default entropy source
 to `/dev/urandom`
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, armbru@redhat.com, rjones@redhat.com,
	qemu-devel@nongnu.org, amit@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503204757.JLJX-3DbbKT0NumauFycq2RhJAolbzw2mhQZupqWTDY@z>

On Fri, May 03, 2019 at 04:49:05PM +0100, Daniel P. Berrang=E9 wrote:
> On Fri, May 03, 2019 at 05:46:13PM +0200, Kashyap Chamarthy wrote:
> > When QEMU exposes a VirtIO-RNG device to the guest, that device needs=
 a
> > source of entropy, and that source needs to be "non-blocking", like
> > `/dev/urandom`.  However, currently QEMU defaults to the problematic
> > `/dev/random`, which is "blocking" (as in, it waits until sufficient
> > entropy is available).
> >=20
> > So change the entropy source to the recommended `/dev/urandom`.
> >=20
> > Related discussion in these[1][2] past threads.
> >=20
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08335=
.html
> >     -- "RNG: Any reason QEMU doesn't default to `/dev/urandom`?"
> > [2] https://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02724=
.html
> >     -- "[RFC] Virtio RNG: Consider changing the default entropy sourc=
e to
> >        /dev/urandom"
> >=20
> > Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> > ---
> >  backends/rng-random.c | 2 +-
> >  qemu-options.hx       | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>

I'm wondering if this needs to be mentioned on a Release Notes wiki
somewhere -- because we're changing the default.

--=20
/kashyap

