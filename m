Received: from eggs.gnu.org ([2001:4830:134:3::10]:54148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eNF4F-0005qM-7T
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eNF4E-0005uz-As
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 04:35:39 -0500
Date: Fri, 8 Dec 2017 10:35:21 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171208093521.ebdrrzorxn4tpyvo@eukaryote>
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
	<cd0a2e5e-f788-0e5a-dec7-f428479f3b89@virtuozzo.com>
	<8c61f43c-5f56-8c1b-a2fe-f954d34dc687@redhat.com>
	<40392ab9-ec2a-30ed-ddab-a557682a4192@virtuozzo.com>
	<4e4e28d7-aebc-4a86-e691-99afdcca27f5@redhat.com>
	<20171121172324.GC11073@localhost.localdomain>
	<1a8e9d48-5be1-e014-41ee-a1164f32dd17@redhat.com>
	<20171207115648.5mnvoyfnig7dhgbn@eukaryote>
	<20171207173304.GB3881@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171207173304.GB3881@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.12 0/4] qmp dirty bitmap
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, famz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mnestratov@virtuozzo.com, armbru@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com

On Thu, Dec 07, 2017 at 06:33:04PM +0100, Kevin Wolf wrote:
> Am 07.12.2017 um 12:56 hat Kashyap Chamarthy geschrieben:

[...]

> > So from the above interesting discussion, it seems like Kevin is leaning
> > towards a single job type that offers 'stream', 'commit', 'backup', and
> > 'mirror' functionality as part of a single command / job type.  Based on
> > an instinct, this sounds a bit too stuffy and complex to me.
> > 
> > And John seems to be leaning towards two block device job types:
> > 
> >   - 'blockdev-foo' that offers both current 'stream' and 'commit'
> >     functionality as two different options to the same QMP command; and
> > 
> >   - 'blockdev-bar' will offer both 'mirror' and 'backup' functionality
> >     as part of the same QMP command
> > 
> > FWIW, this seems a bit more palatable, as it is unifying
> > similar-functionality-that-differ-slightly into two distinct commands.

[...]

> Commit of the active layer is _already_ a mirror job internally (and not
> a stream job). 

I see; didn't realize the above.  I learn that it is the case so for a
long time, and came in via the commit 20a63d2 ("commit: Support commit
active layer").  For my own education, I went looking into
qemu/block/mirror.c, and noticed the variable 'commit_active_job_driver'
(of type BlockJobDriver), which is used in the function:
commit_active_start(). 

Thanks for the pointer.

> It's pretty clear to me that commit and mirror are almost
> the same, backup is pretty similar. Stream is somewhat different and
> might make more sense as a separate job type.

Yep, understood.

-- 
/kashyap
