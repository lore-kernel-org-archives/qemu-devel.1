Received: from eggs.gnu.org ([2001:4830:134:3::10]:33622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAEZO-0001YG-5s
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAEZL-0002H2-HQ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:30:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAEZL-0002EI-7S
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 09:30:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so5754541wrb.6
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 06:30:28 -0700 (PDT)
References: <20181001063803.22330-1-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <20f2bf61-8c11-47cb-a05c-7248d51a53a8@redhat.com>
Date: Wed, 10 Oct 2018 15:30:25 +0200
MIME-Version: 1.0
In-Reply-To: <20181001063803.22330-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/11] net: convert SysBus init method
 to a realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Cc'ing Eduardo since it might make sens to have this series go via his
machine-next tree, rather than Jason's net tree.

On 01/10/2018 08:37, Cédric Le Goater wrote:
> Hello,
> 
> Here is my take to the SysBus init to realize method conversion. I
> picked the /net directory and did them all. Also added a couple of
> reset methods in separate patches.
> 
> make check tested
> 
> Thanks,
> 
> C.
> 
> Changes since v1:
> 
>  - dropped changes in lan9118_init() and smc91c111_init()
>  - fix alignment in milkymist_minimac2_realize()
>  - improved etraxfs reset method
>  
> 
> Cédric Le Goater (11):
>   net: etraxfs_eth: convert SysBus init method to a realize method
>   net: etraxfs_eth: add a reset method
>   net: lan9118: convert SysBus init method to a realize method
>   net: lance: convert SysBus init method to a realize method
>   net: milkymist_minimac2: convert SysBus init method to a realize
>     method
>   net: mipsnet: convert SysBus init method to a realize method
>   net: opencores_eth: convert SysBus init method to a realize method
>   net: smc91c111: convert SysBus init method to a realize method
>   net: stellaris_enet: convert SysBus init method to a realize method
>   net: stellaris_enet: add a reset method
>   net: xgmac: convert SysBus init method to a realize method
> 
>  hw/net/etraxfs_eth.c        | 44 ++++++++++++++++++++++++++-----------
>  hw/net/lan9118.c            |  9 +++-----
>  hw/net/lance.c              |  8 +++----
>  hw/net/milkymist-minimac2.c |  9 +++-----
>  hw/net/mipsnet.c            |  9 +++-----
>  hw/net/opencores_eth.c      |  8 +++----
>  hw/net/smc91c111.c          |  8 +++----
>  hw/net/stellaris_enet.c     | 15 ++++++-------
>  hw/net/xgmac.c              |  9 +++-----
>  9 files changed, 59 insertions(+), 60 deletions(-)
> 
