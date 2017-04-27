Received: from eggs.gnu.org ([2001:4830:134:3::10]:55115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3rkV-0001YF-D3
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 18:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3rkQ-0008Jc-RE
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 18:18:55 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1d3rkQ-0008I3-Gy
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 18:18:50 -0400
Date: Thu, 27 Apr 2017 18:18:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170427221848.GA15480@flamenco>
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-18-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170427120006.20564-18-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v5 17/19] tcg/aarch64: Implement goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Thu, Apr 27, 2017 at 14:00:04 +0200, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  tcg/aarch64/tcg-target.h     |  2 +-
>  tcg/aarch64/tcg-target.inc.c | 22 ++++++++++++++++++++--
>  2 files changed, 21 insertions(+), 3 deletions(-)

Tested-by: Emilio G. Cota <cota@braap.org>

Would be nice to add to the commit log these before/after numbers
I just got on an aarch64 host:

                      SPECint06 (test set), x86_64-linux-user. Host: APM 64-bit ARMv8 (Atlas/A57) @ 2.4 GHz                  
                                                                                                                             
 1.45x +-+-------------------------------------------------------------------------------------------------------------+-+   
       |                                      *****                                                                      |   
       |      +++                             *   *                                                    +goto-ptr         |   
  1.4x +-+...*****............................*...*....................................................................+-+   
       |     *+++*                            *   *                            +++                                       |   
 1.35x +-+...*...*............................*...*...........................*****....................................+-+   
       |     *   *                            *   *                           *+++*                                      |   
       |     *   *                            *   *                           *   *                                      |   
  1.3x +-+...*...*............................*...*...........................*...*....................................+-+   
       |     *   *                            *   *                           *   *                                      |   
       |     *   *                            *   *                           *   *                    *****             |   
 1.25x +-+...*...*...........*****............*...*...........................*...*............*****...*...*...........+-+   
       |     *   *           *   *            *   *                           *   *            *+++*   *   *             |   
  1.2x +-+...*...*...........*...*............*...*...........................*...*............*...*...*...*...........+-+   
       |     *   *           *   *            *   *                           *   *            *   *   *   *             |   
       |     *   *           *   *            *   *                           *   *            *   *   *   *   *****     |   
 1.15x +-+...*...*...........*...*............*...*...........................*...*............*...*...*...*...*...*...+-+   
       |     *   *           *   *            *   *                           *   *    +++     *   *   *   *   *   *     |   
       |     *   *           *   *            *   *                           *   *   *****    *   *   *   *   *   *     |   
  1.1x +-+...*...*...........*...*....*****...*...*...*****...................*...*...*...*....*...*...*...*...*...*...+-+   
       |     *   *           *   *    *   *   *   *   *   *                   *   *   *   *    *   *   *   *   *   *     |   
 1.05x +-+...*...*...........*...*....*...*...*...*...*...*...................*...*...*...*....*...*...*...*...*...*...+-+   
       |     *   *   *****   *   *    *   *   *   *   *   *                   *   *   *   *    *   *   *   *   *   *     |   
       |     *   *   *   *   *   *    *   *   *   *   *   *   *****   *****   *   *   *   *    *   *   *   *   *   *     |   
    1x +-+---*****---*****---*****----*****---*****---*****---*****---*****---*****---*****----*****---*****---*****---+-+   
          astar   bzip2     gcc    gobmk h264ref   hmmlibquantum     mcf omnetpperlbench    sjenxalancbmk   hmean            
  png: http://imgur.com/en9HE8L

Thanks,

		E.
