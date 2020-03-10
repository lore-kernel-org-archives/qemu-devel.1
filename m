Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57128C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F54224655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPM0Zpwo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F54224655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdK3-0003eb-A9
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jBdIy-0002Qw-Ve
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jBdIx-0006fY-Fj
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:44:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20376
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jBdIx-0006eF-Bo
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583840651;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDnQavxU8gZN2w2F6zAw3ujNqTyugxHfhN4Hm+CvElc=;
 b=HPM0ZpwoD70Pw1FeOq7J5y0VjIhJgOgg7CxOgzsaMYmWrP5Lt51ozPzUAu5wlKRFox/ik4
 cCyHF+O6Z2fUdjZdtx8+uzd5GohIr2IgO77w3RxS27IgqQL9bvkOT/l2iexi1fDa+PgL2Z
 KCOpqE/vUMUqOx5e1sRLLV2mQZaGDy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-B2Hx4XoKN7m9wm4d3s_n8A-1; Tue, 10 Mar 2020 07:43:54 -0400
X-MC-Unique: B2Hx4XoKN7m9wm4d3s_n8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8F3D8017DF;
 Tue, 10 Mar 2020 11:43:52 +0000 (UTC)
Received: from redhat.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8DDD10013A1;
 Tue, 10 Mar 2020 11:43:46 +0000 (UTC)
Date: Tue, 10 Mar 2020 11:43:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Upstream QEMU guest support policy ? Re: [PATCH v3 0/2] spapr: Use
 vIOMMU translation for virtio by default
Message-ID: <20200310114343.GD3234052@redhat.com>
References: <20200305043009.611636-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
In-Reply-To: <20200305043009.611636-1-david@gibson.dropbear.id.au>
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
Cc: pair@us.ibm.com, mst@redhat.com, aik@ozlabs.ru, groug@kaod.org,
 qemu-devel@nongnu.org, paulus@samba.org, clg@kaod.org, mdroth@us.ibm.com,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 05, 2020 at 03:30:07PM +1100, David Gibson wrote:
> Upcoming Secure VM support for pSeries machines introduces some
> complications for virtio, since the transfer buffers need to be
> explicitly shared so that the hypervisor can access them.
>=20
> While it's not strictly speaking dependent on it, the fact that virtio
> devices bypass normal platform IOMMU translation complicates the issue
> on the guest side.  Since there are some significan downsides to
> bypassing the vIOMMU anyway, let's just disable that.
>=20
> There's already a flag to do this in virtio, just turn it on by
> default for forthcoming pseries machine types.

Breaking existing guest OS to support a new secure VM feature that
may not even be used/wanted doesn't seems like a sensible tradeoff
for default out of the box behaviour.

IOW, if Secure VM needs this, can we tie the change in virtio and
IOMMU defaults to the machine type flag that enables the use of
Secure VM.

That way the changed virtio defaults only take effect if a user/mgmt
app has explicitly opted in to the new Secure VM feature, and existing
users won't be broken by a new feature they don't even use.

> Any opinions on whether dropping support for the older guest kernels
> is acceptable at this point?


I think this question has different answers depending on whether you
are considering downstream vendor policy, current upstream policy,
and a possible new downstream policy on guest support. IOW a bit of a
can of worms...


In the case of RHEL downstream there is a very narrow matrix for
what guest OS are considered supported.

In the case of current upstream, there has essentially never been
any documented guest matrix. The unwritten implicit rule upstream
has followed is to not change defaults in a way that would break
ability to run existing guest OS.


As an example, on x86 upstream defaults to i440fx and thus still
uses virtio devices in transitional mode by default, while downstream
RHEL used its narrow support matrix as a justification for why it was
ok to switch to q35 by default & loose guest support in many cases.
Even that was problematic though, because RHEL still needed to support
RHEL-6 guest which are broken by default with q35 since they only
support legacy mode virtio. Thus we needed work in management apps
to enable RHEL-6 to continue working with q35 chipset, by placing
the devices onto a PCI bridge, instead of a PCIe root port, or by
explicitly using i440fx instead.

Thus if we follow our *current* upstream guest support policy, I don't
think it is acceptable to break existing guests with the new machine
type upstream.  It is reasonable to do it downstream if the downstream
is willing to sacrifice these guests, or invest to make any mgmt apps=20
add workaround/revert QEMU changes.


With that all said, I do *NOT* think current upstream practice is good
or sustainable long term (though I admit I've argued on the other side
in the past).

This policy is why we're still using a machine designed in 1995 on x86
by default, in order that we avoid breaking the popular guest OS of the
day, like Windows 95.

This is similar to the problem we had with host build platforms, where
we afraid to make any change which would break an existing build platform,
or on the flipside made arbitrary ad-hoc changes with no consistent
approach across different subsystems.


I think that we should aim define some clearer policy around how we
want to support guest OS in upstream. As we did with our host build
platforms policy, any guest support policy should aim to move forward
at a reasonable pace so that we are not locked at a specific point in
time forever.

I can imagine three tiers

 1. Recommended. Expected to work well with machine type defaults
 2. Supported. Should work with QEMU but may need special settings applied
 3. Unsupported. Will not work with QEMU regardless of settings

I don't have an opinion right now on what guest OS should fall in which
category. One possible way to classify them would be to look at whether
the vendor themselves still supported the OS.  IOW, to be in the
"Recommended" criteria, it must be actively supported by the vendor.
Once EOL by the vendor it would be capped at the "Supported" tier.

That definition wouldn't help your pseries issue though, because RHEL-6
is still considered a supported OS.

Another possible way to classify guest OS would be to look purely at
the original release date, and set a cap of "$TODAY - 5 years" for
the "Recommended" tier. That would exclude RHEL-6.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


