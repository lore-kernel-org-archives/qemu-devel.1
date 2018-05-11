Received: from eggs.gnu.org ([2001:4830:134:3::10]:44282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fHBlR-0006sl-Sm
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:23:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fHBlM-0004oY-SR
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:23:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33188 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fHBlM-0004oK-NR
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:23:24 -0400
Date: Fri, 11 May 2018 20:23:22 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180511202212-mutt-send-email-mst@kernel.org>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-37-git-send-email-mst@redhat.com>
	<87o9hq8hcs.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o9hq8hcs.fsf@secure.laptop>
Subject: Re: [Qemu-devel] [PATCH 36/67] migration: add include directory
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, May 08, 2018 at 02:25:07PM +0200, Juan Quintela wrote:
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > This way they are easier to find using standard rules.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Nack.
> 
> This are _internal_ files, that shouldn't be used anywere elese.
> 
> Except .... that we need them to write tests.  We only have two scopes
> on qemu:
> - internal: only for the subsystem we are at in
> - pubilc: they can be used everywhere
> 
> So, tests came in a strange class here, because they need internal
> implementation, but they are not in the proper directory due to the way
> we do tests.
> I *think* that using complete paths is the only reasonable way of doing
> this.
> 
> Thanks, Juan.

So how about tests include internal headers in a special way then?

#include "../migration/foo.h" works but makes it clear
something unusual is going on.
