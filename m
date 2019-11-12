Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DE3C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 08:05:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 992E921783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 08:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+oZ9l4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992E921783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iURBF-0007aP-RI
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 03:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iURA4-00078I-P7
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 03:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iURA1-00007t-Ot
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 03:04:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38184
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iURA0-00006P-QP
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 03:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573545863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J5g7YF7I5AGOF51+RGR5bsfcIsWbceWHvXyfqlK3BmA=;
 b=a+oZ9l4eTQ9Q0TV30c+4fVaAz4RGLzzFhx1X3lEqX98WcrOHZXDM2eD6C0urSDawdHAip8
 BbCswynB0kNFOyWtygCZlCs13m1TJgOaT0H1IKWIAJ/WJmK98MX2eYgjTLhg4DgUNZbKJL
 XmrXysm2W27biEBO+eXN68F3SknOjZA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-WzaoieO2PNO_opN9aPU-cA-1; Tue, 12 Nov 2019 03:04:20 -0500
Received: by mail-qk1-f197.google.com with SMTP id m83so9630223qke.14
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 00:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=MbVImAaMAsP8qKzmWmpaV5oWg2PJzO/j7Ok0OAz1FtQ=;
 b=Ae09t/19BuiEB85QWM1w6Np8ebm9Y01tMY2LXvg9qCCAne29AMAZ7fL01cxokXFxGB
 +2o6AKOK++M6D30G/iFmlavP1QfY0UdiMDkS064+jM3OmIhYKwCgf/djGIVEmxE2kv/F
 5HhncOlx95ZEroAyFKfsv1SnAu2rtUVJmCcbI4giXmLH6khM3BQjrr9q5eNA40txnrml
 myEzFX5yq3S56afLzlxRp4go4rbSl3chfXaOujopLjejEHNxKSfooaTYX70CTypyU/u3
 dKkBdf0rJGO19yDWz2HVi52TzHY44Pa7sGZbybwoJBijj/ESZP7V2SzSH9xPA+VbBagj
 fJ6A==
X-Gm-Message-State: APjAAAWZtl9M3zIGVpEh1FCHwMRBkuMcpsEO4xoiBYUDGvMFrrn16Y+A
 sBezndZostOe1no/tFJr6sRd4nE+qC41+N9gQt2l9NIdNW8vhwDAqcz1TlA/dU7c1Z06pMo0Z41
 veqYt/euFHOYYACo=
X-Received: by 2002:a37:424a:: with SMTP id p71mr4641046qka.194.1573545860399; 
 Tue, 12 Nov 2019 00:04:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqyTz77jKp6Xyq6nGFxYTUegiYWI1D/Bi7WAYWMHwnWNaUpuerWvSOQDMf0HkuhEPPFtHb/RIg==
X-Received: by 2002:a37:424a:: with SMTP id p71mr4641026qka.194.1573545860087; 
 Tue, 12 Nov 2019 00:04:20 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id x30sm8465630qtc.7.2019.11.12.00.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 00:04:19 -0800 (PST)
Date: Tue, 12 Nov 2019 03:04:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [RFC][PATCH 2/3] docs/specs: Add specification of ivshmem device
 revision 2
Message-ID: <20191112024400-mutt-send-email-mst@kernel.org>
References: <cover.1573477032.git.jan.kiszka@siemens.com>
 <f5996d934d24775160bcedbf28ac975a95d91101.1573477032.git.jan.kiszka@siemens.com>
 <20191111084327-mutt-send-email-mst@kernel.org>
 <0b0475c1-2564-f433-46d8-ff1a06c13569@siemens.com>
 <20191111100607-mutt-send-email-mst@kernel.org>
 <20191111152743.GM814211@redhat.com>
 <20191111105850-mutt-send-email-mst@kernel.org>
 <ef21ed49-d315-4ee5-716b-096d8af1d79c@siemens.com>
MIME-Version: 1.0
In-Reply-To: <ef21ed49-d315-4ee5-716b-096d8af1d79c@siemens.com>
X-MC-Unique: WzaoieO2PNO_opN9aPU-cA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: liang yan <lyan@suse.com>, Jailhouse <jailhouse-dev@googlegroups.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 11, 2019 at 05:38:29PM +0100, Jan Kiszka wrote:
> On 11.11.19 17:11, Michael S. Tsirkin wrote:
> > On Mon, Nov 11, 2019 at 03:27:43PM +0000, Daniel P. Berrang=E9 wrote:
> > > On Mon, Nov 11, 2019 at 10:08:20AM -0500, Michael S. Tsirkin wrote:
> > > > On Mon, Nov 11, 2019 at 02:59:07PM +0100, Jan Kiszka wrote:
> > > > > On 11.11.19 14:45, Michael S. Tsirkin wrote:
> > > > > > On Mon, Nov 11, 2019 at 01:57:11PM +0100, Jan Kiszka wrote:
> > > > > > > +| Offset | Register               | Content                 =
                             |
> > > > > > > +|-------:|:-----------------------|:------------------------=
-----------------------------|
> > > > > > > +|    00h | Vendor ID              | 1AF4h                   =
                             |
> > > > > > > +|    02h | Device ID              | 1110h                   =
                             |
> > > > > >=20
> > > > > > Given it's a virtio vendor ID, please reserve a device ID
> > > > > > with the virtio TC.
> > > > >=20
> > > > > Yeah, QEMU's IVSHMEM was always using that. I'm happy to make thi=
s finally
> > > > > official.
> > > > >=20
> > > >=20
> > > > And I guess we will just mark it reserved or something right?
> > > > Since at least IVSHMEM 1 isn't a virtio device.
> > > > And will you be reusing same ID for IVSHMEM 2 or a new one?
> > >=20
> > > 1110h isn't under either of the virtio PCI device ID allowed ranges
> > > according to the spec:
> > >=20
> > >    "Any PCI device with PCI Vendor ID 0x1AF4, and PCI Device
> > >     ID 0x1000 through 0x107F inclusive is a virtio device.
> > >     ...
> > >     Additionally, devices MAY utilize a Transitional PCI Device
> > >     ID range, 0x1000 to 0x103F depending on the device type. "
> > >=20
> > > So there's no need to reserve 0x1110h from the virtio spec POV.
> >=20
> > Well we do have:
> >=20
> > =09B.3
> > =09What Device Number?
> > =09Device numbers can be reserved by the OASIS committee: email virtio-=
dev@lists.oasis-open.org to secure
> > =09a unique one.
> > =09Meanwhile for experimental drivers, use 65535 and work backwards.
> >=20
> > So it seems it can  in theory conflict at least with experimental virti=
o devices.
> >=20
> > Really it's messy that people are reusing the virtio vendor ID for
> > random stuff - getting a vendor ID is only hard for a hobbyist, any big
> > company already has an ID - but if it is a hobbyist and they at least
> > register then doesn't cause much harm.
>=20
> Note that ivshmem came from a research environment. I do know if there wa=
s a
> check for the IDs at the point the code was merged.
>=20
> That said, I may get a device ID here as well, provided I can explain tha=
t
> not a single "product" will own it, but rather an open specification.
>=20
> Jan

OK, up to you - if you decide you want an ID reserved, pls let us know.

At this point I'm not sure I have a good grasp which IDs are
registered where anymore. If someone can write it up, that would
be great too!

> --=20
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux


