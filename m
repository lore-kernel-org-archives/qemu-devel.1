Received: from eggs.gnu.org ([2001:4830:134:3::10]:58838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1flHUs-0002IT-Up
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1flHUs-0002co-6S
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 13:34:46 -0400
References: <20180802144430.13870-1-peter.maydell@linaro.org>
	<20180802144430.13870-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <3a7931a8-e28d-5b10-c7a8-5df5651234fe@reactos.org>
Date: Thu, 2 Aug 2018 19:34:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180802144430.13870-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/ppc/prep: Remove ifdeffed-out stub
 of XCSR code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

Le 02/08/2018 à 16:44, Peter Maydell a écrit :
> The prep machine has some code which is stubs of accessors
> for XCSR registers. This has been disabled via #if 0
> since commit b6b8bd1819ff in 2004, and doesn't have any
> actual interesting content. It also uses the deprecated
> old_mmio accessor functions. Remove it entirely.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/ppc/prep.c | 97 +++------------------------------------------------
>   1 file changed, 4 insertions(+), 93 deletions(-)
> 

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
