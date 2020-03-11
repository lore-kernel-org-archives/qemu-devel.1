Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D81C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B048D20848
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JC9CFs5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B048D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jByBz-0008DR-UD
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 06:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jByBK-0007iV-HA
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jByBI-0000x9-6l
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:01:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jByBH-0000vs-VO
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583920899;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3KEuok8FqRoxwP9tztop5a1gyhx6fUXr3cUu91D9wTs=;
 b=JC9CFs5BbPszFNl8GB/DUczpehNOf7IpYXMxhHAFo3v9j8L528VCpHMOJ7zX79o6vjy1vY
 Czplj3k8p6/PEOxKlY6lJJuC1TERDYEctBM3I9/vIx2Y3uqJlBVSL3j7FZneog8ZCK2oQc
 w8czOR0KBCFIesIgSvuq5fBgOtCIP4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-qGM3xAj_Mai2gjkiX6MHPQ-1; Wed, 11 Mar 2020 06:01:37 -0400
X-MC-Unique: qGM3xAj_Mai2gjkiX6MHPQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DEB3800D48;
 Wed, 11 Mar 2020 10:01:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AD81100164D;
 Wed, 11 Mar 2020 10:01:29 +0000 (UTC)
Date: Wed, 11 Mar 2020 10:01:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Upstream QEMU guest support policy ? Re: [PATCH v3 0/2] spapr:
 Use vIOMMU translation for virtio by default
Message-ID: <20200311100127.GC3614859@redhat.com>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200310114343.GD3234052@redhat.com>
 <20200311011247.GT660117@umbus.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200311011247.GT660117@umbus.fritz.box>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: pair@us.ibm.com, mst@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 groug@kaod.org, paulus@samba.org, clg@kaod.org, mdroth@us.ibm.com,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 12:12:47PM +1100, David Gibson wrote:
> On Tue, Mar 10, 2020 at 11:43:43AM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Mar 05, 2020 at 03:30:07PM +1100, David Gibson wrote:
> > > Upcoming Secure VM support for pSeries machines introduces some
> > > complications for virtio, since the transfer buffers need to be
> > > explicitly shared so that the hypervisor can access them.
> > >=20
> > > While it's not strictly speaking dependent on it, the fact that virti=
o
> > > devices bypass normal platform IOMMU translation complicates the issu=
e
> > > on the guest side.  Since there are some significan downsides to
> > > bypassing the vIOMMU anyway, let's just disable that.
> > >=20
> > > There's already a flag to do this in virtio, just turn it on by
> > > default for forthcoming pseries machine types.
> >=20
> > Breaking existing guest OS to support a new secure VM feature that
> > may not even be used/wanted doesn't seems like a sensible tradeoff
> > for default out of the box behaviour.
> >=20
> > IOW, if Secure VM needs this, can we tie the change in virtio and
> > IOMMU defaults to the machine type flag that enables the use of
> > Secure VM.
>=20
> There is no such flag.
>=20
> In the POWER secure VM model, the secure mode option isn't something
> that's constructed in when the hypervisor builds the VM.  Instead the
> VM is started normally and transitions itself to secure mode by
> talking directly with the ultravisor (it then uses TPM shenannigans to
> safely get the keys to its real storage backend(s)).

This is pretty suprising to me. The ability to use secure VM mode surely
depends on host hardware features. We would need to be able to block the
use of this, in order to allow VMs to be live migrated to hosts which
lack the feature. Automatically & silently enabling a feature that
has a hardware dependancy is something we aim to avoid, unless the user
has opted in via some flag (such as -cpu host, or a -cpu $NAME, that
implies the feature).

