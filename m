Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8B0C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2732053B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOirjhdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2732053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZFHQ-0004SR-Ou
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 09:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49558)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iZFFf-0002mk-36
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iZFEt-0001TY-CC
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:21:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iZFEt-0001TQ-8U
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574691678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvG9dAfbYcPi1PVIb16vlqJVhwjXdp1y4DGiD+nAYz0=;
 b=fOirjhdkTHeCEkrvWmx1rqF7usnyQR70U9rOSU65ffGiTXIIJsZCcD3FxEn2MlQ2L0lRI2
 oKDuw4qIgMnUw42ULfky5uOYYdeWor1IHOM29BfXswpqAKMAhRCk1e8RFUmdxIj3eXgaMu
 BbDZ5r4UB+0Sc4lkbK0AQ7dAOxN6/cY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-F1iyCvjEOMmePuOr28ZEcg-1; Mon, 25 Nov 2019 09:21:16 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEEAE8C5F9F;
 Mon, 25 Nov 2019 14:21:14 +0000 (UTC)
Received: from localhost (ovpn-116-101.gru2.redhat.com [10.97.116.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CFD7600C6;
 Mon, 25 Nov 2019 14:21:12 +0000 (UTC)
Date: Mon, 25 Nov 2019 11:21:10 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Kashyap Chamarthy <kchamart@redhat.com>
Subject: Re: [PATCH for-4.2 2/2] i386: Add -noTSX aliases for hle=off, rtm=off
 CPU models
Message-ID: <20191125142110.GK4438@habkost.net>
References: <20191120164912.32384-1-ehabkost@redhat.com>
 <20191120164912.32384-3-ehabkost@redhat.com>
 <20191121141245.GR7032@paraplu>
MIME-Version: 1.0
In-Reply-To: <20191121141245.GR7032@paraplu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: F1iyCvjEOMmePuOr28ZEcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 21, 2019 at 03:12:45PM +0100, Kashyap Chamarthy wrote:
> On Wed, Nov 20, 2019 at 01:49:12PM -0300, Eduardo Habkost wrote:
> > We have been trying to avoid adding new aliases for CPU model
> > versions, but in the case of changes in defaults introduced by
> > the TAA mitigation patches, the aliases might help avoid user
> > confusion when applying host software updates.
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>=20
> Tested-by: Kashyap Chamarthy <kchamart@redhat.com>
>=20
>     https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg03501.html

Thanks!

>=20
>             - - -
>=20
> Should we (can do it, if you already don't have a patch WIP for it)
> also update this file to reflect this?
> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/qemu-cpu-models.texi

Yes, we should.  Thanks for the reminder!

>=20
> While at it ... I wonder if it's worth making a separte doc
> (versioned-cpu-models.rst) explaining the versioned CPU models, usage,
> etc.
>=20
> There was a very useful discussion between you and Dan Berrang=E9 on this
> list (Message-Id: <20190625050008.12789-5-ehabkost@redhat.com>, the
> first version of the thread: "[PATCH 4/6] i386: Infrastructure for
> versioned CPU models").  Could potentially incorporate some of that
> content.
>=20

We should, but I don't think I can do it in time for QEMU 4.2.

> > ---
> >  target/i386/cpu.c | 5 +++++
> >  1 file changed, 5 insertions(+)
>=20
> [...]
>=20
> --=20
> /kashyap

--=20
Eduardo


