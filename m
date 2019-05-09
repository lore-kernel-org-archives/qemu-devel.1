Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A88EC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5FC20644
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 14:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5FC20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56027 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOkSx-0002OZ-2S
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 10:56:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOkRh-0001gQ-Ja
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hOkRg-0000Et-IU
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:54:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hOkRg-0000Ee-Cu
	for qemu-devel@nongnu.org; Thu, 09 May 2019 10:54:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AABF7753FC;
	Thu,  9 May 2019 14:54:51 +0000 (UTC)
Received: from redhat.com (ovpn-112-55.ams2.redhat.com [10.36.112.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EC596600CC;
	Thu,  9 May 2019 14:54:49 +0000 (UTC)
Date: Thu, 9 May 2019 15:54:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190509145447.GG31299@redhat.com>
References: <20190503154613.4192-1-kchamart@redhat.com>
	<20190509135320.GE17133@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509135320.GE17133@stefanha-x1.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 09 May 2019 14:54:51 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, rjones@redhat.com, amit@kernel.org,
	armbru@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 09, 2019 at 02:53:20PM +0100, Stefan Hajnoczi wrote:
> On Fri, May 03, 2019 at 05:46:12PM +0200, Kashyap Chamarthy wrote:
> > When QEMU exposes a VirtIO-RNG device to the guest, that device needs=
 a
> > source of entropy, and that source needs to be "non-blocking", like
> > `/dev/urandom`.  However, currently QEMU defaults to the problematic
> > `/dev/random`, which is "blocking" (as in, it waits until sufficient
> > entropy is available).
> >=20
> > So change the entropy source to the recommended `/dev/urandom`.
>=20
> Why is /dev/urandom "recommended"?
>=20
> I understand the requirement for instant random numbers, but what about
> the concerns about quality?  Have you decided that the consumers of
> these random numbers are safe with /dev/urandom?

The current random(4) man page says:

       The /dev/random interface is considered a legacy inter=E2=80=90
       face, and /dev/urandom is preferred and  sufficient  in
       all use cases, with the exception of applications which
       require randomness during early boot  time;  for  these
       applications,   getrandom(2)   must  be  used  instead,
       because it will block until the entropy  pool  is  ini=E2=80=90
       tialized.

"early boot" is a bit of an ill-defined term here, but I think in
general QEMU can reasonably be said to not be running in early boot.

In any case the newly proposed RNG backend should ultimately become
the preferred choice for mgmt apps:

  https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg02062.html

This new rng-builtin delegates to our crypto random APIs, which are
backed by GNUTLS, libgcrypt, getrandom (or Windows equiv), and
finally /dev/urandom as last ditch effort.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

