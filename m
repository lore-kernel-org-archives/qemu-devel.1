Received: from eggs.gnu.org ([2001:4830:134:3::10]:48190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUwZ5-0000Dp-Sm
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dUwZ2-00057B-MH
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:55:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dUwZ2-00056p-Fi
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:55:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D8854E4CB
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 14:54:59 +0000 (UTC)
Date: Tue, 11 Jul 2017 15:54:56 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170711145456.GT7116@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1496132443.git.mprivozn@redhat.com>
	<d627afbc-5cd8-d831-d089-d1fb30fbfdfd@redhat.com>
	<03f93e78-b585-6d01-2c63-5de8dac97abe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03f93e78-b585-6d01-2c63-5de8dac97abe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix qemu-bridge-helper with SUID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>

On Tue, Jul 11, 2017 at 03:10:43PM +0200, Michal Privoznik wrote:
> On 06/22/2017 05:58 PM, Michal Privoznik wrote:
> > On 05/30/2017 10:23 AM, Michal Privoznik wrote:
> >> For more description see patch 3. Long story short, if the bridge helper runs
> >> with SUID, the mechanism we rely on (DAC denying access to ACL files) does not
> >> work.
> >>
> >> Michal Privoznik (3):
> >>   qemu-bridge-helper: Reverse return value setting logic
> >>   qemu-bridge-helper: Reverse return value setting logic in
> >>     parse_acl_file
> >>   qemu-bridge-helper: Take ACL file gid into account
> >>
> >>  qemu-bridge-helper.c | 79 ++++++++++++++++++++++++++++------------------------
> >>  1 file changed, 42 insertions(+), 37 deletions(-)
> >>
> > 
> > ping?
> > 
> 
> ping^2?

Sigh, this is one of the files for which we have no nominated maintainer
listed, so it easily falls through the cracks.

Since this is network related, I wonder if Jason should be listed in the
MAINTAINERS file for this. Or perhaps we should move the qemu-bridge-helper.c
file into the net/ sub-directory instead ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
