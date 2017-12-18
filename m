Received: from eggs.gnu.org ([2001:4830:134:3::10]:53235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eQt6h-00084a-H4
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eQt6d-0005vz-QH
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:57:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eQt6d-0005vQ-JW
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:57:11 -0500
Date: Mon, 18 Dec 2017 10:57:04 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171218105704.GD13493@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CABMrAhLV6LLwBR70-P4EnekWHKD4AkaatzxQwuxtOnNYQ3MEqQ@mail.gmail.com>
	<20171215135738.GF11724@redhat.com>
	<CABMrAhLGAm60AgMjbaKSd3k=oX7J6DVO-DwwW04RE75mEWqhCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABMrAhLGAm60AgMjbaKSd3k=oX7J6DVO-DwwW04RE75mEWqhCQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Key code conflict in keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Miika S <miika9764@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On Fri, Dec 15, 2017 at 10:03:31PM +0200, Miika S wrote:
> Ok, I don't know if there is a separate place where to send patches
> for keycodemapdb but I will put it in this reply. I will send a new
> set of patches for the QEMU changes that were in the first mail
> (hopefully in a better format than this one) and also a fix for mouse
> wheel event being sent twice.

keycodemapdb patches can be sent as a pull request to the master upstream
repo  https://gitlab.com/keycodemap/keycodemapdb/merge_requests

That said, I watch for patches sent to gtk-vnc/qemu/libvirt/spice-gtk
lists that cover keycodemapdb, so I have applied your patch to the
upstream.

When sending your updated qemu patch, don't forget to include the
keycodemapdb git submodule update to the hash containing your change
05dad417e9d0b37ee1fba33056d91a6b734b3357

You can do this as follows

  cd $YOUR-QEMU-CHECKOUT
  cd ui/keycodemapdb
  git pull
  cd ../..
  git add ui/keycodemapdb


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
