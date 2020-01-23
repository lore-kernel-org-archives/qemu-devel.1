Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E62C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 10:28:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCEB24125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 10:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsS3MsuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCEB24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuZif-0002BI-Hl
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 05:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iuZhs-0001jd-5y
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:27:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iuZhq-0004hU-Nd
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:27:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57202
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iuZhq-0004h6-JH
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 05:27:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579775242;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flblt3mbOJxMrL/syVcaKF/9GxAXlaSvW5i1MYU7pRk=;
 b=ZsS3MsuDO5HZrlxNWgsm44Z67Oqop1x51nwt3JJlv2JlKrIVIEL1wGcjEByA++6NdIYqQR
 PPw0TZyatCOOtC7X7iWyMDSAYXnyZ/yxeziRZoa68Lo3+kzbTZ9xrHTZSeK7Aix5YOcQyl
 s80TKHBm/bh5nxepk1s+EV45GGOacnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-E1y0yfMQPsqulBrVLhykSA-1; Thu, 23 Jan 2020 05:27:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFF55107ACC5;
 Thu, 23 Jan 2020 10:27:16 +0000 (UTC)
Received: from redhat.com (ovpn-112-57.ams2.redhat.com [10.36.112.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0950E5C296;
 Thu, 23 Jan 2020 10:27:08 +0000 (UTC)
Date: Thu, 23 Jan 2020 10:27:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200123102705.GC657556@redhat.com>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <20191224130035.GC2710539@redhat.com>
 <a95b7572-d863-bc88-66aa-3beed679cefe@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a95b7572-d863-bc88-66aa-3beed679cefe@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: E1y0yfMQPsqulBrVLhykSA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 22, 2020 at 05:42:10PM -0500, John Snow wrote:
>=20
>=20
> On 12/24/19 8:00 AM, Daniel P. Berrang=C3=A9 wrote:
> > Based on experiance in libvirt, this is an even larger job than (4),
> > as the feature set here is huge.  Much of it directly ties into the
> > config problem, as to deal with SELinux / namespace setup the code
> > needs to understand what resources to provide access to. This
> > requires a way to express 100% coverage of all QEMU configuration
> > in use & analyse it to determine what resources it implies. So this
> > ties strongly into QAPI-ification completion.
>=20
> Is it totally bonkers to suggest that QEMU provide a method of digesting
> a given configuration and returning a configuration object that a
> standalone jailer can use?
>=20
> So we have a QEMU manager, the generic jailer, and QEMU. QEMU and the
> manager cooperate to produce the jailing configuration, and the jailer
> does what we ask it to.

It isn't clear what you mean by "QEMU" here. If this QEMU, the system
emulator process, then this is the untrustworthy part of the stack,
so the jailer must not use any data that QEMU is providing. In fact
during startup the jailer does its work before QEMU even exists.

There are aspects to the confinement that use / rely on knowledge that
QEMU doesn't normally have, or are expressed in a different way that
which QEMU uses, or needs to take a different imlpementation approach to
that which QEMU normally has.

For networking, for example, from QEMU's config POV, there's just a
TAP file descriptor. There are then a huge number of ways in which
that TAP FD has been connected to the network in the host that are
invisible to QEMU. Plain bridge, openvswitch bridge, macvtap device
all with varying configs. Knowledge of this is relevant to the manager
process and the jailer but irrelevant to QEMU.

When configuring disks we have technical issues. For example we need
to identify the full backing chain and grant the appropriate permissions
on this. Even if there was a libqemublock.so, libvirt would not use this
because the QEMU storage code design is not reliable & minimal enough.
For example to just query the backing file, QEMU opens the qcow2 and
parses all the data about it, building up L1/L2 tables, and other
data structures involved. It is trivial to create qcow2 files which
result in both memory and CPU denial of service merely from opening
the file.  Libvirt's approach to this is minimalist just having a
data table of offsets to the key fields in each file format. So we
can extract the backing file & its format without reading anything
else from the disk.

When configuring chardevs there is a choice of how to do it - we
could just pass the UNIX socket path in, or we could create the
UNIX socket ourselves & pass in the pre-opened FD. Both are equally
functional from QEMU's POV and the end user's POV, but passing a
pre-opened FD is more convenient for libvirt's needs as it allowed
for race-free startups sychronization between libvirt & QEMU, or
rather QMP.  The different options here though, have different
needs on the jailer, because extra steps are needed when passing
pre-opened FD to get the SELinux labelling right. QEMU doesn't
know which approach the mgmt app will want to take, so we can't
ask QEMU how the jailer should be configured - the mgmt app needs
to make that decision.

Essentially we have 2 configuration formats - the high level one
that the mgmt app layer uses & the low level one that QEMU uses.
The component in the stack which maps between the two config
formats, is that one that has the knowledge to configure the
jailer. This isn't QEMU. It is whatever is immediately above QEMU,
currently libvirt, but something conceptually equivalent to the
role libvirt's QEMU driver impl fills.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


