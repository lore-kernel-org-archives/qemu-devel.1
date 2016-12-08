Received: from eggs.gnu.org ([2001:4830:134:3::10]:53963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEyUk-0007AI-VE
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEyUf-0006Mo-3k
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:12:18 -0500
Date: Thu, 8 Dec 2016 14:12:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161208131204.GB3891@noname.str.redhat.com>
References: <20161208124103.9813-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161208124103.9813-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] Remove need for -iscsi
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Pino Toscano <ptoscano@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, jtc@redhat.com

Am 08.12.2016 um 13:41 hat Daniel P. Berrange geschrieben:
> This small series removes the need for using the -iscsi argument
> by directly supporting all the -iscsi options against the block
> device config eg instead of
> 
> $QEMU \
>   -object secret,id=sec0,data=123456 \
>   -drive driver=iscsi,file=iscsi://catbus/iqn.fedora:kvm/2 \
>   -iscsi initiator-name=fish,user=test,password-secret=sec0,timeout=234 
> 
> you can now do it all against -drive
> 
> $QEMU \
>   -object secret,id=sec0,data=123456 \
>   -drive driver=iscsi,file=iscsi://catbus/iqn.fedora:kvm/2,\
>          initiator-name=fish,user=test,password-secret=sec0,timeout=234 
> 
> This fixes the problem that you cannot associate -drive instances
> with -iscsi args reliably due to IQNs containing chracters that
> QEMU forbids in QemuOpts ID strings.
> 
> Pino had previously sent a patch to do this for initiator-name
> back in the 2.6 dev cycle
> 
>   https://lists.nongnu.org/archive/html/qemu-block/2016-04/msg00246.html
> 
> This series supports all the -iscsi option names, except for
> 'password' which is intentionally left out as it is insecure
> and replaced by 'password-secret'.

I actually do the same as part of my iscsi for blockdev-add series,
which I guess I better should have sent as an RFC even if it's yet
untested to save you the work...

As I do more on top of just converting -iscsi, I would prefer using my
patches even if you posted yours first.

Kevin
