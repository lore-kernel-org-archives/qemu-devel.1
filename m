Received: from eggs.gnu.org ([2001:4830:134:3::10]:56764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKOV8-0007LW-Ve
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKOV3-0000EI-2J
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 08:03:38 -0500
References: <1512031988-32490-1-git-send-email-thuth@redhat.com>
	<1512031988-32490-4-git-send-email-thuth@redhat.com>
	<CAFEAcA-LBOm=kHja3QJqOw-TT3GF9-i+wJfXdL-FU5NKimknzQ@mail.gmail.com>
	<22aa483a-ede3-482d-88a9-ca1c03c37420@redhat.com>
	<34115e36-ab8c-d828-d1a1-3ac7f32ae80b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e55017f1-d9c9-4ae5-40dc-9842b41ebc1b@redhat.com>
Date: Thu, 30 Nov 2017 14:03:09 +0100
MIME-Version: 1.0
In-Reply-To: <34115e36-ab8c-d828-d1a1-3ac7f32ae80b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 3/7] tests/boot-serial-test: Add
 support for the mcf5208evb board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anthony Green <green@moxielogic.com>, Laurent Vivier <laurent@vivier.eu>, qemu-arm <qemu-arm@nongnu.org>, Edgar Iglesias <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On 30/11/2017 13:51, Thomas Huth wrote:
> The two micrablaze data arrays are completely different, since one is
> big endian, the other is little, so I'd need to byte-swap the whole
> array on the fly, too. Not sure whether it makes sense to add such
> complex code just to safe 16 bytes of blob data...?

*facepalm* :)

>> Likewise, you could have just two copies of the code for all ARM boards
>> that have a pl011 (or any other UART with a simple byte-long transmit
>> register), one 32-bit and one 64-bit.
> 
> OK, having a patching mechanism in place likely makes sense as soon as
> we want to include multiple ARM boards here. I can do that, but I'd
> rather like to do it as a second step. It was already quite hard work to
> come up with all these assembler snippets (from CPUs where I don't have
> a clue of) and to determine which machines could be tested this way at
> all, so I'd first like to wait and see whether this patch series is
> acceptable at all or not, since Peter has objections.

Given your remark on endianness then no, having one snippet per binary
is enough.

Paolo
