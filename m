Received: from eggs.gnu.org ([2001:4830:134:3::10]:41425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fsklJ-0001AF-QF
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fsklE-0001It-Q8
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:14:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41188 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fsklE-0001Ie-Kq
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 04:14:32 -0400
Date: Thu, 23 Aug 2018 10:14:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180823101427.2c1275a7.cohuck@redhat.com>
In-Reply-To: <153496608036.29987.17320139395542439335.stgit@gimli.home>
References: <153496608036.29987.17320139395542439335.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] postcopy: Synchronize usage of the balloon
 inhibitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, borntraeger@de.ibm.com, dgilbert@redhat.com, quintela@redhat.com

On Wed, 22 Aug 2018 13:32:24 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> While the qemu_balloon_inhibit() interface appears rather general purpose,
> postcopy uses it in a last-caller-wins approach with no guarantee of balanced
> inhibits and de-inhibits.  Wrap postcopy's usage of the inhibitor to give it
> one vote overall, using the same last-caller-wins approach as previously
> implemented at the balloon level.
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Fixes: 01ccbec7bdf6 ("balloon: Allow multiple inhibit users")
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> Note that checkpatch.pl doesn't appreciate the initialization of the
> static variable to false, imo it improves the readability of the code
> in this instance, so I've left it.  Shout if you disagree.

I agree that it improves readability.

> 
> If this gets acks I can include it with a pull request for a couple
> other fixes to the original series.  Thanks
> 
>  migration/postcopy-ram.c |   18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
