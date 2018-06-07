Received: from eggs.gnu.org ([2001:4830:134:3::10]:40992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQpyC-0006Zu-MJ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQpyB-0003VK-SF
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:08:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59894 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQpyB-0003Ur-M2
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:08:31 -0400
Date: Thu, 7 Jun 2018 16:08:13 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180607080813.GE750@xz-mi>
References: <20180531051641.8473-1-peterx@redhat.com>
	<20180531051641.8473-4-peterx@redhat.com>
	<2ed65040-ddce-653e-c7c5-1d0b02c91e08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ed65040-ddce-653e-c7c5-1d0b02c91e08@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 3/4] monitor: remove "x-oob",
 turn oob on by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, May 31, 2018 at 09:44:46AM -0500, Eric Blake wrote:
> On 05/31/2018 12:16 AM, Peter Xu wrote:
> > There was a regression reported by Eric Auger before with OOB:
> > 
> >    http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html
> > 
> > The fix is 951702f39c ("monitor: bind dispatch bh to iohandler context",
> > 2018-04-10), which is in master already.
> 
> s/, which is in master already//
> 
> (when reading the git log, it can be assumed that any commit id referenced
> is already in master)

Fixed.

-- 
Peter Xu
