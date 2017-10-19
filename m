Received: from eggs.gnu.org ([2001:4830:134:3::10]:57640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e56rz-0000s7-Ux
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:12:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e56rw-0000Y2-OK
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:12:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e56rw-0000XX-Go
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:12:00 -0400
Date: Thu, 19 Oct 2017 10:11:52 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171019091152.GD8408@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171016131644.9565-1-kraxel@redhat.com>
	<19f64376-dcae-7185-110f-9970299666b2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19f64376-dcae-7185-110f-9970299666b2@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/11] Ui 20171016 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Thu, Oct 19, 2017 at 08:50:02AM +0200, Thomas Huth wrote:
> On 16.10.2017 15:16, Gerd Hoffmann wrote:
> > The following changes since commit f90ea7ba7c5ae7010ee0ce062207ae42530f57d6:
> > 
> >   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20171012' into staging (2017-10-12 17:06:50 +0100)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kraxel.org/qemu tags/ui-20171016-pull-request
> > 
> > for you to fetch changes up to 2ff408de9c080f2fb5a94ebf6a209c6180c64933:
> > 
> >   gtk: fix wrong id between texture and framebuffer (2017-10-16 14:50:54 +0200)
> > 
> > ----------------------------------------------------------------
> > ui: use keycodemapdb for key code mappings, part one (v2)
> > ui: add qemu-keymap, update reverse keymaps (for qemu -k $map)
> > ui: fix for vte 0.50
> > ui: gtk texture fix
> 
> I just noticed that I now get the following warning message when I
> change to an older git branch:
> 
> warning: unable to rmdir ui/keycodemapdb: Directory not empty
> 
> ... this is kind of ugly, is there a way to fix this?

There's no way to automatically clean that up when switching to older
branches. You can do 'git submodule deinit -f ui/keycodemapdb' *before*
switching to the old branch, or just 'git submodule deinit -f --all'.

Having this stable submodule should be completely harmless though as
nothing in the older branch will be using it.  So IMHO just ignore the
warning message - its only ever going to be a very short term problem
for people until they rebase their branches to git master (aside from
those few people working on stable maint branches)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
