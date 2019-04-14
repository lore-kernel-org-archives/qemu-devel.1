Received: from eggs.gnu.org ([209.51.188.92]:57350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFhIX-00005A-7K
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 11:44:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1hFhIW-0002wh-EY
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 11:44:01 -0400
References: <1555103178-21894-1-git-send-email-atar4qemu@gmail.com>
	<1555103178-21894-4-git-send-email-atar4qemu@gmail.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <ec7f01c8-815b-8743-a321-5a4b56e37ea5@reactos.org>
Date: Sun, 14 Apr 2019 17:43:55 +0200
MIME-Version: 1.0
In-Reply-To: <1555103178-21894-4-git-send-email-atar4qemu@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/4] target/ppc: improve performance of
 large BAT invalidations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Le 12/04/2019 à 23:06, Artyom Tarasenko a écrit :
> Performing a complete flush is ~ 100 times faster than flushing
> 256MiB of 4KiB pages. Set a limit of 1024 pages and perform a complete
> flush afterwards.
> 
> This patch significantly speeds up AIX 5.1 and NetBSD-ofppc.
> 
> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> ---
>   target/ppc/mmu_helper.c | 7 +++++++
>   1 file changed, 7 insertions(+)

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
