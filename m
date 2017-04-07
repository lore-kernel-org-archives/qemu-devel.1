Received: from eggs.gnu.org ([2001:4830:134:3::10]:51463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cwRGz-0003nA-Gm
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cwRGw-0005u5-Aq
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:37:45 -0400
Received: from chuckie.co.uk ([82.165.15.123]:50301
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cwRGw-0005mM-48
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:37:42 -0400
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1491560929.26308.41.camel@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3aff73da-2e94-eef5-c0db-74a4ded14311@ilande.co.uk>
Date: Fri, 7 Apr 2017 11:37:00 +0100
MIME-Version: 1.0
In-Reply-To: <1491560929.26308.41.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/14] TCX/CG3 adapter cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 07/04/17 11:28, Gerd Hoffmann wrote:

> On Mi, 2017-04-05 at 09:35 +0100, Mark Cave-Ayland wrote:
>> This started as part of the work on Gerd's thread-safe display patches
>> but ended up turning into something a lot more comprehensive. It contains
>> lots of cleanupm and fixes for display invalidation (particularly on 24-bit
>> TCX) exposed by testing the thread-safe patchset.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Looks all fine to me.
> 
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> You'll merge them through the sparc queue I guess?

Yes, I can do. I think it makes sense to merge them before your display
thread-safety series, so if that still works for you I'll send a pull
request early on when the tree opens for 2.10 to clear the way for your
updates.


ATB,

Mark.
