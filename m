Received: from eggs.gnu.org ([2001:4830:134:3::10]:58298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ckx7y-00043h-My
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ckx7v-0004MB-KB
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:12:58 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:44064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ckx7v-0004K2-DV
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 13:12:55 -0500
Date: Mon, 6 Mar 2017 19:12:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <1488810230-31945-1-git-send-email-kraxel@redhat.com>
Message-ID: <alpine.BSF.2.20.1703061907370.39075@zero.eik.bme.hu>
References: <1488810230-31945-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 0/2] sm501: drop obsolete code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Hello,

On Mon, 6 Mar 2017, Gerd Hoffmann wrote:
> This little series drops a bunch of code which is not needed any more.
> Nowdays qemu console only uses 32bpp surfaces.
>
> BALATON, this should simplify your job of getting the pixel conversions
> right.  Feel free to add this to your series.

Thanks but this would actually complicate my job, as applying this before 
my series would need rebasing my patches again to this change and after 
that it won't apply as it is because the draw functions are changed. Maybe 
this change could be done independently after my series gets in. Having 
the unused functions should not cause any problems other than some unused 
code in the executable so it does not seem to matter for pixel 
conversions.

Regards,
BALATON Zoltan

> Gerd Hoffmann (2):
>  sm501: drop support for anything but 32bpp
>  sm501: drop sm501_template.h
>
> hw/display/sm501.c          | 167 +++++++++++++++++++++++---------------------
> hw/display/sm501_template.h | 145 --------------------------------------
> 2 files changed, 86 insertions(+), 226 deletions(-)
> delete mode 100644 hw/display/sm501_template.h
>
>
