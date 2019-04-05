Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784B4C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:05:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F2821738
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F2821738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKnH-000133-FL
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 05:05:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hCKld-0008LM-Fw
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hCKjt-0003BT-MZ
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:02:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hCKjt-0003AY-3d
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:02:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2AD6530018C2;
	Fri,  5 Apr 2019 09:02:20 +0000 (UTC)
Received: from redhat.com (ovpn-112-43.ams2.redhat.com [10.36.112.43])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 81A39611D9;
	Fri,  5 Apr 2019 09:02:15 +0000 (UTC)
Date: Fri, 5 Apr 2019 10:02:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190405090212.GF6105@redhat.com>
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 05 Apr 2019 09:02:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
	Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405090212.L2RBuNeZcMRGYP1p_pMn3XY-Q9--14COr7yq-hm9ze4@z>

On Fri, Apr 05, 2019 at 10:47:54AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Helge,
>=20
> On 4/5/19 9:56 AM, Helge Deller wrote:
> > On 05.04.19 03:34, Peter Maydell wrote:
> >> On Fri, 5 Apr 2019 at 01:59, Helge Deller <deller@gmx.de> wrote:
> >>> If a non-release architecture is found, and it's known that there i=
s no
> >>> native TCG support for that CPU, automatically fall back to the TCI
> >>> implementation instead of requesting the user to run configure agai=
n
> >>> with the --enable-tcg-interpreter option.
> >>>
> >>> This change simplifies building qemu in automatic build environment=
s
> >>> (like in my case the debian buildds) because one does not need to
> >>> special case on the architectures.
> >>
> >> I don't think we should do this. TCI is unmaintained, has several
> >> known flaws,
> >=20
> > Just out of interest: Is there a list with those flaws somewhere?
>=20
> The last big discussion is in this thread:
> https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06528.html

Do the various crashes that you illustrate in that cover letter
still exist today ? If so, 2 years of continued brokenness with no
fixes would reinforce the the view that it is time to remove TCI
from the codebase.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

