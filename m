Received: from eggs.gnu.org ([209.51.188.92]:58682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1aww-0002Qb-1w
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1awv-0003m1-E3
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 13:07:26 -0500
Date: Wed, 6 Mar 2019 19:07:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190306180709.GL6818@localhost.localdomain>
References: <1551694120-768127-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1551694120-768127-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<20190306145132.GH6818@localhost.localdomain>
	<415d46bc-5b5a-fc1a-1b5c-6fc3dd2a73cc@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415d46bc-5b5a-fc1a-1b5c-6fc3dd2a73cc@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] iotests: ask QEMU for supported formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Roman Kagan <rkagan@virtuozzo.com>

Am 06.03.2019 um 18:59 hat Andrey Shinkevich geschrieben:
> On 06/03/2019 17:51, Kevin Wolf wrote:
> > This fixes it for me (the first hunk is actually a bonus which fixes a
> > preexisting bug, which somehow meant that the reason was not printed):
> > 
> > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> > index e6ae4e91b7..b41ac4be51 100644
> > --- a/tests/qemu-iotests/iotests.py
> > +++ b/tests/qemu-iotests/iotests.py
> > @@ -712,7 +712,7 @@ def notrun(reason):
> >       # Each test in qemu-iotests has a number ("seq")
> >       seq = os.path.basename(sys.argv[0])
> > 
> > -    open('%s/%s.notrun' % (output_dir, seq), 'wb').write(reason + '\n')
> > +    open('%s/%s.notrun' % (output_dir, seq), 'wt').write(reason + '\n')
> >       print('%s not run: %s' % (seq, reason))
> >       sys.exit(0)
> > 
> 
> Thanks a lot. I am going to add the fix above as a separate patch in v3
> with "Signed-off-by: Kevin Wolf <kwolf@redhat.com>"

Sounds good to me, thanks!

Kevin
