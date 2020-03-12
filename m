Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7D9C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD8C20735
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 09:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJECxjS0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD8C20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCKSh-0002NP-Lb
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 05:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jCKS4-0001qu-Jd
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jCKS2-0004J5-DV
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:48:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24663
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jCKS2-0004GU-4n
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 05:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584006504;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U3RKS+DaVgYvU07VWRj73NpfZRT38EgKbPDYE5P8lkM=;
 b=TJECxjS0r9AzLQfSTbUxsGaSJwq9Y7l7iWoTpegBL594zw8oGm+lwoPrDvA04AOphV6V/U
 6yaKKjVbuVFA8WGbzfDy55S9pnvH/9xZBVeHjTN4i1B6p4PXxwAKOi2JDanY6mqBkbTNK9
 9eYeppGXr26pieSuBRI/i6MRGpaVb1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-_Jt4NFavMfSpiVKABE8gsg-1; Thu, 12 Mar 2020 05:47:56 -0400
X-MC-Unique: _Jt4NFavMfSpiVKABE8gsg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBA8C800D5A;
 Thu, 12 Mar 2020 09:47:54 +0000 (UTC)
Received: from redhat.com (ovpn-112-64.ams2.redhat.com [10.36.112.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 310938AC34;
 Thu, 12 Mar 2020 09:47:48 +0000 (UTC)
Date: Thu, 12 Mar 2020 09:47:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Upstream QEMU guest support policy ? Re: [PATCH v3 0/2] spapr:
 Use vIOMMU translation for virtio by default
Message-ID: <20200312094746.GA4089516@redhat.com>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
 <20200310114343.GD3234052@redhat.com>
 <20200311011247.GT660117@umbus.fritz.box>
 <20200311100127.GC3614859@redhat.com>
 <20200312010847.GA711223@umbus.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200312010847.GA711223@umbus.fritz.box>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Thu, Mar 12, 2020 at 12:08:47PM +1100, David Gibson wrote:
> On Wed, Mar 11, 2020 at 10:01:27AM +0000, Daniel P. Berrang=C3=A9 wrote:
> 65;5803;1c> On Wed, Mar 11, 2020 at 12:12:47PM +1100, David Gibson wrote:
> > > On Tue, Mar 10, 2020 at 11:43:43AM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> > > > On Thu, Mar 05, 2020 at 03:30:07PM +1100, David Gibson wrote:
> > > > > Upcoming Secure VM support for pSeries machines introduces some
> > > > > complications for virtio, since the transfer buffers need to be
> > > > > explicitly shared so that the hypervisor can access them.
> > > > >=20
> > > > > While it's not strictly speaking dependent on it, the fact that v=
irtio
> > > > > devices bypass normal platform IOMMU translation complicates the =
issue
> > > > > on the guest side.  Since there are some significan downsides to
> > > > > bypassing the vIOMMU anyway, let's just disable that.
> > > > >=20
> > > > > There's already a flag to do this in virtio, just turn it on by
> > > > > default for forthcoming pseries machine types.
> > > >=20
> > > > Breaking existing guest OS to support a new secure VM feature that
> > > > may not even be used/wanted doesn't seems like a sensible tradeoff
> > > > for default out of the box behaviour.
> > > >=20
> > > > IOW, if Secure VM needs this, can we tie the change in virtio and
> > > > IOMMU defaults to the machine type flag that enables the use of
> > > > Secure VM.
> > >=20
> > > There is no such flag.
> > >=20
> > > In the POWER secure VM model, the secure mode option isn't something
> > > that's constructed in when the hypervisor builds the VM.  Instead the
> > > VM is started normally and transitions itself to secure mode by
> > > talking directly with the ultravisor (it then uses TPM shenannigans t=
o
> > > safely get the keys to its real storage backend(s)).
> >=20
> > This is pretty suprising to me. The ability to use secure VM mode surel=
y
> > depends on host hardware features. We would need to be able to block th=
e
> > use of this, in order to allow VMs to be live migrated to hosts which
> > lack the feature. Automatically & silently enabling a feature that
> > has a hardware dependancy is something we aim to avoid, unless the user
> > has opted in via some flag (such as -cpu host, or a -cpu $NAME, that
> > implies the feature).
>=20
> That is an excellent point, which I had not previously considered.
>=20
> I have confirmed that there is indeed not, at present, a way to
> disable the secure transition.  But, it looks like it's not too late
> to fix it.
>=20
> I've discussed with Paul Mackerras, and early in the secure transition
> apparently the UV makes a call to the HV, which is allowed to fail.
>=20
> So, we're looking at adding another KVM capability for secure mode.
> It will default to disabled, and until it is explicitly enabled, KVM
> will always fail that call from the UV, effectively preventing guests
> from going into secure mode.
>=20
> We can then wire that up to a new spapr cap in qemu, which we can also
> use to configure these virtio defaults.

Great, that sounds viable to me.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


