Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E113C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 08:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBFB217D7
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 08:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBFB217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38044 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKEO-0000cH-83
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 04:29:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hCKCb-00086P-V3
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hCKCZ-0001wE-9k
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:27:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hCKB4-00068k-F4
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:27:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2778A821F1;
	Fri,  5 Apr 2019 08:26:21 +0000 (UTC)
Received: from redhat.com (ovpn-112-43.ams2.redhat.com [10.36.112.43])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 33BA25D9C4;
	Fri,  5 Apr 2019 08:26:16 +0000 (UTC)
Date: Fri, 5 Apr 2019 09:26:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Helge Deller <deller@gmx.de>
Message-ID: <20190405082613.GC6105@redhat.com>
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 05 Apr 2019 08:26:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405082613.1HNnL47XwPyOxdTfA__6fd0xdV64A-6o-xEoIIFKGg0@z>

On Fri, Apr 05, 2019 at 09:56:46AM +0200, Helge Deller wrote:
> Hi Peter,
> 
> On 05.04.19 03:34, Peter Maydell wrote:
> > On Fri, 5 Apr 2019 at 01:59, Helge Deller <deller@gmx.de> wrote:
> >> If a non-release architecture is found, and it's known that there is no
> >> native TCG support for that CPU, automatically fall back to the TCI
> >> implementation instead of requesting the user to run configure again
> >> with the --enable-tcg-interpreter option.
> >>
> >> This change simplifies building qemu in automatic build environments
> >> (like in my case the debian buildds) because one does not need to
> >> special case on the architectures.
> >
> > I don't think we should do this. TCI is unmaintained, has several
> > known flaws,
> 
> Just out of interest: Is there a list with those flaws somewhere?
> 
> > does not provide the level of performance that
> > people expect from QEMU, and we've talked about removing it
> > altogether. In particular, distros should not automatically ship
> > a TCI QEMU -- it's something that a user can use if they
> > explicitly opt into but which I don't think we want to surprise
> > anybody with.
> 
> I won't argue against your points. They are all valid.
> 
> > If we care about a host architecture we should support it
> > with a proper TCG backend. If we don't care that much we
> > shouldn't support it.
> 
> Looking just at some of the debian "ports" (non-release) architectures:
> alpha, hppa, ia64, m68k, powerpc, sh4, sparc64
> Most likely nobody will ever care enough to write a TCG backend for those,
> and it doesn't even make sense because they are so much slower than
> the currently supported TCG backend architectures. So why should one want
> to emulate a fast x86 machine on slow m68k for example?
> 
> The only reason when it *can* make sense is, when you need "basic"
> emulation or availability of binaries for cross-dependecies in distros,
> e.g. to build other packages or to be able to install other packages.
> As one example, many packages depend on libvirt (frontend tools, monitoring
> stuff, ...) and libvirt again depends on some qemu binaries.
> So, having qemu buildable (even if the result is slow) makes life easier.

If it is just a matter of satisfying dependencies, it is easy to build
a minimal libvirt that is essentially just the client libraries and not
the QEMU driver that would in turn allow other packages to build. Alternatively
it should be possible to build the downstream apps with their libvirt dep
disabled avoiding pulling in the whole virtualization chain as a build
pre-req.

> I know, my point above now turns into a "distro packaging" issue.
> That's why I'm questioning, why should distros (or even direct end-users)
> be forced to distinguish between architectures?
> Shouldn't running "./configure" find out what's available and then
>  auto-configure itself to the *best* what's possible?

"best" depends on the POV. You want configure to enable support on
hppa by default since you have an interest in that architecture, which
is fine. The QEMU maintainers, however, have a POV that considers
raising an error by default to be the "best" solution for architectures
that are considered unsupported, requiring explicit arg to optin to use
unsupported features.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

