Received: from eggs.gnu.org ([2001:4830:134:3::10]:44041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csQVn-0002EP-3M
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 05:00:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csQVm-0007oL-9l
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 05:00:27 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csQVm-0007oA-3C
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 05:00:26 -0400
Received: by mail-wr0-x22a.google.com with SMTP id u1so45922442wra.2
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 02:00:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170327104440.4f58ec26.cornelia.huck@de.ibm.com>
References: <20170322203140.GA12155@thinpad.lan.raisama.net>
	<3d10c7b3-b702-3c16-7f3e-dfc6b332fbd4@redhat.com>
	<b5516794-4592-569e-66ba-05dc40573a10@redhat.com>
	<20170324134821.GC28530@thinpad.lan.raisama.net>
	<87y3vur4qk.fsf@dusky.pond.sub.org>
	<CAFEAcA_V3w6-WELX_M-jW1M=2TV7-wmEWa-c40ZmXLywC=+=Cg@mail.gmail.com>
	<20170324192318.GG28530@thinpad.lan.raisama.net>
	<20170327104440.4f58ec26.cornelia.huck@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Mar 2017 10:00:04 +0100
Message-ID: <CAFEAcA9v7He==gZ87g39RLBaM5dyXrQ68gKe4snriX_7rtemFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] q35 and sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 27 March 2017 at 09:44, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> ISTR some surprises that reset (or some other) callbacks were not
> called as expected if there wasn't a sysbus device among the ancestors.
> Don't know if that's still true.

Yes -- if you're a sysbus device then your reset method is
called. If you're only a subclass of Device then your reset
method is not called.

I think this is because buses like PCI have specific
reset behaviour (order important between host and
devices, maybe?), so we defer reset to the subclass.

(Reset is a mess anyway.)

thanks
-- PMM
