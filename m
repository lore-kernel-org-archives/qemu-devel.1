Received: from eggs.gnu.org ([2001:4830:134:3::10]:41802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dG540-0000rf-2r
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:57:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dG53z-0001XI-9b
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:57:32 -0400
Date: Wed, 31 May 2017 16:57:20 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170531145720.lc5tlssve5eeyyf4@eukaryote>
References: <20170529190322.xc2e2uh7wp6hlcs6@eukaryote>
	<w514lw22y70.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w514lw22y70.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [RFC] Making 'block-stream',
 and 'block-commit' accept node-name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, May 30, 2017 at 04:53:23PM +0200, Alberto Garcia wrote:
> On Mon 29 May 2017 09:03:22 PM CEST, Kashyap Chamarthy wrote:
> 
> > Observe the following ('qmp-shell', for brevity) invocation of the
> > four major types (stream, commit, mirror, backup) of live block
> > operations:
> >
> >     (QEMU) block-stream device=node-D base=a.qcow2 job-id=job-block-stream
> >     (QEMU) block-commit device=node-D base=a.qcow2 top=b.qcow2 job-id=job-block-commit
> >     (QEMU) drive-mirror device=node-D target=e.qcow2 sync=full job-id=job-drive-mirror
> >     (QEMU) drive-backup device=node-D sync=full target=e.qcow2 job-id=job-drive-backup
> >     (QEMU) blockdev-backup device=node-B target=node-E sync=full job-id=job-blockdev-backup
> >     (QEMU) blockdev-mirror device=node-D target=node-E sync=full job-id=job-blockdev-mirror
> >
> > While we have `blockdev-{mirror, backup}` as 'node-name'-alternatives
> > for `drive-{mirror, backup}`, as the eagle-eyed will, the
> > `block-stream` and `block-commit` commands still operate on file names
> > for parameters 'base' and 'top'.
> 
> block-stream does accept a node name for the top and base images (see
> 554b614765090f47d and 312fe09cc8af86c).

Ah, I didn't realize `block-stream` accepts 'node-name' for 'base' and
'top'.  Thanks for the pointers.

But still, I wonder, for consistency's sake: will a new
`blockdev-{stream, commit}` ever be created.

> block-commit hasn't changed, but it should be possible to follow a
> similar approach.

Noted.

[...]

-- 
/kashyap
