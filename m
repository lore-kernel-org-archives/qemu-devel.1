Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC01C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 08:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0353421479
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 08:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0353421479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOINV-0007B7-9H
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 04:56:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hOIMj-0006bt-Uo
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hOIMi-0002Cn-UE
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:55:53 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:54558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hOIMd-0001xS-5o
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:55:47 -0400
Received: from player776.ha.ovh.net (unknown [10.109.146.82])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8863B124EF5
	for <qemu-devel@nongnu.org>; Wed,  8 May 2019 10:55:39 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player776.ha.ovh.net (Postfix) with ESMTPSA id E648F580CB50;
	Wed,  8 May 2019 08:55:35 +0000 (UTC)
Date: Wed, 8 May 2019 10:55:34 +0200
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190508105534.6d4a252d@bahia.lan>
In-Reply-To: <2fb1b764-0609-c140-8781-e4a2c9005847@redhat.com>
References: <155721868351.451636.16735088470797960209.stgit@bahia.lan>
	<155721871159.451636.6528273080303910901.stgit@bahia.lan>
	<2fb1b764-0609-c140-8781-e4a2c9005847@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11063936909753096498
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkeefgddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.59.63
Subject: Re: [Qemu-devel] [PATCH 5/6] vl: Deprecate -virtfs_synth
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 May 2019 10:26:53 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 07/05/2019 10.45, Greg Kurz wrote:
> > The synth fsdriver never got used for anything else but the
> > QTest testcase for VirtIO 9P. And even there, QTest directly
> > uses -fsdev synth and -device virtio-9p-{pci|device}.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > 
> > This should be Cc'd to libvir-list@redhat.com according to MAINTAINERS,
> > but libvirt doesn't know about -virtfs_synth, so I choose to not spam :)
> > ---
> >  qemu-deprecated.texi |    4 ++++
> >  qemu-options.hx      |    3 ++-
> >  vl.c                 |    5 +++++
> >  3 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> > index 842e71b11dcc..f0ff065e7dc1 100644
> > --- a/qemu-deprecated.texi
> > +++ b/qemu-deprecated.texi
> > @@ -72,6 +72,10 @@ backend settings instead of environment variables.  To ease migration to
> >  the new format, the ``-audiodev-help'' option can be used to convert
> >  the current values of the environment variables to ``-audiodev'' options.
> >  
> > +@subsection -virtfs_synth (since 4.1)
> > +
> > +The ``-virtfs_synth'' argument is now deprecated with no replacement.
> > +
> >  @section QEMU Machine Protocol (QMP) commands
> >  
> >  @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 51802cbb266a..9c5cc2e6bf70 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -1368,7 +1368,8 @@ DEF("virtfs_synth", 0, QEMU_OPTION_virtfs_synth,
> >  STEXI
> >  @item -virtfs_synth
> >  @findex -virtfs_synth
> > -Create synthetic file system image
> > +Create synthetic file system image. Note that this option is deprecated with
> > +no replacement.
> >  ETEXI
> >  
> >  DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
> > diff --git a/vl.c b/vl.c
> > index d9fea0a11966..c010cb3e98df 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -3507,6 +3507,11 @@ int main(int argc, char **argv, char **envp)
> >                  QemuOpts *fsdev;
> >                  QemuOpts *device;
> >  
> > +                warn_report("The -virtfs_synth option is deprecated and will "
> > +                            "be removed soon. If the -virtfs_synth option is "
> > +                            "still useful for you, please send a mail to "
> > +                            "qemu-devel@nongnu.org with your usecase.");
> > +
> >                  fsdev = qemu_opts_create(qemu_find_opts("fsdev"), "v_synth",
> >                                           1, NULL);
> >                  if (!fsdev) {  
> 
> Do you plan to only deprecate the -virtfs_synth option, or also "-fsdev
> synth", i.e. the whole "synth" driver? In the first case, I think you
> should point the users to use "-fsdev synth" instead of saying "with no
> replacement".

The plan is to remove -virtfs_synth only. You're right, I'll point users
to use "-fsdev synth" and "-device virtio-9p" instead.

> In the second case, I think you should declare "-fsdev
> synth" in the documentation, too.
> 
>  Thomas


