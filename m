Received: from eggs.gnu.org ([2001:4830:134:3::10]:58899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eozWw-0005L5-48
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eozWs-0000kl-Rj
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:39:58 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eozWs-0000gZ-7W
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 17:39:54 -0500
Date: Thu, 22 Feb 2018 17:39:51 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180222223951.GA26967@flamenco>
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1519324303-5674-3-git-send-email-aleksandar.markovic@rt-rk.com>
	<20180222223327.GA25701@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222223327.GA25701@flamenco>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] target/mips: reimplement SC
 instruction emulation and use cmpxchg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Petar Jovanovic <petar.jovanovic@mips.com>, Fam Zheng <famz@redhat.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>, Yongbok Kim <yongbok.kim@mips.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>, Goran Ferenc <goran.ferenc@mips.com>, Paolo Bonzini <pbonzini@redhat.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On Thu, Feb 22, 2018 at 17:33:27 -0500, Emilio G. Cota wrote:
> Here are some numbers I just gathered for qht-bench, feel
> free to include them in this commit's log:
> 
>   mipsel-linux-user tests/qht-bench -d 5 -n 1 -u 20 -g 10000
>              Host: AMD Opteron(tm) Processor 6376           

Obviously "-n $THREADS", not "-n 1".
Updated png: https://imgur.com/aI9Hvb6

		E.
