Received: from eggs.gnu.org ([2001:4830:134:3::10]:41596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cWkf0-0003H7-3X
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cWkew-0001eg-3u
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:04:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cWkev-0001eY-RF
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 09:04:18 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0QE47xc055824
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 09:04:16 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 287d2adkk1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 09:04:14 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 26 Jan 2017 14:03:43 -0000
Date: Thu, 26 Jan 2017 15:03:39 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <850aa48b-a5ea-782b-b245-5549ec5f08ea@redhat.com>
References: <1485436265-12573-1-git-send-email-thuth@redhat.com>
	<1485436265-12573-6-git-send-email-thuth@redhat.com>
	<195c3d94-9a9c-6e48-954c-b2769691929e@redhat.com>
	<850aa48b-a5ea-782b-b245-5549ec5f08ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170126150339.50ce5787.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 5/5] checkpatch: reduce MAINTAINERS
 update message frequency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Thu, 26 Jan 2017 14:39:35 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 26.01.2017 14:28, Paolo Bonzini wrote:
> > 
> > 
> > On 26/01/2017 14:11, Thomas Huth wrote:
> >> This is a port of the following commit from the Linux kernel:
> >>
> >> commit e0d975b1b439c4fef58fbc306c542c94f48bb849
> >> Author: Joe Perches <joe@perches.com>
> >> Date:   Wed Dec 10 15:51:49 2014 -0800
> >>
> >>     checkpatch: reduce MAINTAINERS update message frequency
> >>
> >>     When files are being added/moved/deleted and a patch contains an update to
> >>     the MAINTAINERS file, assume it's to update the MAINTAINERS file correctly
> >>     and do not emit the "does MAINTAINERS need updating?" message.
> >>
> >>     Reported by many people.
> >>
> >>     Signed-off-by: Joe Perches <joe@perches.com>
> >>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> >>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  scripts/checkpatch.pl | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> >> index e1be7b3..555a5b6 100755
> >> --- a/scripts/checkpatch.pl
> >> +++ b/scripts/checkpatch.pl
> >> @@ -1300,6 +1300,12 @@ sub process {
> >>  			}
> >>  		}
> >>  
> >> +# Check if MAINTAINERS is being updated.  If so, there's probably no need to
> >> +# emit the "does MAINTAINERS need updating?" message on file add/move/delete
> >> +		if ($line =~ /^\s*MAINTAINERS\s*\|/) {
> >> +			$reported_maintainer_file = 1;
> >> +		}
> >> +
> >>  # Check for added, moved or deleted files
> >>  		if (!$reported_maintainer_file && !$in_commit_log &&
> >>  		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
> >>
> > 
> > Maybe leave it as a warning given this change?
> 
> I think chances are high that it still pops up quite frequently with
> false positives:
> 
> 1) The above regex only triggers for patches that contain a diffstat. If
> you run the script on patches without diffstat, you always get the
> warning as soon as you add, delete or move a file, even if you update
> the MAINTAINERS file in the same patch.
> 
> 2) I think it is quite common in patch series to first introduce new
> files in the first patches, and then update MAINTAINERS only once at the
> end.
> 
> 3) The MAINTAINERS file often covers whole folders with wildcard
> expressions. So if you add/delete/rename a file within such a folder,
> you don't need to update MAINTAINERS thanks to the wildcard.
> 
> I guess people might be annoyed if checkpatch.pl throws a warning in
> these cases. So a "NOTE: ..." sounds more sane to me. But if you like,
> we can also start with a WARNING first and only ease it if people start
> to complain?

I'd vote for 'NOTE:'. I'm always a bit annoyed if checkpatch triggers
for a file already covered by 3) (which seems to be the most common
case for patches I've been involved with).