> > > Any opinions on whether dropping support for the older guest kernels
> > > is acceptable at this point?
> >=20
> >=20
> > I think this question has different answers depending on whether you
> > are considering downstream vendor policy, current upstream policy,
> > and a possible new downstream policy on guest support. IOW a bit of a
> > can of worms...
> >=20
> >=20
> > In the case of RHEL downstream there is a very narrow matrix for
> > what guest OS are considered supported.
> >=20
> > In the case of current upstream, there has essentially never been
> > any documented guest matrix. The unwritten implicit rule upstream
> > has followed is to not change defaults in a way that would break
> > ability to run existing guest OS.
>=20
> Hrm, ok, that's not how I've been treating it for for pseries, though
> previous breakages have been for much older / rarer cases.  We broke
> support for guests that don't call "ibm,client-architecture-support"
> long, long ago (but such guests are really, really ancient).  We broke
> support (without workarounds) for guests with 4kiB standard page size
> more recently, but those are at least a decade old for common
> downstream distros (you can build such kernels today, but
> approximately nobody does).
>=20
> > As an example, on x86 upstream defaults to i440fx and thus still
> > uses virtio devices in transitional mode by default, while downstream
> > RHEL used its narrow support matrix as a justification for why it was
> > ok to switch to q35 by default & loose guest support in many cases.
> > Even that was problematic though, because RHEL still needed to support
> > RHEL-6 guest which are broken by default with q35 since they only
> > support legacy mode virtio. Thus we needed work in management apps
> > to enable RHEL-6 to continue working with q35 chipset, by placing
> > the devices onto a PCI bridge, instead of a PCIe root port, or by
> > explicitly using i440fx instead.
>=20
> Yeah, and here's where x86's visibility with mgmt because a big
> thing.  Most of these changes are easily enough worked around with
> machine type options - and there's no inherent reason those are harder
> to work with than whole machine types, or other config details.  But
> getting mgmt apps to support machine option based workarounds for us
> is a real challenge.
>=20
> > Thus if we follow our *current* upstream guest support policy, I don't
> > think it is acceptable to break existing guests with the new machine
> > type upstream.  It is reasonable to do it downstream if the downstream
> > is willing to sacrifice these guests, or invest to make any mgmt apps=
=20
> > add workaround/revert QEMU changes.
> >=20
> >=20
> > With that all said, I do *NOT* think current upstream practice is good
> > or sustainable long term (though I admit I've argued on the other side
> > in the past).
> >=20
> > This policy is why we're still using a machine designed in 1995 on x86
> > by default, in order that we avoid breaking the popular guest OS of the
> > day, like Windows 95.
> >=20
> > This is similar to the problem we had with host build platforms, where
> > we afraid to make any change which would break an existing build platfo=
rm,
> > or on the flipside made arbitrary ad-hoc changes with no consistent
> > approach across different subsystems.
> >=20
> >=20
> > I think that we should aim define some clearer policy around how we
> > want to support guest OS in upstream. As we did with our host build
> > platforms policy, any guest support policy should aim to move forward
> > at a reasonable pace so that we are not locked at a specific point in
> > time forever.
> >=20
> > I can imagine three tiers
> >=20
> >  1. Recommended. Expected to work well with machine type defaults
> >  2. Supported. Should work with QEMU but may need special settings appl=
ied
> >  3. Unsupported. Will not work with QEMU regardless of settings
> >=20
> > I don't have an opinion right now on what guest OS should fall in which
> > category. One possible way to classify them would be to look at whether
> > the vendor themselves still supported the OS.  IOW, to be in the
> > "Recommended" criteria, it must be actively supported by the vendor.
> > Once EOL by the vendor it would be capped at the "Supported" tier.
> >=20
> > That definition wouldn't help your pseries issue though, because RHEL-6
> > is still considered a supported OS.
> >=20
> > Another possible way to classify guest OS would be to look purely at
> > the original release date, and set a cap of "$TODAY - 5 years" for
> > the "Recommended" tier. That would exclude RHEL-6.
>=20
> That seems fairly reasonable to me, but it doesn't really help me move
> forward right now.  Right now, we have no sane way of distinguishing
> early enough between a RHEL-6 guest that needs legacy virtio and a
> guest that wants to go to secure mode, and can't have legacy virtio. :(

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


