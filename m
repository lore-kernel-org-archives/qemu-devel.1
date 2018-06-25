Received: from eggs.gnu.org ([2001:4830:134:3::10]:58268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fXNri-0006io-N2
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:32:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fXNrf-0008WV-Kn
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:32:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48794 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fXNrf-0008W2-G6
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:32:51 -0400
Date: Mon, 25 Jun 2018 10:32:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180625093246.GC2390@work-vm>
References: <bfc0c8da-0563-0115-955a-80f463389fa6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc0c8da-0563-0115-955a-80f463389fa6@oracle.com>
Subject: Re: [Qemu-devel] Why qom-get is not available in qemu monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, ricardo.perez_blanco@nokia.com, afaerber@suse.de

* Dongli Zhang (dongli.zhang@oracle.com) wrote:
> Hi,
> 
> Would you mind help confirm why qom-get command is not supported by qemu
> monitor, but only qapi?
> 
> Is this a feature (qom-get in monitor) totally useless for some reason, or it is
> still not implemented yet?

Just because it's not implemented; a few people have tried to implement
it (including me in 2016); but it tends to get stuck because some QOM objects
are more compelex than simple integer/strings and there didn't used
to be any way to print other objects out easily.

The most recent thing in this was Ricardo's 'Show values and description
when using "qom-list"' series.

Dave

> Thank you very much!
> 
> Dongli Zhang
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
