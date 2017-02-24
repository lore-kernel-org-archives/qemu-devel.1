Received: from eggs.gnu.org ([2001:4830:134:3::10]:36146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chDEE-0005nz-Bg
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chDED-0005CX-Ih
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:35:58 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:32931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chDED-0005At-Aw
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 05:35:57 -0500
Received: by mail-wr0-x22b.google.com with SMTP id u47so10318448wrb.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 02:35:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170224001613.GG17615@umbus.fritz.box>
References: <CAFEAcA8AZup28Sho8hLeCRVf4iSdLdeFHvz1h4-X7FwVBcANyg@mail.gmail.com>
	<448f3a5f-044e-bcac-60bd-2ce074021be9@redhat.com>
	<20170223224911.GC17615@umbus.fritz.box>
	<20170224001613.GG17615@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 10:35:35 +0000
Message-ID: <CAFEAcA9V_1NA6-JgZd7Pc1hwih+uBKBrt4MPi4+kPWRu-xduPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] using fdt_setprop() to set properties to empty
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 24 February 2017 at 00:16, David Gibson <david@gibson.dropbear.id.au> wrote:
> Ok, I've pushed libfdt upstream patches to (a) make passing NULL to
> setprop() with zero length explicitly safe and (b) add an
> fdt_setprop_empty() helper macro.  Do you want me to make a pullreq to
> update the qemu submodule?

Yes, please. Are we OK with using a random libfdt commit or do
we update only to proper release tags? There's no real rush with
this so if you have a release due shortly it might be better
to wait for that.

thanks
-- PMM
