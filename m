Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95524C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B3B62175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3B62175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59125 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFb6-0008J6-Fg
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 15:11:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFZx-0007eg-QN
	for qemu-devel@nongnu.org; Fri, 24 May 2019 15:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hUFZw-0004k9-40
	for qemu-devel@nongnu.org; Fri, 24 May 2019 15:10:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hUFZs-0004i0-Q8; Fri, 24 May 2019 15:10:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0E4A4E92A;
	Fri, 24 May 2019 19:09:58 +0000 (UTC)
Received: from localhost (ovpn-116-14.gru2.redhat.com [10.97.116.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8343736FB;
	Fri, 24 May 2019 19:09:54 +0000 (UTC)
Date: Fri, 24 May 2019 16:09:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Message-ID: <20190524190952.GL10764@habkost.net>
References: <20190506142042.28096-1-clg@kaod.org>
	<b12201c8-7d5f-2108-6666-75543c38f243@kaod.org>
	<f1ca56fd-c83d-8ad6-29c9-a8fc6af4531c@redhat.com>
	<270e510b-687a-6b43-8cd6-c1eb1aea41e6@kaod.org>
	<6161d982-0d21-99d6-680a-37ae300fd7cd@kaod.org>
	<98d1e57f-c033-fdb4-51bd-4a6fc2223d58@redhat.com>
	<CAFEAcA-eVECkPpxnvDtX3v6BFMSVCF4SU87r51PdG=E=hCYLfA@mail.gmail.com>
	<c2597233-e1e3-6bed-e992-ec8ea250cedd@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c2597233-e1e3-6bed-e992-ec8ea250cedd@kaod.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 24 May 2019 19:10:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/3] aspeed: cleanups and extensions
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
	QEMU Developers <qemu-devel@nongnu.org>,
	qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 23, 2019 at 03:03:11PM +0200, C=E9dric Le Goater wrote:
> On 5/23/19 2:52 PM, Peter Maydell wrote:
> > On Mon, 20 May 2019 at 17:32, Philippe Mathieu-Daud=E9 <philmd@redhat=
.com> wrote:
> >>
> >> On 5/20/19 3:32 PM, C=E9dric Le Goater wrote:
> >>>> Peter,
> >>>>
> >>>> do you want me to resend with only the two first patches and inclu=
de
> >>>> Joel's in the same series ? I would leave out the part Philippe is
> >>>> covering in his object_initialize_child() patchset.
> >>>
> >>> Nope, we can not do that, conflicts arise. I suppose the easier is =
wait
> >>> for Philippe's patchset to be merged and then rebase.
> >>
> >> Eduardo said he'll send a pull request during the week.
> >=20
> > I am now completely lost about the status of these patches,
> > so I'm just dropping this series from my to-review queue.
>=20
> yes. It's ok.
>=20
> > Please send a fresh patchset once any dependencies have
> > got into master.
>=20
> I plan to send a larger one once Eduardo's patchset is merged.

I've just submitted a pull request including the
object_initialize_child() patches from Philippe:
  [PULL 00/17] Machine Core queue, 2019-05-24

Sorry for the delay.

--=20
Eduardo

