Received: from eggs.gnu.org ([2001:4830:134:3::10]:52590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb8Vr-0004wl-Te
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb8Vq-0004bd-Pj
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:21:03 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:36948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb8Vq-0004aU-Hd
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:21:02 -0500
Received: by mail-wm0-x233.google.com with SMTP id v77so161721754wmv.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 08:21:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481239260-21595-1-git-send-email-laurent@vivier.eu>
References: <1481239260-21595-1-git-send-email-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 16:20:41 +0000
Message-ID: <CAFEAcA8+65f-JvER5K1h+uq=fyPOJvJ92puPoG7qQQsu+6K6+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH risu] A script to run concurrently the
 master and the apprentice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 December 2016 at 23:21, Laurent Vivier <laurent@vivier.eu> wrote:
> This expect script will generate the .out file and then
> start the apprentice in a chroot and the master on the reference
> hardware. The list of patterns is given on the command line.
>
> As my reference system is very slow, ssh can take more than 2 minutes,
> this script starts a ssh and a chroot once, and interacts with
> them to run the list of instruction patterns given on the command line.
>
> Some environment variables define the test environment:
> - RISU_ARCH: the pattern file used will be $RISU_ARCH.risu
> - RISU_MASTER: the IP address or name of the reference hardware (for ssh)
> - RISU_CHROOT: the path of the QEMU chroot to start the apprentice
> - RISU_PATH: the path, common to master and apprentice (you can use NFS),
>              where the risu files are stored (binaries and data).
>

Thanks, and sorry I didn't get round to replying to this sooner.
I'm not sure this is something I would use personally, but it
might be helpful to others, so I've opted to put it into a new
contrib/ subdirectory, and added a note to the README about contrib/.
Pushed to risu master.

thanks
-- PMM
