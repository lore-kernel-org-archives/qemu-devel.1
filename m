Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C34C388F9
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9279422370
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IgTa3Qxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9279422370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka0B5-0003KE-Ig
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1ka09z-0001Zm-Hk
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:31:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1ka09v-0007cY-Cp
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604424708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AV6uN+96HsV282QBlLAmU6Oh19cDXX/t/5p7UE0egcw=;
 b=IgTa3QxqchmwkSZ7MDP2UL0E9ggtNFOAMqnUwlIabx6tPj2vuoDfJTg0WfRdzU35cRKPhK
 kReofRMrWNCvOf66caeiNPnbHY5HPdq+H/2fONbtJffqTguM2N/XuS+RV+8jNdUVpFQ54c
 LFfBo86KHK2svHPEPSv1WNEBkosxNPw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-7KVERFg5Nzycv7rvcmA8CA-1; Tue, 03 Nov 2020 12:31:43 -0500
X-MC-Unique: 7KVERFg5Nzycv7rvcmA8CA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8794F8049FE;
 Tue,  3 Nov 2020 17:31:42 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5E705C5DE;
 Tue,  3 Nov 2020 17:31:35 +0000 (UTC)
Date: Tue, 3 Nov 2020 10:31:35 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201103103135.7da0a9c5@w520.home>
In-Reply-To: <20201103153356.GO205187@redhat.com>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <ly5z6m79c0.fsf@redhat.com> <20201103153356.GO205187@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: John G Johnson <john.g.johnson@oracle.com>, mtsirkin@redhat.com,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Kirti Wankhede <kwankhede@nvidia.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 15:33:56 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Tue, Nov 03, 2020 at 04:23:43PM +0100, Christophe de Dinechin wrote:
> >=20
> > On 2020-11-02 at 12:11 CET, Stefan Hajnoczi wrote... =20
> > > There is discussion about VFIO migration in the "Re: Out-of-Process
> > > Device Emulation session at KVM Forum 2020" thread. The current statu=
s
> > > is that Kirti proposed a VFIO device region type for saving and loadi=
ng
> > > device state. There is currently no guidance on migrating between
> > > different device versions or device implementations from different
> > > vendors. This is known to be non-trivial and raised discussion about
> > > whether it should really be handled by VFIO or centralized in QEMU.
> > >
> > > Below is a document that describes how to ensure migration compatibil=
ity
> > > in VFIO. It does not require changes to the VFIO migration interface.=
 It
> > > can be used for both VFIO/mdev kernel devices and vfio-user devices.
> > >
> > > The idea is that the device state blob is opaque to the VMM but the s=
ame
> > > level of migration compatibility that exists today is still available=
.
> > >
> > > I hope this will help us reach consensus and let us discuss specifics=
.
> > >
> > > If you followed the previous discussion, I changed the approach from
> > > sending a magic constant in the device state blob to identifying devi=
ce
> > > models by URIs. Therefore the device state structure does not need to=
 be
> > > defined here - the critical information for ensuring device migration
> > > compatibility is the device model and configuration defined below.
> > >
> > > Stefan
> > > ---
> > > VFIO Migration
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > This document describes how to save and load VFIO device states. Savi=
ng a
> > > device state produces a snapshot of a VFIO device's state that can be=
 loaded
> > > again at a later point in time to resume the device from the snapshot=
.
> > >
> > > The data representation of the device state is outside the scope of t=
his
> > > document.
> > >
> > > Overview
> > > --------
> > > The purpose of device states is to save the device at a point in time=
 and then
> > > restore the device back to the saved state later. This is more challe=
nging than
> > > it first appears.
> > >
> > > The process of saving a device state and loading it later is called
> > > *migration*. The state may be loaded by the same device that saved it=
 or by a
> > > new instance of the device, possibly running on a different computer.
> > >
> > > It must be possible to migrate to a newer implementation of the devic=
e
> > > as well as to an older implementation of the device. This allows user=
s
> > > to upgrade and roll back their systems.
> > >
> > > Migration can fail if loading the device state is not possible. It sh=
ould fail
> > > early with a clear error message. It must not appear to complete but =
leave the
> > > device inoperable due to a migration problem.
> > >
> > > The rest of this document describes how these requirements can be met=
.
> > >
> > > Device Models
> > > -------------
> > > Devices have a *hardware interface* consisting of hardware registers,
> > > interrupts, and so on.
> > >
> > > The hardware interface together with the device state representation =
is called
> > > a *device model*. Device models can be assigned URIs such as
> > > https://qemu.org/devices/e1000e to uniquely identify them. =20
> >=20
> > Like others, I think we should either
> >=20
> > a) Give a relatively strong requirement regarding what is at the URL in
> > question, e.g. docs, maybe even a machine-readable schema describing
> > configuration and state for the device. Leaving the option "there can b=
e
> > nothing here" is IMO asking for trouble.
> >=20
> > b) simply call that a unique ID, and then either drop the https: entire=
ly or
> > use something else, like pci:// or, to be more specific, vfio://
> >=20
> > I'd favor option (b) for a different practical reason. URLs are subject=
 to
> > redirection and other mishaps. For example, using https:// begs the que=
stion
> > whether
> > https://qemu.org/devices/e1000e and
> > https://www.qemu.org/devices/e1000e
> > should be treated as the same device. I believe that your intent is tha=
t
> > they shouldn't, but if the qemu web server redirects to www, and someon=
e
> > wants to copy-paste their web browser's URL bar to the command line, th=
ey'd
> > get the wrong one. =20
>=20
> That's not a real world problem IMHO, because neither of these URLs
> ever need resolve to a real webpage, and thus not need to be cut +
> paste from a browser.
>=20
> They are simply expressing a resource identifier using a URI as a
> convenient format. This is the same as an XML namespace using a URI,
> and rarely, if ever, resolving to any actual web page.
>=20
> This is a good thing, because if you say there needs to be a real page
> there, then it creates a pile of corporate beaurocracy for contributors.
> I can freely create a URI under https://redhat.com for purposes of being
> a identifier, but I cannot get any content published there without jumpin=
g
> through many tedious corporate approvals and stand a good chance of being
> rejected.
>=20
> If we're truely treating the URIs as an opaque string, we don't especiall=
y
> need to define any rules other than to say it should be under a domain th=
at
> you have authority over either directly, or via membership of a project
> that delegates. We can suggest "https" since seeing "http" is a red flag
> for many people these days.

Hmm, an opaque string, sort of like the existing "name" attribute we
have now where Christophe quoted some examples in his message.  Thanks,

Alex


