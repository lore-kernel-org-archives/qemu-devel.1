Received: from eggs.gnu.org ([2001:4830:134:3::10]:58110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e56tA-0001s1-MS
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e56t7-0001gr-E6
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:13:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e56t7-0001fM-7Y
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:13:13 -0400
Date: Thu, 19 Oct 2017 10:13:08 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171019091308.GE8408@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171016131644.9565-1-kraxel@redhat.com>
	<19f64376-dcae-7185-110f-9970299666b2@redhat.com>
	<1508397252.10073.10.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1508397252.10073.10.camel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/11] Ui 20171016 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On Thu, Oct 19, 2017 at 09:14:12AM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > I just noticed that I now get the following warning message when I
> > change to an older git branch:
> > 
> > warning: unable to rmdir ui/keycodemapdb: Directory not empty
> > 
> > ... this is kind of ugly, is there a way to fix this?
> 
> Hmm, no good idea, other than just rebasing the branch to latest
> master.  It's one of the issues with submodules.
> 
> Related issue shows up if you go back to an older branch after a
> firmware update.  git shows the firmware submodule as modified then and
> you have to take care that you don't revert the change by accident. 
> Which can easily happen with "git commit -a" ...

If you do a 'make' before committing though the configure code will take
care to re-sync submodules, helping to avoid this problem going forward.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
