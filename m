Received: from eggs.gnu.org ([2001:4830:134:3::10]:47643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgzyJ-0002AU-He
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgzyG-0001ML-EW
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:26:39 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487879800-12352-7-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <755c77c5-0930-b5ee-0b3b-1e0608301c8d@twiddle.net>
Date: Fri, 24 Feb 2017 07:26:30 +1100
MIME-Version: 1.0
In-Reply-To: <1487879800-12352-7-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 06/15] target/ppc: remove xer split-out
 flags(so, ov, ca)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 02/24/2017 06:56 AM, Nikunj A Dadhania wrote:
> Now get rid all the split out variables so, ca, ov. After this patch,
> all the bits are stored in CPUPPCState::xer at appropriate places.
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/cpu.c        |   8 +---
>  target/ppc/cpu.h        |  26 ++++++------
>  target/ppc/int_helper.c |  12 +++---
>  target/ppc/translate.c  | 106 +++++++++++++++++++++++++-----------------------
>  4 files changed, 78 insertions(+), 74 deletions(-)

I do not think this is a good direction to take this.


r~
