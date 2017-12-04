Received: from eggs.gnu.org ([2001:4830:134:3::10]:40241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eLxcy-0008V8-GT
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eLxcv-0006en-ES
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:46:12 -0500
Received: from chuckie.co.uk ([82.165.15.123]:37376
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eLxcv-0006ZJ-73
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:46:09 -0500
References: <20171122063250.7674-1-jcd@tribudubois.net>
	<3d54e331-07f3-dd43-e2b6-aded54ccaf6f@ilande.co.uk>
	<3a7ef463-a4ff-bc54-e250-705660bd078a@tribudubois.net>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <08a193ea-f995-6daa-c1db-8df0ab695a9a@ilande.co.uk>
Date: Mon, 4 Dec 2017 20:45:52 +0000
MIME-Version: 1.0
In-Reply-To: <3a7ef463-a4ff-bc54-e250-705660bd078a@tribudubois.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Remove MemoryRegionSection check code from
 sparc_cpu_get_phys_page_debug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe DUBOIS <jcd@tribudubois.net>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>

On 27/11/17 20:19, Jean-Christophe DUBOIS wrote:

> Hello Mark,
> 
> Did you get any second opinion on this?
> 
> Also do you need me to resend the patch with the SPARC keyword in the 
> patch subject line?

Hi Jean-Christophe,

Apologies for the delay as I've been fairly busy with my day job. I 
believe Artyom is away at the moment which is why I haven't written a 
reply, but AFAICT there are 2 options:

1) Remove the MemoryRegion check (as per your patch)

2) Change dump_mmu() to call cpu_sparc_get_phys_page() directly

I'm mildly leaning towards 1) since there doesn't seem to be equivalent 
code in other architectures, however the tree is currently in freeze for 
the upcoming 2.11 release so that's where most people's free time is 
currently being spent.

Once I can confirm the correct approach, I'm keen to get this into the 
2.12 tree early so there is plenty of time to spot any regressions 
during the next development cycle.


ATB,

Mark.
