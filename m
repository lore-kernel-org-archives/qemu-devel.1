Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE6BCA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A45A20684
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 15:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kh2ku6Kl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A45A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO1Fc-0000DE-2e
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 11:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iO158-0002s1-Mk
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iO156-0004An-QE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:00:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28918
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iO156-0004AT-LI
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 11:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572015648;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jflf4mp/rscKKK6BrMZh6LnHqC3coJcf/hLn6c8H8Vo=;
 b=Kh2ku6KlYq67/db4sH6zKBlvaFBc3A2yhS1f5nXN2k/KkY9WV5GdUljSk1fvqYLKL40sYE
 gMT3wPxVpvRZk3/njqXmEX9Vp/aC9W4PeAgBiCklrBTQU3CkMOyq8+rGO29mrls0dmILBh
 t4OcMDY+WE+nEebZ5AQIxpknJ9HwIXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-D5-18b-yMZ2xcBFa5ck71Q-1; Fri, 25 Oct 2019 11:00:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6031C5E6;
 Fri, 25 Oct 2019 15:00:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50BA35C1B5;
 Fri, 25 Oct 2019 15:00:42 +0000 (UTC)
Date: Fri, 25 Oct 2019 16:00:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 0/7] i386: Add `machine` parameter to query-cpu-definitions
Message-ID: <20191025150040.GC3581@redhat.com>
References: <20191025022553.25298-1-ehabkost@redhat.com>
 <dbf9e4c1-0acf-9469-84f9-f80c41e2cae0@redhat.com>
 <6e7d171e-18c4-6835-f89c-e9e66c093d62@de.ibm.com>
 <4cd530f9-54f3-80e7-1b66-c91f71160062@redhat.com>
 <20191025140310.GB3581@redhat.com>
 <7a29438c-572d-5a26-a14f-717a177af4d1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7a29438c-572d-5a26-a14f-717a177af4d1@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: D5-18b-yMZ2xcBFa5ck71Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 04:23:59PM +0200, David Hildenbrand wrote:
> > > > For example
> > > > -machine s390-virtio-ccw-3.1 -cpu z14 will not have the multiple ep=
och facility
> > > > and
> > > > -machine s390-virtio-ccw-4.0 -cpu z14 will have the multiple epoch =
facility.
> > > > As migration does always require the tuple of machine and cpu this =
is save. I fail
> > > > to see what the benefit of an explicit z14-3.1 would be.
> > > >=20
> > >=20
> > > AFAIKS the only real benefit of versioned CPU models is that you can =
add new
> > > CPU model versions without new QEMU version.
> >=20
> > This is very important for backporting CPU security fixes to existing Q=
EMU
> > releases.
>=20
> I'd say it's not really relevant for backporting per se. It's relevant fo=
r
> automatically enabling security fixes when not using the host model. That
> part I understand. Less likely to make mistakes when explicitly specifyin=
g
> CPU models.
>=20
> I once was told that if a user actually specified an explicit CPU model i=
n
> the libvirt XML ("haswell-whatever"), you should not go ahead and make an=
y
> later changes to that model (guest ABI should not change when you
> update/restart the guest ...). So this only applies when creating new
> guests? Or will you change existing model definitions implicitly?

Libvirt will only ever expand a bare CPU model at time it first parses
the XML. So if a mgmt app defines a new persistent guest in libvirt, the
CPU is expanded them and remains unchanged thereafter, in order to preserve
ABI compat.

If using transient guests its different as libvirt doesn't store the config
in disk when the guest isn't running. So mgmt apps using transient guests
are responsible  for picking a explicit versioned model themselves if they
need stable ABI.

> > > Then you can specify "-cpu z13-vX" or "-cpu z13 -cpuv X" (no idea how
> > > versioned CPU model were implemented) on any QEMU machine. Which is t=
he same
> > > as telling your customer "please use z13,featX=3Don" in case you have=
 a good
> > > reason to not use the host model (along with baselining) but use an e=
xplicit
> > > model.
> > >=20
> > > If you can change the default model of QEMU machines, you can automat=
e this
> > > process. I am pretty sure this is a corner case, though (e.g., IBRS).
> > > Usually you have a new QEMU machine and can simply enable the new fea=
ture
> > > from that point on.
> >=20
> > There are now 4 Haswell variants, only some of which are runnable
> > on any given host, depending on what microcode the user has installed
> > or what particular Haswell silicon SKU the user purchased. Given the
> > frequency of new CPU flaws arrived since the first Meltdown/Spectre,
> > this isn't a corner case, at least for the x86 world & Intel in
> > particular. Other arches/vendors haven't been quite so badly affected
> > in this way.
>=20
> On s390x you can assume that such firmware/microcode updates will be on a=
ny
> machine after some time. That is a big difference to x86-64 AFAIK.

I don't know s390x much, but can we really assume that users promptly
install firmware updates, any better than users do for x86 or other
arch. IME corporate beaurcracy can drag out time to update arbitrarily
long.

> > If we tied each new Haswell variant to a machine type, then users would
> > be blocked from consuming a new machine type depending on runnability o=
f
> > the CPU model. This is not at all desirable, as mgmt apps now have comp=
lex
> > rules on what machine type they can use.
>=20
> So you actually want different CPU variants, which you have already, just=
 in
> a different form. (e.g., "haswell" will be mapped to "haswell-whatever",
> just differently via versions)

Yes, you can think of "Haswell", "Haswell-noTSX", "Haswell-noTSX-IBRS"
as all being versions of the same thing. There was never any explicit
association or naming though. So what's changing is that we're defining
a sane naming scheme for the variants of each model so we don't end
up with   "Haswell-noTSX-IBRS-SSBD-MDS-WHATEVER-NEXT-INTEL-FLAW-IS",
and we declaring that a bare "Haswell" will expand to some "best"
version depending on machine type (but also selectable by mgmt app
above).

> > Both these called for making CPU versioning independant of machine
> > type versioning.
> >=20
> > Essentially the goal with CPU versioning is that the user can request
> > a bare "Haswell" and libvirt (or the mgmt app) will automatically
> > expand this to the best Haswell version that the host is able to
> > support with its CPUs / microcode / BIOS config combination.
>=20
>=20
> So if I do a "-cpu haswell -M whatever-machine", as far as I understood
> reading this,  I get the "default CPU model alias for that QEMU machine" =
and
> *not* the "best Haswell version that the host is able to support".
>=20
> Or does the default actually also depend on the current host?

At the QEMU level "haswell" will expand to a particular CPU version
per machine type. So yes, at the QEMU level machine types might have
a dependancy on the host.

Above QEMU though, libvirt/mgmt apps can be more dynamic in how they
expand a bare "haswell" to take account of what the host supports.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


