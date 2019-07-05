Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAF3C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C448218BA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:07:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C448218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjM42-000381-Ix
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 07:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34234)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hjM2R-0002JY-C9
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hjM2P-0007MG-Bp
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:05:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hjM2N-0006wn-AN
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:05:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6A5183162910;
 Fri,  5 Jul 2019 11:05:42 +0000 (UTC)
Received: from redhat.com (ovpn-112-48.ams2.redhat.com [10.36.112.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DE211001B29;
 Fri,  5 Jul 2019 11:05:34 +0000 (UTC)
Date: Fri, 5 Jul 2019 12:05:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190705110531.GK32473@redhat.com>
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-10-kraxel@redhat.com>
 <87zhlsvkx1.fsf@zen.linaroharston>
 <5d0e35f4-964e-e6e0-d644-ea19fc9cd029@gmx.com>
 <CAFEAcA9yGCXB0XTNeZwzKyX+WtMNjG2s-RPRSc6GSOLN0nh6fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9yGCXB0XTNeZwzKyX+WtMNjG2s-RPRSc6GSOLN0nh6fQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 05 Jul 2019 11:05:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 09/11] tests/vm: netbsd autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Kamil Rytarowski <n54@gmx.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 05, 2019 at 11:52:20AM +0100, Peter Maydell wrote:
> On Fri, 5 Jul 2019 at 11:43, Kamil Rytarowski <n54@gmx.com> wrote:
> >
> > On 05.07.2019 12:24, Alex Benn=C3=A9e wrote:
> > >
> > > Gerd Hoffmann <kraxel@redhat.com> writes:
> > >
> > >> Instead of fetching the prebuilt image from patchew download the i=
nstall
> > >> iso and prepare the image locally.  Install to disk, using the ser=
ial
> > >> console.  Create qemu user, configure ssh login.  Install packages
> > >> needed for qemu builds.
> > >
> > > I've had to drop this from my v3 PR as Peter was seeing a very
> > > slow/hanging install when running his merge tests. I've tried to
> > > reproduce and I see it stall while installing packages but nowhere =
near
> > > the delay Peter has seen.
> > >
> > > Any pointers on how to debug gratefully received.
> > >
> >
> > Does it use virtio? There were performance issues with virio disk dev=
ice.
>=20
> The symptoms I see with this patch are that the VM appears to
> completely stall, rather than progressing but slowly.
> (I do also see on the current NetBSD tests/vm setup that sometimes
> 'make check' runs pretty slowly, but in that case it does make
> progress, it just completes much slower than either the openbsd
> or freebsd VMs. 'make check' is not particularly IO intensive,
> certainly not compared to the actual compile phase, though.
> And sometimes the initial "wait for VM to boot and ssh in"
> phase just hits our 6 minute timeout.)

I wonder if there's some undiagnosed timer or interrupt problems we're
hitting in NetBSD. We had someone just yesterdayt on IRC reporting they
needed kernel irqchip disabled for OpenBSD under some circumstances
for example. So could be worth trying one or more of the various
tweak args like:

    -machine kernel_irqchip=3Doff
    -global kvm-pit.lost_tick_policy=3Ddiscard

to see if it affects stability to any useful extent.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

