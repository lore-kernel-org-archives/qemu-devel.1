Received: from eggs.gnu.org ([2001:4830:134:3::10]:54295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXQZg-0001Jm-Dt
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXQZa-0005Zp-Jj
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:58:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXQZW-0005Sg-PI
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:58:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181213122511.13853-1-kraxel@redhat.com>
Date: Thu, 13 Dec 2018 13:58:28 +0100
In-Reply-To: <20181213122511.13853-1-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Thu, 13 Dec 2018 13:25:11 +0100")
Message-ID: <877egda8i3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: use O_NOFOLLOW and O_CLOEXEC.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>, public@hansmi.ch, Prasad J Pandit <ppandit@redhat.com>

Gerd Hoffmann <kraxel@redhat.com> writes:

> Open files and directories with O_NOFOLLOW to avoid symlinks attacks.
> While being at it also add O_CLOEXEC.
>
> usb-mtp only handles regular files and directories and ignores
> everything else, so users should not see a difference.
>
> Because qemu ignores symlinks carrying out an successfull symlink attack
> requires swapping an existing file or directory below rootdir for a
> symlink and winning the race against the inotify notification to qemu.
>
> Note that the impact of this bug is rather low when qemu is managed by
> libvirt due to qemu running sandboxed, so there isn't much you can gain
> access to that way.
>
> Fixes: CVE-2018-pjp-please-get-one

Ah, looks like we've run out of numbers.

> Cc: Prasad J Pandit <ppandit@redhat.com>
> Cc: Bandan Das <bsd@redhat.com>
> Reported-by: Michael Hanselmann <public@hansmi.ch>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
