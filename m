Received: from eggs.gnu.org ([2001:4830:134:3::10]:36522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chFJA-0008GW-Ul
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chFJ9-0000hE-Pj
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:49:12 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:33416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chFJ9-0000gj-Jr
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 07:49:11 -0500
Received: by mail-wm0-x233.google.com with SMTP id t18so8457647wmt.0
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 04:49:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487767351-9190-1-git-send-email-kraxel@redhat.com>
References: <1487767351-9190-1-git-send-email-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 12:48:49 +0000
Message-ID: <CAFEAcA-H9ja5OiTOk2y5SOj1J0npHqN8_zQ-6W9TALxTTrB6Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] cirrus: add blit_is_unsafe call to
 cirrus_bitblt_cputovideo (CVE-2017-2620)
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

On 22 February 2017 at 12:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
> Here is the pull request for the cirrus cve
> fix sent to the list yesterday.
>
> please pull,
>   Gerd
>
> The following changes since commit 796b288f7be875045670f963ce99991b3c8e96ac:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-02-21 15:48:22 +0000)
>
> are available in the git repository at:
>
>
>   git://git.kraxel.org/qemu tags/pull-cve-2017-2620-20170222-1
>
> for you to fetch changes up to c4cf7039465b0578035c4ec82f9f2519f7dceaf3:
>
>   cirrus: add blit_is_unsafe call to cirrus_bitblt_cputovideo (CVE-2017-2620) (2017-02-22 12:57:08 +0100)
>
> ----------------------------------------------------------------
> cirrus: add blit_is_unsafe call to cirrus_bitblt_cputovideo (CVE-2017-2620)
>
> ----------------------------------------------------------------
> Gerd Hoffmann (1):
>       cirrus: add blit_is_unsafe call to cirrus_bitblt_cputovideo (CVE-2017-2620)
>
>  hw/display/cirrus_vga.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

Shouldn't the commit have a Cc: qemu-stable@nongnu.org tag?

thanks
-- PMM
