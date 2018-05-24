Received: from eggs.gnu.org ([2001:4830:134:3::10]:57037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLsgR-0005YK-Py
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLsgM-0004oS-2n
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:01:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55556 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLsgL-0004oA-UZ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:01:38 -0400
Date: Thu, 24 May 2018 19:01:36 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180524190123-mutt-send-email-mst@kernel.org>
References: <1527176250-178968-1-git-send-email-mst@redhat.com>
	<d0edcb79-3dae-c3a5-f9f4-50b3062f8cff@redhat.com>
	<70262dde-3b96-b650-f0fb-8143e869c4ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70262dde-3b96-b650-f0fb-8143e869c4ab@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/1] libqtest: add more exit status
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>

On Thu, May 24, 2018 at 11:00:19AM -0500, Eric Blake wrote:
> On 05/24/2018 10:52 AM, Eric Blake wrote:
> 
> > Also, since waitpid() can only return either s->qemu_pid or -1 as we
> > aren't using WNOHANG, it may also be worth asserting that if pid == -1,
> > we either have EAGAIN (but why aren't we looping in that case?) or
> > ECHILD.
> 
> I meant EINTR, not EAGAIN.  But in general, using waitpid() to collect
> process status without doing it in a loop is risky.

Interesting. Risky how?

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
