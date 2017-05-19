Received: from eggs.gnu.org ([2001:4830:134:3::10]:51994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1dBa6b-0008TQ-WD
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1dBa6Y-0004bh-Sx
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:05:37 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rob@landley.net>) id 1dBa6Y-0004bd-Mx
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:05:34 -0400
Received: by mail-oi0-x241.google.com with SMTP id w138so10769546oiw.3
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 22:05:34 -0700 (PDT)
References: <f0c4de76-77a7-90c4-6a99-10ddda953b19@landley.net>
	<c07840b7-29ce-1866-d739-ebe2646a040d@redhat.com>
	<fa9191ac-21dd-ee56-cd4b-b3b473625ae7@landley.net>
	<20170518230018.r7u7ihcicjbhsgpw@aurel32.net>
From: Rob Landley <rob@landley.net>
Message-ID: <7a00b4c1-ef2f-fc82-7a1b-446dc439495b@landley.net>
Date: Fri, 19 May 2017 00:05:31 -0500
MIME-Version: 1.0
In-Reply-To: <20170518230018.r7u7ihcicjbhsgpw@aurel32.net>
Content-Type: text/plain; charset=windows-1252
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
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 05/18/2017 06:00 PM, Aurelien Jarno wrote:
>> Exiting the linux instance says "reboot: Restarting system\nUnauthorized
>> access" and then hangs eating 100% cpu, but maybe I can fix that with
>> kernel configuration changes.
> 
> I guess you mean rebooting the linux instance. This is because you do
> not use a bootloader to load the kernel and the initrd. Then you might
> be interested in:
> 
>   http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg03881.html

That patch worked for me.

Rob
