Received: from eggs.gnu.org ([2001:4830:134:3::10]:54031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOhrC-0005j3-Ug
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOhr8-0007Gr-30
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:27:42 -0500
Message-ID: <1483520890.5670.50.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 04 Jan 2017 10:08:10 +0100
In-Reply-To: <1479749115-21932-1-git-send-email-thuth@redhat.com>
References: <1479749115-21932-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] ui/vnc: Fix problem with sending too many
 bytes as server name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Mo, 2016-11-21 at 18:25 +0100, Thomas Huth wrote:
> If the buffer is not big enough, snprintf() does not return the number
> of bytes that have been written to the buffer, but the number of bytes
> that would be needed for writing the whole string. By using this value
> for the following vnc_write() calls, we send some junk at the end of
> the name in case the qemu_name is longer than 1017 bytes, which could
> confuse the VNC clients. Fix this by adding an additional size check
> here.

Added to ui queue.

thanks,
  Gerd
