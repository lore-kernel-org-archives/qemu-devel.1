Received: from eggs.gnu.org ([2001:4830:134:3::10]:34359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cueqM-0002TH-C6
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 08:42:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cueqL-00050y-Gy
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 08:42:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170331192724.14339-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <58cc8898-70fc-6e35-4666-c2a023d3e66a@amsat.org>
Date: Sun, 2 Apr 2017 09:42:41 -0300
MIME-Version: 1.0
In-Reply-To: <20170331192724.14339-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] etsec: (TYPE_)ETSEC_COMMON
 macro cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Scott Wood <scottwood@freescale.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Fabien Chouteau <chouteau@adacore.com>

On 03/31/2017 04:27 PM, Eduardo Habkost wrote:
> When working on other things, I got confused by the etsec code,
> that didn't use the TYPE_ETSEC_COMMON macro in its type
> declaration, and had no subclasses despite being named
> ETSEC_COMMON.
>
> This is a very simple cleanup to remove the _COMMON suffix from
> the macros, and to use the TYPE_ETSEC macro when registering and
> creating devices instead of hardcoding the "eTSEC" name.
>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Fabien Chouteau <chouteau@adacore.com>
> Cc: qemu-ppc@nongnu.org
>
> Eduardo Habkost (2):
>   etsec: Rename (TYPE_)ETSEC_COMMON to (TYPE_)ETSEC
>   etsec: Use TYPE_ETSEC macro when registering/creating device

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>
>  hw/net/fsl_etsec/etsec.h |  6 +++---
>  hw/net/fsl_etsec/etsec.c | 10 +++++-----
>  hw/ppc/e500.c            |  4 ++--
>  3 files changed, 10 insertions(+), 10 deletions(-)
>
