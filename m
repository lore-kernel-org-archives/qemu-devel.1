Received: from eggs.gnu.org ([209.51.188.92]:54284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robin.jarry@6wind.com>) id 1h0qtV-0001Lr-Ue
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:56:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robin.jarry@6wind.com>) id 1h0qtU-0006mg-W8
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:56:49 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:32948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <robin.jarry@6wind.com>)
	id 1h0qtU-0006it-Hj
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 11:56:48 -0500
Received: by mail-wr1-x435.google.com with SMTP id i12so6349954wrw.0
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 08:56:48 -0800 (PST)
Date: Mon, 4 Mar 2019 17:56:44 +0100
From: Robin Jarry <robin.jarry@6wind.com>
Message-ID: <20190304165644.d3qtlai63eokriwy@6wind.com>
References: <20190211170924.uw6a6xyvmznk7w72@6wind.com>
	<20190220030707.GA5504@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220030707.GA5504@minyard.net>
Subject: Re: [Qemu-devel] -device ipmi-bmc-sim attached to -netdev vde
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org

Hi Corey,

Thanks a lot for your detailed answer!

2019-02-19, Corey Minyard:
> If you really wanted to do this, you would need to implement the IPMI
> LAN protocol inside QEMU and sit it on top of a UDP chardev.  It could
> then plug into the standard IPMI infrastructure in QEMU.  The power
> management functions are already there.
> 
> The openipmi lanserv code is something you can steal from, it's at
> https://github.com/cminyard/openipmi/tree/master/lanserv
> 
> My suggestion, though, would be to implement something that ran over
> TLS with two-way authentication.  It doesn't look too hard to do
> in qemu (though I haven't tried it) but you could have a qemu console
> running over TLS that would allow you control from another qemu session.
> Plus it would give you authorization and encryption on your qemu
> console logins, which is probably a good thing.
> 
> <shameless-plug> I have been working on a library that makes it easy
> (easier?  The pain is always in the key management) to make TLS
> connections.  It's at https://github.com/cminyard/gensio and you
> can use it from C or Python.</shameless-plug>
> But there are many tools to accomplish this.

Ugh, I feared this would not be a walk in the park :)

This is unfortunately too much work for me at the moment. I don't like
it but I think I will have to live with vms communicating through
a SLIRP device to access the ipmi lanserv daemon.

I just need to figure out how this works, because vbmc-qemu does not cut
it for me. It does not allow fine-tuning the QEMU command line.

-- 
Robin
