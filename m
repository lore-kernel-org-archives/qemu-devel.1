Received: from eggs.gnu.org ([2001:4830:134:3::10]:33933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNyfj-0002QK-Bh
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNyff-00028A-8n
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:45:07 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:34881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNyff-00026l-0n
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 05:45:03 -0400
Received: by mail-wr0-x22f.google.com with SMTP id k67so15584811wrc.2
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 02:45:02 -0700 (PDT)
References: <1498045580087.46004@epfl.ch>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1498045580087.46004@epfl.ch>
Date: Thu, 22 Jun 2017 10:45:45 +0100
Message-ID: <87injotkxi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Looking for ideas: Single process vs multi process
 qemu instances
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ajallooiean Hossein <hossein.ajallooiean@epfl.ch>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


Ajallooiean Hossein <hossein.ajallooiean@epfl.ch> writes:

> Hi All,
>
>
> we are trying to do server simulation and for that purpose we need to
> have multiple Qemu instances (each can have a different spec) that are
> part of a virtual network (ns-3 in our case).

So you are talking about using TCG for simulation rather than KVM here?

>
>
> Now for the Qemu implementation part: would it be easier/better to
> have all the Qemu instances under a single process or multiple
> processes? i am assuming if one single process is used, there will be
> a threading conflict that would probably need to be looked at.

QEMU isn't really setup for multiple machine instances in the one
binary. If you are simulating a complex set of communicating machines
then you will need one QEMU instance per machine.

TCG can now use multiple threads (one per emulated vCPU) but this has
only been enabled for a subset of architectures so far. You don't say
what architecture your servers machines are.

>
>
> I am looking at this purely from a management/performance view.
>
>
> Any ideas/suggestions?
>
>
> Thanks
>
> Hoss


--
Alex Bennée
