Received: from eggs.gnu.org ([2001:4830:134:3::10]:55863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gXUT3-0000fJ-1X
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gXUSz-0003NJ-Tj
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:08:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gXUSz-0003Lj-LM
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:08:05 -0500
Date: Thu, 13 Dec 2018 22:37:55 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <877egda8i3.fsf@dusky.pond.sub.org>
Message-ID: <nycvar.YSQ.7.76.1812132233490.12493@xnncv>
References: <20181213122511.13853-1-kraxel@redhat.com>
	<877egda8i3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Bandan Das <bsd@redhat.com>, public@hansmi.ch

  Hello Gerd,

+-- On Thu, 13 Dec 2018, Markus Armbruster wrote --+
| Gerd Hoffmann <kraxel@redhat.com> writes:
| > Open files and directories with O_NOFOLLOW to avoid symlinks attacks.
| > While being at it also add O_CLOEXEC.
| >
| > usb-mtp only handles regular files and directories and ignores
| > everything else, so users should not see a difference.
| >
| > Because qemu ignores symlinks carrying out an successfull symlink attack

   symlinks, carrying out a successful ...

| > requires swapping an existing file or directory below rootdir for a
| > symlink and winning the race against the inotify notification to qemu.
| >
| > Note that the impact of this bug is rather low when qemu is managed by
| > libvirt due to qemu running sandboxed, so there isn't much you can gain
| > access to that way.
| >
| > Fixes: CVE-2018-pjp-please-get-one
| 
| Ah, looks like we've run out of numbers.

Heh..:)

It's CVE-2018-16872. Thank you so much for the fix patch.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
