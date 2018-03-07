Received: from eggs.gnu.org ([2001:4830:134:3::10]:52184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etfsi-0001AC-Jj
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etfsh-0001rB-Sb
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 15:41:48 -0500
References: <1519944838-12430-1-git-send-email-cota@braap.org>
	<0c745832-224a-03bb-737b-69dba8419055@ilande.co.uk>
	<20180305224322.GA16890@flamenco>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <8ba9d891-b3c1-879a-6c55-e3226113ceaf@ilande.co.uk>
Date: Wed, 7 Mar 2018 20:41:25 +0000
MIME-Version: 1.0
In-Reply-To: <20180305224322.GA16890@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv1 00/14] Translation loop conversion for
 sh4/sparc/mips/s390x/openrisc targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Stafford Horne <shorne@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On 05/03/18 22:43, Emilio G. Cota wrote:

> On Mon, Mar 05, 2018 at 21:58:52 +0000, Mark Cave-Ayland wrote:
>> I don't have enough knowledge of TCG internals to review this myself,
>> however I can run it through my complete set of OpenBIOS test images for
>> qemu-system-sparc and qemu-system-sparc64 if that helps?
> 
> That would be appreciated -- I only tested sparc64 by booting a NetBSD
> guest.

Hi Emilio,

I've given this a run through all my OpenBIOS test images for 
qemu-system-sparc and qemu-system-sparc64 (including single-stepping via 
gdb) and everything appears to be working fine using your trloop-conv-v1
branch.

Whilst I don't know enough about TCG to be able to review this patch, 
for the sparc/sparc64 parts:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
