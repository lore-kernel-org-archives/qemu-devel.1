Received: from eggs.gnu.org ([2001:4830:134:3::10]:40807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQpwv-0005wz-4T
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:07:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQpwr-0002LN-29
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:07:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQpwq-0002Kq-SN
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:07:08 -0400
Date: Thu, 7 Jun 2018 16:06:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180607080650.GD750@xz-mi>
References: <20180531051641.8473-1-peterx@redhat.com>
	<20180531051641.8473-2-peterx@redhat.com>
	<6dd1d7db-a056-95d3-0cad-b86ff35d18e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6dd1d7db-a056-95d3-0cad-b86ff35d18e8@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 1/4] docs: mention shared state protect
 for OOB
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

On Thu, May 31, 2018 at 09:06:05AM -0500, Eric Blake wrote:
> On 05/31/2018 12:16 AM, Peter Xu wrote:
> > Out-Of-Band handlers need to protect shared state if there is any.
> > Mention it in the document.
> > 
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   docs/devel/qapi-code-gen.txt | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> > index b9b6eabd08..aafc15f100 100644
> > --- a/docs/devel/qapi-code-gen.txt
> > +++ b/docs/devel/qapi-code-gen.txt
> > @@ -680,6 +680,9 @@ OOB command handlers must satisfy the following conditions:
> >   - It does not invoke system calls that may block,
> >   - It does not access guest RAM that may block when userfaultfd is
> >     enabled for postcopy live migration.
> > +- It needs to protect possilbe shared states, since as long as a
> 
> s/possilbe/possible/
> s/states/state/
> 
> or even 'protect any shared state'

Fixed.

-- 
Peter Xu
