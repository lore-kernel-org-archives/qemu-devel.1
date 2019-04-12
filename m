Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F194C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 08:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49772083E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 08:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49772083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hErLh-0000rS-4G
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 04:15:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hErKY-00005K-Mg
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hErKX-000530-Et
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:14:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hErKX-00051n-6r; Fri, 12 Apr 2019 04:14:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BE0C86663;
	Fri, 12 Apr 2019 08:14:36 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB5795C207;
	Fri, 12 Apr 2019 08:14:32 +0000 (UTC)
Date: Fri, 12 Apr 2019 10:14:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Message-ID: <20190412101430.05c80db5.cohuck@redhat.com>
In-Reply-To: <571b9f8c-cfb0-704e-ded4-8661a8136876@linux.ibm.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-2-cohuck@redhat.com>
	<9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
	<20190408190747.12e3618b.cohuck@redhat.com>
	<20190410013434.7cea1971@oc2783563651>
	<4a692c11-edb2-93f9-7d8e-96a73a7ecdae@linux.ibm.com>
	<571b9f8c-cfb0-704e-ded4-8661a8136876@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Fri, 12 Apr 2019 08:14:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 1/6] vfio-ccw: make it safe to access
 channel programs
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
Cc: linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
	kvm@vger.kernel.org, qemu-s390x@nongnu.org,
	Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
	Halil Pasic <pasic@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412081430.Ai_Db-CAcp0oT-q8xCUMcjp4Us_IEGF4XTVH2Qrvxoo@z>

On Thu, 11 Apr 2019 17:27:42 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 4/10/19 10:59 PM, Eric Farman wrote:
> >=20
> >=20
> > On 4/9/19 7:34 PM, Halil Pasic wrote: =20
> >> On Mon, 8 Apr 2019 19:07:47 +0200 =20
>=20
> ...snip...
>=20
> >> I'm just running fio on a pass-through DASD and on some virto-blk disks
> >> in parallel. My QEMU is today's vfio-ccw-caps from your repo.
> >>
> >> I see stuff like this:
> >> qemu-git: vfio-ccw: wirte I/O region failed with errno=3D16[1811/7332/=
0=20
> >> iops] [eta 26m:34s] =20
> >=20
> > Without knowing what the I/O was that failed, this is a guessing game.=
=20
> > But I encountered something similar just now running fio.
> >=20
> > qemu:
> > 2019-04-11T02:06:09.524838Z qemu-system-s390x: vfio-ccw: wirte I/O=20
> > region failed with errno=3D16 =20
>=20
> ...snip...
>=20
> >  From the associated I/O, I think this is fixed by a series I am nearly=
=20
> > ready to send for review.=C2=A0 I'll try again with those fixes on top =
of the=20
> > two series here, and report back. =20
>=20
> So, I've run enough combinations to feel comfortable saying that the=20
> error (EBUSY) I saw last night (and presumably the one Halil saw) exists=
=20
> in today's code and is not introduced by this series.  It also appears=20
> to be addressed by one of the patches in a series I'm working on, but=20
> which that series still has some further problems.  Sigh, there are too=20
> many branches and too many interrupts.

Great, thanks for checking! I know that feeling of being tangled in too
many branches...

