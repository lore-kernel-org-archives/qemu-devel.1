Received: from eggs.gnu.org ([2001:4830:134:3::10]:41523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3ZBx-0008RY-I1
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:30:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3ZBw-0003mB-QK
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 22:30:01 -0400
Date: Thu, 27 Apr 2017 10:29:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170427022952.GI9205@lemon.lan>
References: <20170426033413.17192-1-famz@redhat.com>
	<20170426033413.17192-17-famz@redhat.com>
	<20170426124136.GE4538@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426124136.GE4538@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v15 16/21] file-posix: Add 'locking' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On Wed, 04/26 14:41, Kevin Wolf wrote:
> Am 26.04.2017 um 05:34 hat Fam Zheng geschrieben:
> > Making this option available even before implementing it will let
> > converting tests easier: in coming patches they can specify the option
> > already when necessary, before we actually write code to lock the
> > images.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block/file-posix.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index ade71db..2114720 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -392,6 +392,11 @@ static QemuOptsList raw_runtime_opts = {
> >              .type = QEMU_OPT_STRING,
> >              .help = "host AIO implementation (threads, native)",
> >          },
> > +        {
> > +            .name = "locking",
> > +            .type = QEMU_OPT_BOOL,
> > +            .help = "lock the file",
> > +        },
> >          { /* end of list */ }
> >      },
> >  };
> 
> I don't mind whether it happens in this patch or when the option is
> actually implemented, but this option needs to be added to the QAPI
> schema.

I will add it.

Fam
