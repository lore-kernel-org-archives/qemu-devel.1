Received: from eggs.gnu.org ([2001:4830:134:3::10]:39869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asn@redhat.com>) id 1eR4hI-0005DO-71
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 18:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asn@redhat.com>) id 1eR4hH-0008GL-Bi
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 18:19:48 -0500
From: Andreas Schneider <asn@redhat.com>
Date: Tue, 19 Dec 2017 00:19:36 +0100
Message-ID: <2123560.m7mx4i3f7h@magrathea.fritz.box>
In-Reply-To: <20171218213140.GT2787@redhat.com>
References: <20171115162648.30135-1-ptoscano@redhat.com>
	<16ae9efe-78df-2e59-39db-1570deba2847@redhat.com>
	<20171218213140.GT2787@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

On Monday, 18 December 2017 22:31:40 CET Richard W.M. Jones wrote:
> On Mon, Dec 18, 2017 at 01:43:39PM -0500, John Snow wrote:
> > Hi, friendly ping:
> > 
> > It's been over a month with no replies, so it's safe to say this has
> > gotten lost in the 2.11 release shuffle.
> > 
> > Recommend you re-send it for the 2.12 window.
> 
> Actually there is an interop problem with the ssh daemon on ESXi which
> I've not resolved yet.  Unfortunately there was no response to my
> upstream message about collecting debugging info:
> 
> https://www.libssh.org/archive/libssh/2017-12/0000000.html
> 
> Since liberating guests from VMware is a prime reason to have an ssh
> driver in qemu, I'd really like this to be fixed first ...

I responded to you mail, didn't you get it?

It looks like that their sftp server sent an invalid message.

Can you create libssh log and maybe also a pcap file?

https://git.libssh.org/projects/libssh.git/tree/examples/ssh_client.c#n308

See set_pcap() this will create a pcap file after decryption.



	Andreas
