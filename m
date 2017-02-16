Received: from eggs.gnu.org ([2001:4830:134:3::10]:45518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ceJL3-0007xc-Ta
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ceJL0-0001U5-4e
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:31:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ceJKz-0001Tj-VA
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 05:30:58 -0500
Date: Thu, 16 Feb 2017 10:30:52 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170216103052.GE7346@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAMxP3BT90xgAGFhhMxaSz=3GA3Kd-6oiKNDc0C1bs8Msbnfb9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxP3BT90xgAGFhhMxaSz=3GA3Kd-6oiKNDc0C1bs8Msbnfb9w@mail.gmail.com>
Subject: Re: [Qemu-devel] Is it safe to replace files under
 /user/local/share in-flight?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bob Chen <a175818323@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, Feb 16, 2017 at 06:26:05PM +0800, Bob Chen wrote:
> I want to upgrade my qemu, is it safe to replace these ROM and keymap files
> in-flight while qemu processes are still running?

That essentially means the ROMS and the keymaps. The keymaps are safe
as those are loaded at initial startup only. I think the ROMs are safe
too, since again they are loaded during startup. The only caveat is
whether any boards re-load ROMs during a guest reboot ? I think probably
not, but not 100% sure.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
