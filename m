Received: from eggs.gnu.org ([2001:4830:134:3::10]:59867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fxLRD-0005DK-Ed
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:12:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fxLR4-0000xV-Le
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:12:47 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1fxLR4-0000rQ-Df
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 20:12:42 -0400
Received: by mail-oi0-x243.google.com with SMTP id r69-v6so10318381oie.3
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 17:12:34 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180831112219.ujfdn4uiya5p7ul4@kamzik.brq.redhat.com>
References: <1535630903-146863-1-git-send-email-imammedo@redhat.com>
	<38b3347b-8923-26e9-82a4-f69002262767@redhat.com>
	<20180831112219.ujfdn4uiya5p7ul4@kamzik.brq.redhat.com>
Message-ID: <153610634684.28231.17938799672560738415@sif>
Date: Tue, 04 Sep 2018 19:12:26 -0500
Subject: Re: [Qemu-devel] [PATCH] qga: ignore non present cpus when handling
 qmp_guest_get_vcpus()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

Quoting Andrew Jones (2018-08-31 06:22:19)
> On Thu, Aug 30, 2018 at 05:51:13PM +0200, Laszlo Ersek wrote:
> > Originally these guest agent commands (both getting and setting) were
> > meant to be used in the absence of real VCPU hot[un]plug, as a fallback
> > / place-holder.
> > =

> > If the latter (=3D real VCPU hot(un)plug) works, then these guest agent
> > commands shouldn't be used at all.
> > =

> > Drew, do I remember correctly?
> =

> Yup. This guest agent functionality was merely a stopgap to support "cpu
> hotplug", before real cpu hotplug could be supported.
> =

> > I wonder if, instead of this patch, we should rework
> > qmp_guest_get_vcpus(), to silently skip processors for which this
> > dirpath ENOENT condition arises (i.e., return a shorter list of
> > GuestLogicalProcessor objects).
> =

> That sounds good to me.

+1, otherwise we end up reporting unplugged VCPUs as being present-but-offl=
ine
by virtue of them being in the returned list, which isn't really the case.

> =

> Thanks,
> drew
>=20
