Received: from eggs.gnu.org ([2001:4830:134:3::10]:60352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eEG4W-00089p-RN
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eEG4U-0005pf-91
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:50:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eEG4U-0005pY-30
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:50:46 -0500
Date: Mon, 13 Nov 2017 14:50:41 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171113145041.GI18828@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <03123F70-98FA-439A-868C-855E63916259@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03123F70-98FA-439A-868C-855E63916259@gmail.com>
Subject: Re: [Qemu-devel] Command-line option to change ungrab key(s)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Nov 13, 2017 at 09:29:25AM -0500, Programmingkid wrote:
> Would you accept a patch that allows the user to change the mouse ungrab key(s) in QEMU?
> 
> It would look something like this: 
> 
> -ungrab <key> 
> 
> or 
> 
> -ungrab <key>,<key>,...
> 
> If the user wanted the F19 key to be the ungrab key, this is what would be sent to QEMU:
> 
> -ungrab F19
> 
> If the user wanted F16 and F17 held down to ungrab the mouse, this is what would be sent to QEMU:
> 
> -ungrab F16,F17
> 
> 
> Would this feature be something you would consider adding to QEMU?

As context, virt-manager allows customization for the ungrab sequence, and
so do spice-gtk/gtk-vnc at the API level. So conceptually I think it is
reasonable for any UI console that is intended as more than just a toy.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
