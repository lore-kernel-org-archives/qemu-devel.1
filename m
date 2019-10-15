Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC366C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4AB20873
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4AB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKNUj-0005AR-KE
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iKNRx-0001h6-Cm
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iKNRv-0007Sn-DT
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:05:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56708)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iKNRp-0007QT-7b; Tue, 15 Oct 2019 10:05:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64677796FF;
 Tue, 15 Oct 2019 14:05:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-177.ams2.redhat.com
 [10.36.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8312E60619;
 Tue, 15 Oct 2019 14:05:11 +0000 (UTC)
Date: Tue, 15 Oct 2019 16:05:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] doc: Describe missing generic -blockdev options
Message-ID: <20191015140510.GB4093@localhost.localdomain>
References: <20191015123854.12039-1-kwolf@redhat.com>
 <CAFEAcA8vUcj2bQDno17ncH=zoDvW-9wrzaWo4pLyPTX_Ot=AAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8vUcj2bQDno17ncH=zoDvW-9wrzaWo4pLyPTX_Ot=AAQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 15 Oct 2019 14:05:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 15.10.2019 um 15:55 hat Peter Maydell geschrieben:
> On Tue, 15 Oct 2019 at 13:40, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > We added more generic options after introducing -blockdev and forgot to
> > update the documentation (man page and --help output) accordingly. Do
> > that now.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qemu-options.hx | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 793d70ff93..9f6aa3dde3 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -849,7 +849,8 @@ ETEXI
> >  DEF("blockdev", HAS_ARG, QEMU_OPTION_blockdev,
> >      "-blockdev [driver=]driver[,node-name=N][,discard=ignore|unmap]\n"
> >      "          [,cache.direct=on|off][,cache.no-flush=on|off]\n"
> > -    "          [,read-only=on|off][,detect-zeroes=on|off|unmap]\n"
> > +    "          [,read-only=on|off][,auto-read-only=on|off]\n"
> > +    "          [,force-share=on|off][,detect-zeroes=on|off|unmap]\n"
> >      "          [,driver specific parameters...]\n"
> >      "                configure a block backend\n", QEMU_ARCH_ALL)
> >  STEXI
> > @@ -885,6 +886,22 @@ name is not intended to be predictable and changes between QEMU invocations.
> >  For the top level, an explicit node name must be specified.
> >  @item read-only
> >  Open the node read-only. Guest write attempts will fail.
> > +
> > +Note that some block drivers support only read-only access, either generally or
> > +in certain configurations. In this case, the default value
> > +@option{read-only=off} does not work and the option must be specified
> > +explicitly.
> > +@item auto-read-only
> > +If @option{auto-read-only=on} is set, QEMU is allowed not to open the image
> > +read-write even if @option{read-only=off} is requested, but fall back to
> > +read-only instead (and switch between the modes later), e.g. depending on
> > +whether the image file is writable or whether a writing user is attached to the
> > +node.
> > +@item force-share
> > +Override the image locking system of QEMU and force the node to allowing
> > +sharing all permissions with other uses.
> 
> Grammar nit: "to allow sharing"; but maybe the phrasing could
> be clarified anyway -- I'm not entirely sure what 'sharing
> permissions" would be. The first part of the sentence suggests
> this option is "force the image file to be opened even if some
> other QEMU instance has it open already", but the second half
> soudns like "don't lock the image, so that some other use later
> is allowed to open it" ? Or is it both, or something else?

It's more the latter. Open the image file and allow other instances to
have it open as well (existing and future instances), but still error
out if the other instance doesn't allow sharing.

I'm open for suggestions on how to phrase this better.

Kevin

