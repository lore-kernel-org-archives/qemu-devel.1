Received: from eggs.gnu.org ([2001:4830:134:3::10]:54488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dPwnD-0006DO-LT
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dPwnA-0000Ek-En
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:08:59 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dPwnA-0000EZ-81
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:08:56 -0400
Received: by mail-wm0-x244.google.com with SMTP id p204so2945465wmg.1
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 13:08:56 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170618191101.3457-1-Sergio.G.DelReal@gmail.com>
	<b5df4ca0-a337-1385-58e3-5217ee00cbfb@redhat.com>
	<79be8ef3-de2e-b498-4b1d-628bfcc71154@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8f870924-04f1-e238-1e21-a78616fd8355@redhat.com>
Date: Tue, 27 Jun 2017 22:08:51 +0200
MIME-Version: 1.0
In-Reply-To: <79be8ef3-de2e-b498-4b1d-628bfcc71154@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vcpu_dirty: share the same field in
 CPUState for all accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>, Eduardo Habkost <ehabkost@redhat.com>, "open list:Overall" <kvm@vger.kernel.org>, "open list:CPU" <qemu-devel@nongnu.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>



On 27/06/2017 20:36, Eric Blake wrote:
> On 06/19/2017 11:35 AM, Paolo Bonzini wrote:
>>
>>
>> On 18/06/2017 21:11, Sergio Andres Gomez Del Real wrote:
>>> This patch simply replaces the separate boolean field in CPUState that
>>> kvm, hax (and upcoming hvf) have for keeping track of vcpu dirtiness
>>> with a single shared field.
>>>
>>> Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
>>> ---
> 
>>>
>>
>> Thanks, I queued this patch for 2.9.
> 
> As in qemu-stable 2.9.1, or did you mean 2.10 mainline?

2.10 of course.

Paolo
