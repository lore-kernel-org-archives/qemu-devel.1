Received: from eggs.gnu.org ([2001:4830:134:3::10]:45366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dn71L-0006Hu-VI
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dn71I-0007nz-2a
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:43:20 -0400
Received: from chuckie.co.uk ([82.165.15.123]:57623
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dn71H-0007hO-Rn
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:43:16 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <1503065708-28277-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Message-ID: <dfef2416-0328-3438-d81b-96cc02f9f867@ilande.co.uk>
Date: Wed, 30 Aug 2017 18:42:57 +0100
MIME-Version: 1.0
In-Reply-To: <1503065708-28277-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] net: introduce common net_crc32() and
 net_crc32_le() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, jasowang@redhat.com

On 18/08/17 15:15, Mark Cave-Ayland wrote:

> Whilst trying to debug a CRC32 endian issue for NIC multicast hash lookups, it
> struck me that it would make sense to have a common set of standard ethernet
> CRC32 functions (both little and big endian variants) in net.c.
> 
> The first two patches introduce the relevant functions while the last two patches
> switch the pcnet and eepro100 drivers over to use them, allowing us to remove
> their private implementations.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Mark Cave-Ayland (4):
>   net: move CRC32 calculation from compute_mcast_idx() into its own
>     net_crc32() function
>   net: introduce net_crc32_le() function
>   pcnet: switch lnc_mchash() over to use net_crc32_le()
>   eepro100: switch e100_compute_mcast_idx() over to use net_crc32()
> 
>  hw/net/eepro100.c |   19 +------------------
>  hw/net/pcnet.c    |   16 +---------------
>  include/net/net.h |    5 ++++-
>  net/net.c         |   38 +++++++++++++++++++++++++++++++++-----
>  4 files changed, 39 insertions(+), 39 deletions(-)

Hi Jason,

Any thoughts on this patchset? I now have another virtual NIC
implementation for upstream that makes use of the new net_crc32_le()
function created by this patchset and I would really like to use this
instead of copy/pasting yet another different CRC32 implementation :)


ATB,

Mark.
