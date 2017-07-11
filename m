Received: from eggs.gnu.org ([2001:4830:134:3::10]:51716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dV2kI-0003E6-Ad
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dV2kF-0001cU-64
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:31:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dV2kE-0001as-Vx
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:30:59 -0400
References: <1499803333-9052-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1499803333-9052-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170711201059.GA6020@localhost.localdomain>
	<20170711231709-mutt-send-email-mst@kernel.org>
	<d9870097-46dc-40bf-49e9-7cf3276017f2@ilande.co.uk>
	<CAFEAcA_e6BjeLXdv=54yzqSvD_XdDKRiLYJeQS4NZY-Zr4vK4A@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3488ef67-930f-a7e1-957a-eea2fe13206f@redhat.com>
Date: Tue, 11 Jul 2017 23:30:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_e6BjeLXdv=54yzqSvD_XdDKRiLYJeQS4NZY-Zr4vK4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv8 1/3] fw_cfg: switch fw_cfg_find() to
 locate the fw_cfg device by type rather than path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Gabriel L. Somlo" <somlo@cmu.edu>, Paolo Bonzini <pbonzini@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Igor Mammedov <imammedo@redhat.com>

(off-topic)

On 07/11/17 22:49, Peter Maydell wrote:
> On 11 July 2017 at 21:26, Mark Cave-Ayland
> <mark.cave-ayland@ilande.co.uk> wrote:
>> On 11/07/17 21:18, Michael S. Tsirkin wrote:
>>
>>> Multi-line comments also should formatted
>>>
>>> /*
>>>  * like
>>>  * this
>>>  */
>>>
>>> not
>>>
>>> /* like
>>>  * this */
>>>
>>
>> Interesting, I never knew there was a preferred format for comments (I
>> see both styles throughout the codebase).
> 
> It's basically GNU coding standard style vs Linux kernel style;
> there's a mix because some contributors are more used to working
> on the kernel, and some more used to working with gcc, glibc,
> etc, and we haven't made a firm "comments must be like this"
> statement (and of course historical practice in the codebase
> is all over the place).
> 
> We also have both of the flavours the kernel style guide
> documents:
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#commenting
> (I usually use the style the kernel has for net/ personally.)
> 
> So I don't think that "we" the project have a preferred
> format; but "we" individual contributors probably
> have individual preferences ;-)

Hey I'm feeling oppressed now; can I add edk2-style comments

//
// like this
//

along with CamelCaseVariables, TYPEDEFS_FOR_STRUCTS, and
CamelCaseEnumConstants? ;)

(Just kidding! :) I should be sleeping now. Sorry.)

Laszlo
