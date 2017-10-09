Received: from eggs.gnu.org ([2001:4830:134:3::10]:41590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1ZvZ-0003i8-1W
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1ZvU-0007xP-DZ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:25:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e1ZvU-0007wy-6O
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:25:04 -0400
Date: Mon, 9 Oct 2017 16:24:57 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171009152457.GO2954@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1507133891-26013-1-git-send-email-ian.jackson@eu.citrix.com>
	<1507133891-26013-8-git-send-email-ian.jackson@eu.citrix.com>
	<877ew4ub3u.fsf@dusky.pond.sub.org>
	<23003.36902.664875.346194@mariner.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23003.36902.664875.346194@mariner.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: Markus Armbruster <armbru@redhat.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, xen-devel@nongnu.org

On Mon, Oct 09, 2017 at 04:05:10PM +0100, Ian Jackson wrote:
> Markus Armbruster writes ("Re: [Qemu-devel] [PATCH 7/8] os-posix: Provide new -runasid option"):
> > The last thing the QEMU command line needs is more exotic options.  Are
> > you sure we need a new one here?  Can we make existing -runas serve?
> > Precedence: Coreutils[*].  Pseudo-code:
> > 
> >     if argument is a decimal number starting with '+':
> >         user ID
> >     else if argument is a valid user name:
> >         user name
> >     else if argument is a valid user ID:
> >         user ID
> >     else:
> >         error
> 
> I can do this.  So -runas <uid>.<gid> then.  I don't think it makes
> sense to try to -runas <uid> because: you wouldn't have a username
> to pass to initgroups: not calling initgroups would be a bear trap;
> and otherwise we wouldn't know what gid to use.

Just use  getpwuid() to get the "struct passwd *", then change_process_uid()
doesn't need any changes at all AFAICT.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
