Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970E0C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB4A20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 10:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB4A20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37743 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7day-0002Sp-PF
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 06:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36882)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i7dZD-0000ud-TX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:40:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i7dZC-0002g6-I7
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 06:40:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i7dZA-0002fA-9x; Tue, 10 Sep 2019 06:40:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A034806A4D;
 Tue, 10 Sep 2019 10:40:07 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E2585C22F;
 Tue, 10 Sep 2019 10:40:03 +0000 (UTC)
Message-ID: <f4fa4bbd538e0a6356948f394dfef33aea5af218.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 13:40:02 +0300
In-Reply-To: <5c843f00-eb9f-8442-fb0c-e99aa423c5a9@redhat.com>
References: <20190712173600.14554-1-mreitz@redhat.com>
 <84a35d4dd5a915fb879a313b0d5cd30bfa6aaa67.camel@redhat.com>
 <5c843f00-eb9f-8442-fb0c-e99aa423c5a9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 10 Sep 2019 10:40:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/7] block: Generic file
 creation fallback
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-09-10 at 11:16 +0200, Max Reitz wrote:
> On 05.09.19 15:30, Maxim Levitsky wrote:
> > On Fri, 2019-07-12 at 19:35 +0200, Max Reitz wrote:
> > > Hi,
> > >=20
> > > Kevin commented on my RFC, so I got what an RFC wants, and he didn=E2=
=80=99t
> > > object to the creation fallback part.  So I suppose I can go down t=
hat
> > > route at least.  (Which was actually the more important part of the
> > > series.)
> > >=20
> > > So as in the RFC, this series adds a fallback path for creating fil=
es
> > > (on the protocol layer) if the protocol driver does not support fil=
e
> > > creation, but the file already exists.
> > >=20
> >=20
> > Hi!
> > Do you have any update on this patch series by a chance?
>=20
> Unfortunately, no.  I was on PTO, and before that, there was just too
> much else going on.  (And frankly, there=E2=80=99s still too much else =
going on.)

No problem!


Best regards,
	Maxim Levitsky


