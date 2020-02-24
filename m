Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21097C11D2F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D847C2084E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 17:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOyXqXoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D847C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Hfx-0007t8-55
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 12:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1j6HWz-0006qX-3u
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1j6HWx-0001Hb-EI
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:28:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32965
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1j6HWx-0001Gz-AR
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 12:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582565310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0l5YQT8oLIfropY26pOklIFdxF7tfIqfWPlHXd4GATI=;
 b=VOyXqXoM3/DgJIknZa8UfWP66s7CEEBUXdYAGBeGj5mnEbwSHUqOKHU+MtJh7/vo53DCCl
 usEnBHdFboJmMGTnv7NUfBPQjQPJKVjxrnzT6riWpMowiiTrxGOxoGFmHjqPiqLwuRE63e
 DCdoz/vRodZzAm0SMKX7SkKAfOF/MqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-mjZQ-OJ_Pmutg80Gldal5Q-1; Mon, 24 Feb 2020 12:28:27 -0500
X-MC-Unique: mjZQ-OJ_Pmutg80Gldal5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 191641882CD8;
 Mon, 24 Feb 2020 17:28:26 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-29.brq.redhat.com [10.40.204.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10ED55C13F;
 Mon, 24 Feb 2020 17:28:20 +0000 (UTC)
Date: Mon, 24 Feb 2020 18:28:17 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 3/3] qemu-img: Deprecate use of -b without -F
Message-ID: <20200224172817.GF3296@andariel.pipo.sk>
References: <20200222112341.4170045-1-eblake@redhat.com>
 <20200222112341.4170045-4-eblake@redhat.com>
 <20200224113827.GC3296@andariel.pipo.sk>
 <1125d96f-27f5-1882-9591-538e644a9a49@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1125d96f-27f5-1882-9591-538e644a9a49@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 24, 2020 at 10:08:31 -0600, Eric Blake wrote:
> On 2/24/20 5:38 AM, Peter Krempa wrote:
> > On Sat, Feb 22, 2020 at 05:23:41 -0600, Eric Blake wrote:
> > > Creating an image that requires format probing of the backing image i=
s
> > > inherently unsafe (we've had several CVEs over the years based on
> > > probes leaking information to the guest on a subsequent boot).  If ou=
r
> > > probing algorithm ever changes, or if other tools like libvirt
> > > determine a different probe result than we do, then subsequent use of
> > > that backing file under a different format will present corrupted dat=
a
> > > to the guest.  Start a deprecation clock so that future qemu-img can
> > > refuse to create unsafe backing chains that would rely on probing.
> > >=20
> > > However, there is one time where probing is safe: when we first creat=
e
> > > an image, no guest has yet used the new image, so as long as we recor=
d
> > > what we probed, all future uses of the image will see the same data -
> >=20
> > I disagree. If you are creating an overlay on top of an existing image
> > it's not safe to probe the format any more generally. (obviously you'd
> > have to trust the image and express the trust somehow)
> >=20
> > The image may have been used in a VM as raw and that means that the VM
> > might have recorded a valid qcow2 header into it. Creating the overlay
> > with probing would legitimize this.
> >=20
> > Let's assume we have a malicious image written by the guest but we
> > simulate it by:
> >=20
>=20
> > b) Now with this patchset:
> >=20
> > $ ./qemu-img create -f qcow2 -b /tmp/malicious /tmp/post-patch.qcow2
> > qemu-img: warning: Deprecated use of non-raw backing file without expli=
cit backing format, using detected format of qcow2
> > Formatting '/tmp/post-patch.qcow2', fmt=3Dqcow2 size=3D2560 backing_fil=
e=3D/tmp/malicious backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refcounts=
=3Doff refcount_bits=3D16
>=20
> >=20
> > You now get a warning, but "backing file format" is now recorded in the
> > overlay. Now this is WAY worse than it was before. The overlay now
> > legitimizes the format recorded by the malicious guest which circumvent=
s
> > libvirt's protections. The warning is very easy to miss, and if you run
> > it in scripts you might never get to see it. We can't allow that.
>=20
> Good point.  I'll respin this series where v2 never writes the implicit
> format except for a raw image (because probing raw is not only safe to
> record, but also prevents the guest from ever changing that probe, and th=
e
> real risk we are interested in preventing is when a formerly raw image la=
ter
> probes as non-raw).
>=20
> >=20
> >=20
> > > so the code now records the probe results as if the user had passed
> > > -F.  When this happens, it is unconditionally safe to record a probe
> > > of 'raw', but any other probe is still worth warning the user in case
> >=20
> > While it's safe I don't think it should be encouraged. IMO -F should be
> > made mandatory with -b.
>=20
> Making it mandatory will require the completion of the deprecation period=
.
> For 5.0 and 5.1, the best we can do is the warning, but for 5.2 (assuming=
 v2
> of this series is acceptable), it WILL become a hard error.

Yes, that's fair. I just wanted to point out that the warning and later
error should be reported also if raw is probed. I'm okay with recording
raw into the overlay even now.


