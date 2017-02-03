Received: from eggs.gnu.org ([2001:4830:134:3::10]:41312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZcAI-0004tY-Pg
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:36:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZcAH-0004aW-Uf
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:36:30 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZcAH-0004Zk-Oi
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:36:29 -0500
Received: by mail-wm0-x235.google.com with SMTP id c85so24340403wmi.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 03:36:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486047907-26685-1-git-send-email-kraxel@redhat.com>
References: <1486047907-26685-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 11:36:08 +0000
Message-ID: <CAFEAcA9uEVO5zn_P_7BM+bGkge0DvQ62j7w+iqo4x1goU1UF1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/4] cirrus: multiple bugfixes,
 including CVE-2017-2615 fix.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 February 2017 at 15:05, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here is the vga patch queue, finally bringing the cirrus fixes.
>
> Pull v2 fixes the review and message id lines in patch #4.
> No code changes.
>
> please pull,
>   Gerd
>
> The following changes since commit a0def594286d9110a6035e02eef558cf3cf5d847:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-01-30 10:23:20 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-vga-20170202-2
>
> for you to fetch changes up to 62d4c6bd5263bb8413a06c80144fc678df6dfb64:
>
>   cirrus: fix oob access issue (CVE-2017-2615) (2017-02-02 15:58:23 +0100)
>
> ----------------------------------------------------------------
> cirrus: multiple bugfixes, including CVE-2017-2615 fix.
>
> ----------------------------------------------------------------
> Gerd Hoffmann (1):
>       cirrus: fix blit address mask handling
>
> Li Qiang (1):
>       cirrus: fix oob access issue (CVE-2017-2615)
>
> Wolfgang Bumiller (2):
>       cirrus: handle negative pitch in cirrus_invalidate_region()
>       cirrus: allow zero source pitch in pattern fill rops
>
>  hw/display/cirrus_vga.c | 64 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 39 insertions(+), 25 deletions(-)
>


Applied, thanks.

-- PMM
