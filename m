Received: from eggs.gnu.org ([2001:4830:134:3::10]:40602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQmym-0006vq-AI
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 00:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQmyh-0004wH-G5
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 00:56:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54782 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fQmyh-0004vR-Ar
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 00:56:51 -0400
References: <alpine.BSF.2.21.1806061909150.94568@zero.eik.bme.hu>
	<87muw768wq.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e1a37ad1-07c4-3c7e-8714-e9263690c2f7@redhat.com>
Date: Thu, 7 Jun 2018 06:56:48 +0200
MIME-Version: 1.0
In-Reply-To: <87muw768wq.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Stair step trace output since 12fb0ac05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Patryk Olszewski <patryk@fala.ehost.pl>, Paolo Bonzini <pbonzini@redhat.com>

On 06.06.2018 20:56, Markus Armbruster wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
> 
>> Hello,
>>
>> Since 12fb0ac05 (char: Remove unwanted crlf conversion) trace output
>> is printed in stair steps when using -trace and -serial stdio
>> together. E.g.
>> $ qemu-system-i386 -trace 'pci*' -serial stdio
>>
>> Regards,
>> BALATON Zoltan
> 
> I cc'ed the people involved with this patch for you.

Is it OK if you revert the change to chardev/char-stdio.c, but not
chardev/char-serial.c ?

 Thomas
