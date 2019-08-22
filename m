Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A34FC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93055206B7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 16:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93055206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0pbz-0005sO-FU
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 12:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1i0pWW-0000tL-0k
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1i0pWT-00009N-UM
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 12:01:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34212)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1i0pWT-00008h-Oh; Thu, 22 Aug 2019 12:01:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 38FDB796FC;
 Thu, 22 Aug 2019 16:01:12 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71F12610C6;
 Thu, 22 Aug 2019 16:01:10 +0000 (UTC)
Date: Thu, 22 Aug 2019 18:01:07 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Message-ID: <20190822180107.062450ad.cohuck@redhat.com>
In-Reply-To: <20190822155513.GY3267@redhat.com>
References: <20190822174447.3be81c81.cohuck@redhat.com>
 <20190822155513.GY3267@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 22 Aug 2019 16:01:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] 'make check-unit' breakage on s390x host
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
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Aug 2019 16:55:13 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Thu, Aug 22, 2019 at 05:44:47PM +0200, Cornelia Huck wrote:
> > I just noticed a breakage with 'make check-unit' when running on an
> > s390x host (on my laptop, it runs fine; haven't tried other
> > architectures). This happens with current master, but I managed to
> > track the original breakage down to
> >=20
> > commit ff3dc8fefe953fd3650279e064bf63b212c5699a
> > Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Date:   Wed Mar 13 17:36:18 2019 +0000
> >=20
> >     filemon: ensure watch IDs are unique to QFileMonitor scope =20
>=20
> [snip]
>=20
> > I can try to collect extra info if you tell me what would be helpful. =
=20
>=20
> I'm betting you updated to kernel 5.3

Yeah, indeed... I would have been surprised if it were s390x-specific :)

>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg04349.html
>=20
> Just waiting for a Reviewed-by on that patch in order to send a PR....

I'll take a look, but can't promise anything (first time looking at
that code path...)

>=20
> Regards,
> Daniel


