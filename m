Received: from eggs.gnu.org ([2001:4830:134:3::10]:52640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cooeO-0003bC-Br
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:58:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cooeN-0007R1-LP
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:58:24 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cooeN-0007Qj-El
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:58:23 -0400
Received: by mail-wr0-x22a.google.com with SMTP id l37so48606401wrc.1
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 02:58:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170316185948.GN2567@work-vm>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<20170316154643.GT15193@redhat.com>
	<CAFEAcA9WdjkAr0eWNApWQGZAw4_67sci3LtY8=9pzYDcDXiLmg@mail.gmail.com>
	<20170316185948.GN2567@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Mar 2017 09:58:01 +0000
Message-ID: <CAFEAcA_xkOirG+3bnjTXi-t2RqesoyPL37jzqou8hF00YJ26Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 16 March 2017 at 18:59, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> I build-test the FreeBSD when I do migration pulls; given it's
> just a VM it's not too hard; my main reason is that I use it as
> a proxy that gives it a good chance to get past your MacOS build.

Yeah, I have no in principle objection to using a VM here. It's
just that the last couple of times I've tried it I've messed
around for an hour or so and failed to get a VM setup that
Just Works (ie serial console without graphics window, network
setup that doesn't expose the VM to the external network but still
lets me ssh into it, etc). If we don't have an externally
maintained machine we can use then I think good wiki documentation
on how to set up the VM locally is a minimum.

thanks
-- PMM
