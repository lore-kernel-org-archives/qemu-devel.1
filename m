Received: from eggs.gnu.org ([2001:4830:134:3::10]:47426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqM3W-00057U-By
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqM3S-0004Sv-C2
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:27:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44266 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fqM3S-0004SW-4o
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:27:26 -0400
Date: Thu, 16 Aug 2018 18:27:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180816172722.GK23515@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
Subject: Re: [Qemu-devel] Pipe key broken on US keyboards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Phillip Susi <psusi@ubuntu.com>
Cc: qemu-devel@nongnu.org

On Thu, Aug 16, 2018 at 01:11:05PM -0400, Phillip Susi wrote:
> Hello, I recently upgraded my Xen server from Ubuntu 16.04 to 18.04 and
> am no longer able to type a | over vnc to the xen vms.  When I press \
> it works, but when I hold down shift and press \ which should generate a
> |, the vm sees the scan code for some key that the keymap thinks should
> sit between left shift and Z, but does not exist on US keyboards, and
> that scan code produces a > when combined with shift.  I'm betting it
> was this commit that broke it:
> 
> commit ab8f9d49d62c82a12409475547e4420a46da56ed
> Author: Daniel P. Berrange <berrange@redhat.com>
> Date:   Wed Jan 17 16:41:15 2018 +0000
> 
>     hw: convert ps2 device to keycodemapdb
> 
>     Replace the qcode_to_keycode_set1, qcode_to_keycode_set2,
>     and qcode_to_keycode_set3 tables with automatically
>     generated tables.
> 
> Any ideas?

Did you actually 'git bisect' to that commit, or is that just a guess ?

If not, could you 'git bisect' to confirm the actual commit, as there
have been lots of changes in this area.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
