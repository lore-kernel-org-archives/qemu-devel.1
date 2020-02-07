Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC135C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:05:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D1520838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 08:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCNMEBYC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D1520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izydj-0006QK-7K
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 03:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eskultet@redhat.com>) id 1izycx-0005xf-T6
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eskultet@redhat.com>) id 1izyct-0002Ju-Gw
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:04:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33082
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1izyct-0002Cx-CQ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 03:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581062674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJUmdgb7t9/mzM6yCpMdVcRpA1OdDZA50PSh4v3jRgk=;
 b=WCNMEBYC5AygfhdQ58IC4Op1A2NxwtZIS1Ow0QV6JW+pXwwqaqcPsVZicH3u7vRfXVMXMW
 /XU/9oS0SbbfZ6L6W/H+45+ezplhJWWnOFWU5Zy9IbmEHZUCf2jIdYjJYNEECMyABvBN6O
 J4N5T8yE344dcdCg5J43wpQinNLGFr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-FJQQMjmXMOul6Q2H7YdEHA-1; Fri, 07 Feb 2020 03:03:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11E1A190B2A0;
 Fri,  7 Feb 2020 08:03:23 +0000 (UTC)
Received: from ridgehead (unknown [10.43.2.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EE361001B08;
 Fri,  7 Feb 2020 08:03:16 +0000 (UTC)
Date: Fri, 7 Feb 2020 09:03:14 +0100
From: Erik Skultety <eskultet@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 0/6] ui: rework -show-cursor option
Message-ID: <20200207080314.GA85733@ridgehead>
References: <20200206112908.5002-1-kraxel@redhat.com>
 <CAFEAcA8eHS7KuMW6RXdxoYAdQAJOJK6thqp5Vn+LZav7B79MWw@mail.gmail.com>
 <20200206132002.6piouqiatuj3tj7f@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200206132002.6piouqiatuj3tj7f@sirius.home.kraxel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: FJQQMjmXMOul6Q2H7YdEHA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>,
 Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 jpewhacker@gmail.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 06, 2020 at 02:20:02PM +0100, Gerd Hoffmann wrote:
> On Thu, Feb 06, 2020 at 11:52:05AM +0000, Peter Maydell wrote:
> > On Thu, 6 Feb 2020 at 11:29, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > >
> >
> > This cover letter is missing a description of what the patchset does...
> >
> > The closest thing the patchset seems to get to documentation is the
> > oneliner in ui.json:
> > +# @show-cursor:   Force showing the mouse cursor (default: off).
> >
> > but looking at the ui/cocoa.m implementation that isn't what it
> > actually does -- it just seems to mean "default to shown on
> > startup", because the logic that unconditionally hides the host
> > cursor on mousegrab and unhides it on ungrab remains
> > unchanged. This doesn't on the face of it sound like very
> > useful behaviour, since the option will only have an effect for
> > the short period of time between QEMU startup and the first
> > mouse-grab, but without documentation of what the option
> > is intended to do and in particular how it's intended to
> > interact with grab/ungrab I don't know what your intention
> > for the behaviour was.
>
> Well, it doesn't change actual behavior for SDL and cocoa.  It only adds
> "-display {sdl,cocoa},show-cursor=3Don" as replacement for the global
> "-show-cursor" option.  Guess I should reorder the patches (move 5/6
> before the individual UI patches) and reword the commit messages.

I suppose this patch set didn't intend to workaround the missing cursor ove=
r
VNC with NVIDIA vGPUs, right? IIRC the default is that the local cursor is
sent over to the destination whereas we need to force the remote cursor to =
be
sent back, do I remember that correctly the setting for which have to adver=
tize
vncviewer?

Erik


