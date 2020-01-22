Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45571C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 19:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D9924655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 19:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHVtPoXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D9924655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuLMX-0008EK-4w
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 14:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iuLLv-0007nT-K6
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 14:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iuLLu-0003JL-FR
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 14:07:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60997
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iuLLu-0003J2-Bp
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 14:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579720066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uA80p9UWUlXMQ4ViKABxamnob6bF4ALQ6YnD5m3DbUc=;
 b=QHVtPoXCGDKz0FbdDFwetczaP0HEZKX9guEbqfCULdj55ewP4Joe289RaOb3RTTNIG8DRp
 JRG//l8fEFcOT/HvDfoM+W2zjm1jvsWKSmKx8hSZI6Oo63pOvcnnis1wX9gcRYjSWPMkqc
 xStQT1h5poMtcvyx4h4CE+3365PokI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-EiZi17r7MFeDRLdf4PIO0g-1; Wed, 22 Jan 2020 14:07:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E29D8017CC;
 Wed, 22 Jan 2020 19:07:42 +0000 (UTC)
Received: from gondolin (ovpn-116-49.ams2.redhat.com [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 417AA60C84;
 Wed, 22 Jan 2020 19:07:41 +0000 (UTC)
Date: Wed, 22 Jan 2020 20:07:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Subject: Re: Maintainers, please add Message-Id: when merging patches
Message-ID: <20200122200738.7be66e3e.cohuck@redhat.com>
In-Reply-To: <87k15jz5e8.fsf@linaro.org>
References: <CAJSP0QX22cYJvnpb+zDDXLaYg0yY4CV3Jn5QY+ExxJyFcmQ3Gw@mail.gmail.com>
 <87v9p3znas.fsf@linaro.org>
 <9ac75d71-731d-a9d8-4ba6-f394077c4d96@redhat.com>
 <87k15jz5e8.fsf@linaro.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: EiZi17r7MFeDRLdf4PIO0g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 Jan 2020 18:56:47 +0000
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:

> Laszlo Ersek <lersek@redhat.com> writes:
>=20
> > On 01/22/20 13:30, Alex Benn=C3=A9e wrote: =20
> >>=20
> >> Stefan Hajnoczi <stefanha@gmail.com> writes:
> >>  =20
> >>> Around 66% of qemu.git commits since v4.1.0 include a Message-Id: tag=
.  Hooray!
> >>>
> >>> Message-Id: references the patch email that a commit was merged from.
> >>> This information is helpful to anyone wishing to refer back to email
> >>> discussions and patch series. =20
> >>=20
> >> So I guess the ones that don't are maintainer originated patches unles=
s
> >> you actively rebuild your trees from a posted series? =20
> >
> > I *think* this should not be a huge problem process wise:
> >
> > Assuming that a maintainer does not include their own patches in a PULL
> > request for Peter until the same patches receive R-b/A-b/T-b feedback
> > from other list subscribers, the maintainer will want to rebase the
> > patches at least once anyway, in order to pick up those lines. =20
>=20
> Oh I always do a re-base as I apply the r-b/t-b tags. But that is
> working off my tree and a bunch of references to the emails with the
> appropriate tags in them.
>=20
> So which Message-Id should I use. The first time the patch was posted to
> the list or the last time it was?

From the last one? I mean, I'll pick the last incarnation if I apply
someone else's patches, as well?

[I just add the id right before I send my 'queued' email.]


