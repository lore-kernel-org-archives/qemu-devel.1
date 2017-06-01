Received: from eggs.gnu.org ([2001:4830:134:3::10]:53695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGOxk-0003zo-Hr
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGOxj-0004tU-K5
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:12:24 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGOxj-0004tK-Cy
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:12:23 -0400
Received: by mail-wm0-x230.google.com with SMTP id 7so155423308wmo.1
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:12:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496151640-29919-1-git-send-email-groug@kaod.org>
References: <1496151640-29919-1-git-send-email-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2017 13:12:01 +0100
Message-ID: <CAFEAcA-F8zb3W1DdH+TTF7ozPkMhoei00LaDNeeboxQG+5sOqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/11] 9pfs patches for 2.10 20170530
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 30 May 2017 at 14:40, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 9964e96dc9999cf7f7c936ee854a795415d19b60:
>
>   Merge remote-tracking branch 'jasowang/tags/net-pull-request' into staging (2017-05-23 15:01:31 +0100)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 81ffbf5ab1458e357a761f1272105a55829b351e:
>
>   9pfs: local: metadata file for the VirtFS root (2017-05-25 10:30:14 +0200)
>
> ----------------------------------------------------------------
> Various bugfixes and code cleanups. Most notably, it fixes metadata handling in
> mapped-file security mode (especially for the virtfs root).
>
> ----------------------------------------------------------------
> Greg Kurz (11):
>       virtio-9p/xen-9p: move 9p specific bits to core 9p code
>       fsdev: don't allow unknown format in marshal/unmarshal
>       9pfs: drop pdu_push_and_notify()
>       9pfs: local: fix unlink of alien files in mapped-file mode
>       fsdev: fix virtfs-proxy-helper cwd
>       9pfs: assume utimensat() and futimens() are present
>       util: drop old utimensat() compat code
>       9pfs: check return value of v9fs_co_name_to_path()
>       9pfs: local: resolve special directories in paths
>       9pfs: local: simplify file opening
>       9pfs: local: metadata file for the VirtFS root

Applied, thanks.

-- PMM
