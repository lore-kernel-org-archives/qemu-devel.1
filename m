Received: from eggs.gnu.org ([2001:4830:134:3::10]:40989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cst43-0000Hn-1r
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:29:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cst42-0007O7-BN
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:29:43 -0400
Date: Tue, 28 Mar 2017 17:29:34 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170328152934.rebdzsjfsfc6ajrh@eukaryote>
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
	<6fb77120-dcab-042f-bb51-20ccbaa38354@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fb77120-dcab-042f-bb51-20ccbaa38354@redhat.com>
Subject: Re: [Qemu-devel] Making QMP 'block-job-cancel' transactionable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, Mar 28, 2017 at 09:49:40AM -0500, Eric Blake wrote:
> On 03/24/2017 07:34 AM, Kashyap Chamarthy wrote:
> > While debugging some other issue, I happened to stumble across an old
> > libvirt commit[*] that adds support for pivot (whether QEMU should
> > switch to a target copy or not) operation as a result of issuing QMP
> > 'block-job-cancel' to a 'drive-mirror' (in libvirt parlance, "block
> > copy").
> > 
> > In the libvirt commit message[*] Eric Blake writes:
> > 
> >     "[...] There may be potential improvements to the snapshot code to
> >     exploit block copy over multiple disks all at one point in time.
> >     And, if 'block-job-cancel' were made part of 'transaction', you
> >     could copy multiple disks at the same point in time without pausing
> >     the domain. [...]"
> > 
> > I realize that 'block-job-cancel' is currently not part of the
> > @TransactionAction.  Is it worthwhile to do so?
> 
> Yes, it is still worthwhile to make that improvement, although it is
> now 2.10 material.

Thanks for looking, didn't imply that it's for 2.9 (which is in Release
Candidate phase) -- I realize most people are busy with it.  Further
discussion could be had when 2.10 tree opens up.

[...]

-- 
/kashyap
