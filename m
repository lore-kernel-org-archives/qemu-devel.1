Received: from eggs.gnu.org ([2001:4830:134:3::10]:48082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZaSJ-0001NY-Fe
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZaSH-0000FD-OD
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:46:59 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZaSH-0000ES-Hv
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:46:57 -0500
Received: by mail-wm0-x236.google.com with SMTP id v77so19275880wmv.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 01:46:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <03266a2a-2ff8-458e-b6cc-67c3888a6b39@redhat.com>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
	<148602129908.33.4236801111127079549@eba24e3a0d7f>
	<20170202224420.GA7754@umbus.fritz.box>
	<03266a2a-2ff8-458e-b6cc-67c3888a6b39@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 09:46:35 +0000
Message-ID: <CAFEAcA8KoBAT+=k0c299wQTD6PykSkxcFcDgB+jgNXQhY3qMWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 000/107] ppc-for-2.9 queue
 20170202
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 3 February 2017 at 08:36, Thomas Huth <thuth@redhat.com> wrote:
> We've got lot's of C++ comments in the QEMU sources already, and the
> CODING_STYLE document even does not mention this ... maybe this is just
> a left-over from the Linux kernel's checkpatch.pl script? So IMHO:
> Ignore this error. (and if we really agree that C++ comments are a
> no-go, then somebody should send a patch to update the CODING_STYLE).

I've always assumed //-comments are not part of QEMU's coding
style, and we really don't have all that many in the codebase,
so I would vote for keeping this rule. (The exceptions are
mostly in 3rd-party code in disas/ and also in ui/cocoa.m
which was written to ObjC conventions.)

(I find it useful locally that checkpatch complains because
then I can write my todo comments as // TODO and they get
picked up in checkpatch.)

thanks
-- PMM
