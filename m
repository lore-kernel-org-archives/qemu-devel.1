Received: from eggs.gnu.org ([2001:4830:134:3::10]:39044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cxt4e-0006yM-LR
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:31:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1cxt4d-00049d-PY
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:31:00 -0400
Date: Tue, 11 Apr 2017 12:30:49 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20170411103049.dqjkpgjszaqb5xn3@eukaryote>
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
	<0e1c78f3-1b82-58e4-035e-944484e66f29@redhat.com>
	<ef9e10c4-3986-32ba-da2d-1b8f71d58319@redhat.com>
	<20170404132815.aactqo2o5izpzclf@eukaryote>
	<8420253d-261f-f040-6815-c949b8a2cce2@redhat.com>
	<877f2rcmbf.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877f2rcmbf.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [Qemu-block] Making QMP 'block-job-cancel'
 transactionable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, Apr 11, 2017 at 11:42:28AM +0200, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > On 04/04/2017 08:28 AM, Kashyap Chamarthy wrote:
> >
> >>> Minor or not, it is a useful viewpoint. Either way, as long as the new
> >>> way of getting a transactional non-pivot successful completion is
> >>> something that libvirt can learn via introspection, 
> >> 
> >> Can you elaborate a little more on the above, for my own edification --
> >> how might it be possible for "libvirt can learn via introspection"?  Is
> >> it via some method using the QMP 'query-commands' /
> >> 'query-command-line-options'?
> >
> > Those, and query-qmp-schema.
> 
> Avoid query-command-line-options if you can.  If you can't, know its
> limitations and quirks.

Thanks; I actually meant to mention 'query-qmp-schema' (thanks to Eric
for correcting).  And I didn't fortet your reminder of the
incompleteness / limitations of 'query-command-line-options' from your
KVMForum 2015 presentation :-)

> 
> >                               If the change includes the addition of
> > something new in the .json files describing QMP, then query-qmp-schema
> > will let libvirt probe whether the version of qemu it it talking to has
> > that new field or not (presumably, in this case it would be a new
> > optional bool member to select the mode when creating a job, as well as
> > a new command visible through query-commands to change the mode of a
> > running job).

-- 
/kashyap
