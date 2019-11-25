Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE31C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 17:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B18720679
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 17:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0mlcxmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B18720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZHwY-00007A-5l
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 12:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1iZHp6-0005wq-I1
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1iZHp0-0007RQ-OI
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:06:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41935
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1iZHp0-0007NK-IN
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574701605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dv3jdpJA9AJGb1x0LWKZdU8Jb8QOqhxUv2NxdRAVPfI=;
 b=W0mlcxmtjPhFq7N83tgxXgBIZUrCrqADS4rm1Zv0feEe4MVdUUO3CK2qj/eV+zxOTxJrY0
 Y274YknRKjGFsPgEUwViRPYdiQEQ7zHJHddMAggNrHBfFgMqO4j8s9eqbj0X5NvgfN8Ysf
 56VNtREwqA54yZ2LM9jGfbcG6at9K3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-a1t_UfxePP2yrVvhrfP9-w-1; Mon, 25 Nov 2019 12:06:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2487380058F;
 Mon, 25 Nov 2019 17:06:41 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-195.ams2.redhat.com
 [10.36.117.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB1C9600C6;
 Mon, 25 Nov 2019 17:06:40 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id A6E553E23F9; Mon, 25 Nov 2019 18:06:38 +0100 (CET)
Date: Mon, 25 Nov 2019 18:06:38 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH for-4.2 2/2] i386: Add -noTSX aliases for hle=off, rtm=off
 CPU models
Message-ID: <20191125170638.GZ7032@paraplu>
References: <20191120164912.32384-1-ehabkost@redhat.com>
 <20191120164912.32384-3-ehabkost@redhat.com>
 <20191121141245.GR7032@paraplu> <20191125142110.GK4438@habkost.net>
MIME-Version: 1.0
In-Reply-To: <20191125142110.GK4438@habkost.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: a1t_UfxePP2yrVvhrfP9-w-1
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

On Mon, Nov 25, 2019 at 11:21:10AM -0300, Eduardo Habkost wrote:
> On Thu, Nov 21, 2019 at 03:12:45PM +0100, Kashyap Chamarthy wrote:
> > On Wed, Nov 20, 2019 at 01:49:12PM -0300, Eduardo Habkost wrote:

[...]

> >             - - -
> >=20
> > Should we (can do it, if you already don't have a patch WIP for it)
> > also update this file to reflect this?
> > https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Ddocs/qemu-cpu-models.te=
xi
>=20
> Yes, we should.  Thanks for the reminder!
>=20
> >=20
> > While at it ... I wonder if it's worth making a separte doc
> > (versioned-cpu-models.rst) explaining the versioned CPU models, usage,
> > etc.
> >=20
> > There was a very useful discussion between you and Dan Berrang=E9 on th=
is
> > list (Message-Id: <20190625050008.12789-5-ehabkost@redhat.com>, the
> > first version of the thread: "[PATCH 4/6] i386: Infrastructure for
> > versioned CPU models").  Could potentially incorporate some of that
> > content.
> >=20
>=20
> We should, but I don't think I can do it in time for QEMU 4.2.

It's okay; that can wait for post-4.2.

[...]

--=20
/kashyap


