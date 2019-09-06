Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B485C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 11:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AFF4206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 11:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AFF4206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6CBe-0001v2-4W
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 07:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i6CAY-0001Qh-V0
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i6CAX-0005gS-GT
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:12:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i6CAX-0005g8-B0
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 07:12:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 698B972659;
 Fri,  6 Sep 2019 11:12:44 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F8FC60E1C;
 Fri,  6 Sep 2019 11:12:25 +0000 (UTC)
Date: Fri, 6 Sep 2019 12:12:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190906111223.GD2699@work-vm>
References: <20190905152136.30637-1-stefanha@redhat.com>
 <20190905152136.30637-3-stefanha@redhat.com>
 <20190905172732.GQ2700@work-vm>
 <20190906102328.GE5900@stefanha-x1.localdomain>
 <20190906104953.GV5119@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190906104953.GV5119@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 06 Sep 2019 11:12:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 2/3] virtiofsd: add DBus server to handle log
 level changes
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
Cc: virtio-fs@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eryu Guan <eguan@linux.alibaba.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Fri, Sep 06, 2019 at 11:23:28AM +0100, Stefan Hajnoczi wrote:
> > On Thu, Sep 05, 2019 at 06:27:32PM +0100, Dr. David Alan Gilbert wrot=
e:
> > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > Introduce a DBus server thread that runs alongside the other virt=
iofsd
> > > > threads.  It processes changes to the /org/qemu/virtiofsd object =
which
> > > > can be accessed at the org.qemu.virtiofsd location on the bus.
> > > >=20
> > > > This code does not use locking because we are the only writer to =
the
> > > > int current_log_level variable.  More advanced management command=
s would
> > > > require locking to prevent race conditions with the other threads=
.
> > > >=20
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > >=20
> > > OK, that is less complex than I'd feared.
> > > I guess there's something probably nice to do with name/integer map=
ping
> > > for warning levels that we could use from one of the libraries.
> >=20
> > I used a free-form string because it's what systemd's LogLevel proper=
ty
> > also does.  But I can investigate the cleanest approach for limiting =
it
> > to a set of string constants.
>=20
> There's no concept of "enums" at the DBus protocol level. Sending enums
> in string form is the normal practice - avoiding integer values means
> you are not vulnerable to enum values changing if someone inserts a new
> constant in the middlle of the enum. This same reason is why QAPI uses
> strings for enums instead of ints.

Oh, I wasn't talking aobut changing protocol; I just meant there was
probably a neater way of doing the string look up than the opencoded way
it was done.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

