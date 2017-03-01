Received: from eggs.gnu.org ([2001:4830:134:3::10]:41309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cj44A-00049o-LT
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cj446-0007vl-Bx
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:13:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cj446-0007vf-5d
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 08:13:10 -0500
Date: Wed, 1 Mar 2017 13:13:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170301131303.GE2429@work-vm>
References: <20170228124056.5074-1-dgilbert@redhat.com>
	<CAFEAcA9M4-ghtYHTaSYPDuDjEECbJ_NTQMR_d4X03hgqBBr-3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9M4-ghtYHTaSYPDuDjEECbJ_NTQMR_d4X03hgqBBr-3A@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/27] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, pasic@linux.vnet.ibm.com, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Ashijeet Acharya <ashijeetacharya@gmail.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, danielhb@linux.vnet.ibm.com

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 28 February 2017 at 12:40, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > The following changes since commit 6181478f6395cdd9d6ffd99623d0c9f39ea53606:
> >
> >   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-02-28 08:46:03 +0000)
> >
> > are available in the git repository at:
> >
> >   git://github.com/dagrh/qemu.git tags/pull-migration-20170228a
> >
> > for you to fetch changes up to 665414ad06aa1bc92e615db9641e58fb13d07de1:
> >
> >   postcopy: Add extra check for COPY function (2017-02-28 11:30:24 +0000)
> >
> > ----------------------------------------------------------------
> > Migration pull
> >
> > Note: The 'postcopy: Update userfaultfd.h header' is part of
> > Paolo's header update and will disappear if applied after it.
> 
> Is that a linux-headers update not done via the update script? :-(

It was in earlier version of my patchset, but I replaced it by 
Paolo's update that he made via the script; the one in the pull
should be identical to Paolo's change - but just the userfaultfd.h
change.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
