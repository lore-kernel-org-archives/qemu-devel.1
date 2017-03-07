Received: from eggs.gnu.org ([2001:4830:134:3::10]:44298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1clHJM-0006p8-M6
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:46:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1clHJL-00044E-FE
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:46:04 -0500
Date: Tue, 7 Mar 2017 15:45:53 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170307154553.GN15368@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-8-berrange@redhat.com>
	<18af21b2-42ed-e037-ab30-a88302d5e0e8@redhat.com>
	<d0003c78-9b17-ba2f-ca55-ef4a64ef1e8d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0003c78-9b17-ba2f-ca55-ef4a64ef1e8d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 07/18] iotests: fix 097 when run with
 qcow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, Mar 07, 2017 at 09:44:02AM -0600, Eric Blake wrote:
> On 02/22/2017 05:46 PM, Eric Blake wrote:
> > On 02/21/2017 05:55 AM, Daniel P. Berrange wrote:
> >> The previous commit:
> >>
> >>   commit a3e1505daec31ef56f0489f8c8fff1b8e4ca92bd
> >>   Author: Eric Blake <eblake@redhat.com>
> >>   Date:   Mon Dec 5 09:49:34 2016 -0600
> >>
> >>     qcow2: Don't strand clusters near 2G intervals during commit
> >>
> >> extended the 097 test case so that it did two passes, once
> >> with an internal snapshot, once without.
> >>
> >> qcow (v1) does not support internal snapshots, so this change
> >> broke test 097 when run against qcow.
> >>
> >> This splits 097 in two, creating a new 173 that tests the
> 
> 173 is wrong, and 175 is now taken.
> 
> >> internal snapshot codepath, effectively putting 097 back
> >> to its content before the above commit.
> >>
> >> Reviewed-by: Max Reitz <mreitz@redhat.com>
> >> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> >> ---
> >>  tests/qemu-iotests/097     |  10 +---
> >>  tests/qemu-iotests/097.out | 125 ++------------------------------------------
> >>  tests/qemu-iotests/175     | 126 +++++++++++++++++++++++++++++++++++++++++++++
> >>  tests/qemu-iotests/175.out | 119 ++++++++++++++++++++++++++++++++++++++++++
> 
> I'll be incorporating this patch into my series on blkdebug
> improvements, as I have a further enhancement (to both 97 and what is
> now 176) to cover an image that is not cluster-aligned.  You may want to
> rebase the rest of your series (which adds two more tests) on top of
> that posting.
> 
> > I used 175 in v5 of my blkdebug series, but Kevin had comments that are
> > worth me respinning, so I'm rebasing mine to use 176.
> > https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03049.html
> 
> Particularly since my blkdebug series will now be using 177.

/me can't help thinking that we should being giving tests names instead
of numbers so we avoid the frequent clashes between people's series :-)

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
