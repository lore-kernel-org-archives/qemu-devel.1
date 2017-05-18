Received: from eggs.gnu.org ([2001:4830:134:3::10]:45638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1dBU0n-00022g-FP
	for qemu-devel@nongnu.org; Thu, 18 May 2017 18:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1dBU0k-0003bl-8r
	for qemu-devel@nongnu.org; Thu, 18 May 2017 18:35:13 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rob@landley.net>) id 1dBU0k-0003ac-23
	for qemu-devel@nongnu.org; Thu, 18 May 2017 18:35:10 -0400
Received: by mail-oi0-x243.google.com with SMTP id m17so9729480oik.2
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 15:35:09 -0700 (PDT)
References: <f0c4de76-77a7-90c4-6a99-10ddda953b19@landley.net>
	<c07840b7-29ce-1866-d739-ebe2646a040d@redhat.com>
From: Rob Landley <rob@landley.net>
Message-ID: <fa9191ac-21dd-ee56-cd4b-b3b473625ae7@landley.net>
Date: Thu, 18 May 2017 17:35:07 -0500
MIME-Version: 1.0
In-Reply-To: <c07840b7-29ce-1866-d739-ebe2646a040d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-system-sh4 -M r2d serial is broken.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>



On 05/18/2017 02:57 PM, Paolo Bonzini wrote:
> 
> 
> On 18/05/2017 18:08, Rob Landley wrote:
>> Serial input hangs after the first character in the 4.11 kernel:
>>
>>   http://www.spinics.net/lists/linux-sh/msg51183.html
>>
>> Because they enabled support for a buffer size thing QEMU doesn't
>> emulate right:
>>
>>   http://www.spinics.net/lists/linux-sh/msg51189.html
> 
> Hey,
> 
> regarding this:
> 
>> The really _fun_ thing about this is qemu broke it a couple years back
>> and now if you hit ctrl-c it kills the _emulator_ rather than passing it
>> through to the Linux console. (Just sh4, the rest do it right.)
> 
> Try replacing "-serial stdio" with "-serial mon:stdio".  You'll also be
> able to use the QEMU monitor with "Ctrl-a c", so you can quit with
> "Ctrl-a c quit <enter>".

Ctrl-c now goes through. Thanks!

Exiting the linux instance says "reboot: Restarting system\nUnauthorized
access" and then hangs eating 100% cpu, but maybe I can fix that with
kernel configuration changes.

(I'm still doing a variant of
https://landley.net/aboriginal/control-images so the virtual system
needs to be able to indicate when it's done. But
https://landley.net/aboriginal/about.html is getting replaced with
https://github.com/landley/mkroot so there's some plumbing to do before
that's blocking anything...)

Thanks again,

Rob
