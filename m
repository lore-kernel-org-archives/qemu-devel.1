Received: from eggs.gnu.org ([2001:4830:134:3::10]:48207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gXQIU-0002zm-7q
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <public@hansmi.ch>) id 1gXQIO-0003m5-O4
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:40:58 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:57801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <public@hansmi.ch>) id 1gXQIO-0003cP-By
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:40:52 -0500
References: <20181213122511.13853-1-kraxel@redhat.com>
From: Michael Hanselmann <public@hansmi.ch>
Message-ID: <884c9b3d-1405-5175-750d-fb524b923763@msgid.hansmi.ch>
Date: Thu, 13 Dec 2018 13:40:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181213122511.13853-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: use O_NOFOLLOW and O_CLOEXEC.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad J Pandit <ppandit@redhat.com>, Bandan Das <bsd@redhat.com>

On 13.12.18 13:25, Gerd Hoffmann wrote:
> Open files and directories with O_NOFOLLOW to avoid symlinks attacks.
> While being at it also add O_CLOEXEC.
> 
> usb-mtp only handles regular files and directories and ignores
> everything else, so users should not see a difference.
> 
> Because qemu ignores symlinks carrying out an successfull symlink attack

Minor typo: s/successfull/successful/

> requires swapping an existing file or directory below rootdir for a
> symlink and winning the race against the inotify notification to qemu.
> 
> Note that the impact of this bug is rather low when qemu is managed by
> libvirt due to qemu running sandboxed, so there isn't much you can gain
> access to that way.
> 
> Fixes: CVE-2018-pjp-please-get-one
> Cc: Prasad J Pandit <ppandit@redhat.com>
> Cc: Bandan Das <bsd@redhat.com>
> Reported-by: Michael Hanselmann <public@hansmi.ch>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Thanks for the patch!

Reviewed-by: Michael Hanselmann <public@hansmi.ch>

Best regards,
Michael
