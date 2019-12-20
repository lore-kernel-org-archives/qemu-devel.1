Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C4DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1012924679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcUt/im4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1012924679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiFRe-00019z-9N
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 05:23:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iiFQx-0000lF-MQ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iiFQv-0001bF-4L
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:22:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60068
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iiFQu-0001Uh-Oh
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576837375;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZTFa/rfxZNzy2DPW6od9so9VsNhQxbxBNFw+J8zMXlo=;
 b=GcUt/im4bHzE1+mE9sZO+0ihPEgaVpzj87nmqvqTbgGRSxrub/WJs/jtSkYU9n+TY6PJkl
 NnZYGK8BxHK1Q0TQzLLpLBe5N1N8jCZHcJSXqgi4DyTwqI3ZQfNr/muqZwN7JXDxhvEar+
 BliHsvk/M/HltGiLTcU/FwZNDgoolHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-bV5fq6eOM_CV6CmdvYZwVw-1; Fri, 20 Dec 2019 05:22:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CBD9800EB5;
 Fri, 20 Dec 2019 10:22:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F7875C1B2;
 Fri, 20 Dec 2019 10:22:38 +0000 (UTC)
Date: Fri, 20 Dec 2019 10:22:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20191220102237.GA1699760@redhat.com>
References: <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <DDE3DA62-31DD-437B-8392-CAD505253EED@nutanix.com>
 <20191219115545.GD1624084@stefanha-x1.localdomain>
 <772D9CF3-D15D-42D1-B9CF-1279619D7C20@nutanix.com>
 <20191219125504.GI1190276@redhat.com>
 <20191220094712.GA1635864@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191220094712.GA1635864@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: bV5fq6eOM_CV6CmdvYZwVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "fam@euphon.net" <fam@euphon.net>, Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Walker,
 Benjamin" <benjamin.walker@intel.com>, "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 09:47:12AM +0000, Stefan Hajnoczi wrote:
> On Thu, Dec 19, 2019 at 12:55:04PM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Dec 19, 2019 at 12:33:15PM +0000, Felipe Franciosi wrote:
> > > > On Dec 19, 2019, at 11:55 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
> > > > On Tue, Dec 17, 2019 at 10:57:17PM +0000, Felipe Franciosi wrote:
> > > >>> On Dec 17, 2019, at 5:33 PM, Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
> > > >>> On Mon, Dec 16, 2019 at 07:57:32PM +0000, Felipe Franciosi wrote:
> > > >>>>> On 16 Dec 2019, at 20:47, Elena Ufimtseva <elena.ufimtseva@orac=
le.com> wrote:
> > > >>>>> =EF=BB=BFOn Fri, Dec 13, 2019 at 10:41:16AM +0000, Stefan Hajno=
czi wrote:
> > > To be clear: I'm very happy to have a userspace-only option for this,
> > > I just don't want to ditch the kernel module (yet, anyway). :)
> >=20
> > If it doesn't create too large of a burden to support both, then I thin=
k
> > it is very desirable. IIUC, this is saying a kernel based solution as t=
he
> > optimized/optimal solution, and userspace UNIX socket based option as t=
he
> > generic "works everywhere" fallback solution.
>=20
> I'm slightly in favor of the kernel implementation because it keeps us
> better aligned with VFIO.  That means solving problems in one place only
> and less reinventing the wheel.
>=20
> Knowing that a userspace implementation is possible is a plus though.
> Maybe that option will become attractive in the future and someone will
> develop it.  In fact, a userspace implementation may be a cool Google
> Summer of Code project idea that I'd like to co-mentor.

If it is technically viable as an approach, then I think  we should be
treating a fully unprivileged muser-over-UNIX socket as a higher priority
than just "maybe a GSoC student will want todo it".

Libvirt is getting strong message from KubeVirt project that they want to
be running both libvirtd and QEMU fully unprivileged. This allows their
containers to be unprivileged. Anything that requires privileges requires
jumping through extra hoops writing custom code in KubeVirt to do things
outside libvirt in side loaded privileged containers and this limits how
where those features can be used.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


