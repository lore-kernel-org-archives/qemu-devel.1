Received: from eggs.gnu.org ([2001:4830:134:3::10]:44669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSfZG-00008R-5H
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSfZC-0008FS-SY
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:58:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSfZC-0008FE-JM
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:58:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA314DD9CA
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 09:58:33 +0000 (UTC)
Date: Fri, 30 Nov 2018 09:58:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181130095830.GD8101@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181129180050.17797-1-pbonzini@redhat.com>
	<8fcdeb08-d87c-a236-de94-f5129aa3b99b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fcdeb08-d87c-a236-de94-f5129aa3b99b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] glib-compat: work around g_test_message
 bug with subprocess tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On Fri, Nov 30, 2018 at 01:08:29AM +0100, Paolo Bonzini wrote:
> On 29/11/18 19:00, Paolo Bonzini wrote:
> > Subprocesses are created by glib without leaving the file descriptors
> > open.  Therefore, g_test_message (and assertion failures, but those
> > trigger when things are going bad anyway) will think that it is writing
> > to the log file descriptor, but while actually stomping on the QMP
> > file descriptor or similar.  This causes spurious failures, which are
> > as nice to debug as the reader can imagine.  While I have opened a
> > pull request on GLib, this will probably take a while to propagate
> > to distros.
> > 
> > I found this while working on qgraph, but the fix is generic.
> 
> This is not a problem anymore if we switch from gtester to tap.  Do we
> want it fixed anyway or not?

IMHO the change to tap is not really something  we shoudl be doing
at this point in the release cycle. So I'd favour taking this fix
for 3.1, even if it becomes redundant when we switch to tap in 4.0


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
