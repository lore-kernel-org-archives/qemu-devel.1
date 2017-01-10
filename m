Received: from eggs.gnu.org ([2001:4830:134:3::10]:55029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQvb0-00062m-SJ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQvaw-0004j0-0M
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:32:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cQvav-0004id-RZ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:32:05 -0500
Message-ID: <1484051519.19018.87.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Jan 2017 13:31:59 +0100
In-Reply-To: <1484039965-25907-1-git-send-email-rami.rosen@intel.com>
References: <1484039965-25907-1-git-send-email-rami.rosen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] ui: fix format specfier in vnc to avoid
 break in build.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rami Rosen <rami.rosen@intel.com>
Cc: qemu-devel@nongnu.org

On Di, 2017-01-10 at 11:19 +0200, Rami Rosen wrote:
> When building qemu after setting _VNC_DEBUG to 1 (see ui/vnc.h),
> we get the following error and the build breaks:
> ...
> ui/vnc.c: In function =E2=80=98vnc_client_io_error=E2=80=99:
> ui/vnc.c:1262:13: error: format =E2=80=98%d=E2=80=99 expects argument of =
type =E2=80=98int=E2=80=99,
> but
>              VNC_DEBUG("Closing down client sock: ret %d (%s)\n",
>              ^
> cc1: all warnings being treated as errors
> make: *** [ui/vnc.o] Error 1

added to ui patch queue.

thanks,
  Gerd
