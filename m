Received: from eggs.gnu.org ([2001:4830:134:3::10]:51233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQssZ-0008T5-0o
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQssU-0002T8-3E
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:14:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fQssT-0002Ss-TS
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:14:50 -0400
References: <alpine.BSF.2.21.1806061909150.94568@zero.eik.bme.hu>
	<CAFEAcA8b6ziWp2ZAhyG2pY2V6EVzBNodv4ZDxFKc8hdV1=oZTw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ee8ff819-2344-bbaf-fa2e-e0c0a9d0f385@redhat.com>
Date: Thu, 7 Jun 2018 13:14:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8b6ziWp2ZAhyG2pY2V6EVzBNodv4ZDxFKc8hdV1=oZTw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 06.06.2018 20:33, Peter Maydell wrote:
> On 6 June 2018 at 18:15, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> Hello,
>>
>> Since 12fb0ac05 (char: Remove unwanted crlf conversion) trace output is
>> printed in stair steps when using -trace and -serial stdio together. E.g.
>> $ qemu-system-i386 -trace 'pci*' -serial stdio
> 
> I had a feeling that we were going to find that there were
> situations where we really wanted to retain the crlf
> processing...

I think the problem is that we've turned it on in char-stdio.c, too.
char-serial.c should be sufficient.

Is someone volunteering for sending a patch to revert the changes in
char-stdio.c ?

 Thomas
