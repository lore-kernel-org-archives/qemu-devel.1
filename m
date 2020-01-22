Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77143C33CAF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4546A2253D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1j1h4Nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4546A2253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGR5-0003X4-JJ
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 08:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iuGQR-0002y5-Vw
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iuGQQ-00049h-RX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:52:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29391
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iuGQQ-000498-NW
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579701125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wajuKYy1J7z7UHJ58CB4lnc1SfD6TBjFP6mCE7WNKS8=;
 b=S1j1h4NfZCjfwG+EqpQoWuGtdP2GuBoGRB3H2qOHfdtK/GfWfFyVi1I+GvdVt+cMZOk4CD
 6+MPSBvP4asxo4DlxsnKkSxgivX7voWXDnVsRpmXCRqCAKDorbmaHQbxv1GIgKGHpsdMOk
 zJITcwUQyzCP9uqmYyc0KTfO1Q5WR7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-8SdSA4PrOYKKwDHJOoS4pw-1; Wed, 22 Jan 2020 08:52:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84562100550E;
 Wed, 22 Jan 2020 13:52:00 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7C4B5C28C;
 Wed, 22 Jan 2020 13:51:59 +0000 (UTC)
Date: Wed, 22 Jan 2020 14:51:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Subject: Re: Maintainers, please add Message-Id: when merging patches
Message-ID: <20200122145157.0db870e3.cohuck@redhat.com>
In-Reply-To: <87v9p3znas.fsf@linaro.org>
References: <CAJSP0QX22cYJvnpb+zDDXLaYg0yY4CV3Jn5QY+ExxJyFcmQ3Gw@mail.gmail.com>
 <87v9p3znas.fsf@linaro.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 8SdSA4PrOYKKwDHJOoS4pw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jan 2020 12:30:03 +0000
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
> > Around 66% of qemu.git commits since v4.1.0 include a Message-Id: tag. =
 Hooray!
> >
> > Message-Id: references the patch email that a commit was merged from.
> > This information is helpful to anyone wishing to refer back to email
> > discussions and patch series. =20
>=20
> So I guess the ones that don't are maintainer originated patches unless
> you actively rebuild your trees from a posted series?

I usually paste in the message id by hand in that case (unless I
forget), which is a bit of a PITA; but so would be re-applying the sent
out patches...

One thing that probably won't have a message id is s390-ccw bios
rebuild patches, because sending that out for extra review just does
not make sense.

>=20
> >
> > Please use git-am(1) -m/--message-id or set am.messageid in your git-co=
nfig(1).
> >
> > If you use the patches tool (https://github.com/stefanha/patches) then
> > Message-Id: is added automatically.
> >
> > Thanks,
> > Stefan =20
>=20
>=20


