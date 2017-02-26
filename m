Received: from eggs.gnu.org ([2001:4830:134:3::10]:35871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1chyVC-0001iS-To
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 08:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1chyV7-0003NV-QW
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 08:04:38 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:65321)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1chyV7-0003Mh-Hq
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 08:04:33 -0500
References: <20170225230416.9775-1-bobby.prani@gmail.com>
	<50cd1e34-deda-dc9b-2ce9-5c0cf09223cc@vivier.eu>
	<CAFEAcA-UCMkEREVQKFALDu==Y5z9wPkS2YOEkzOcD-xsv29BUg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <99e997e4-c147-6e38-863b-4138d68a2fbd@vivier.eu>
Date: Sun, 26 Feb 2017 14:04:07 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-UCMkEREVQKFALDu==Y5z9wPkS2YOEkzOcD-xsv29BUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Add signal handling support
 for x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pranith Kumar <bobby.prani@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>, "Wirth, Allan" <awirth@akamai.com>

Le 26/02/2017 à 13:39, Peter Maydell a écrit :
> On 26 February 2017 at 12:29, Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 26/02/2017 à 00:04, Pranith Kumar a écrit :
>>> Note that x86_64 has only _rt signal handlers. This implementation
>>> attempts to share code with the x86_32 implementation.
> 
>>> +    struct target_fpreg st[8];
>>
>> Why don't you keep the original name "_st"?
> 
> I suspect I asked for that in an earlier round of review
> on the basis that names with underscores are reserved
> namespace. Looking more closely at the rules though that's
> a bit over-conservative for a struct field name because
> _ followed by lowercase is only reserved in the global
> name space (unlike __ or _ followed by uppercase, which
> could be a macro). So using _st here isn't wrong, but
> on the other hand there's not much reason to use the
> underscore I think.

OK, thanks for the explanation.

Laurent
