Received: from eggs.gnu.org ([2001:4830:134:3::10]:39758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eR30t-0003nx-AZ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1eR30s-0002Sx-ER
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:31:55 -0500
Date: Mon, 18 Dec 2017 21:31:40 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20171218213140.GT2787@redhat.com>
References: <20171115162648.30135-1-ptoscano@redhat.com>
	<16ae9efe-78df-2e59-39db-1570deba2847@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16ae9efe-78df-2e59-39db-1570deba2847@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] ssh: switch from libssh2
 to libssh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, asn@redhat.com

On Mon, Dec 18, 2017 at 01:43:39PM -0500, John Snow wrote:
> Hi, friendly ping:
> 
> It's been over a month with no replies, so it's safe to say this has
> gotten lost in the 2.11 release shuffle.
> 
> Recommend you re-send it for the 2.12 window.

Actually there is an interop problem with the ssh daemon on ESXi which
I've not resolved yet.  Unfortunately there was no response to my
upstream message about collecting debugging info:

https://www.libssh.org/archive/libssh/2017-12/0000000.html

Since liberating guests from VMware is a prime reason to have an ssh
driver in qemu, I'd really like this to be fixed first ...

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
