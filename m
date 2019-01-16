Received: from eggs.gnu.org ([209.51.188.92]:36094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gjgdl-0006IE-L8
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:33:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gjgdg-0000mO-W1
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 03:33:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-4-philmd@redhat.com>
	<875zuqjea7.fsf@dusky.pond.sub.org>
	<f907c7b9-5eed-e604-d0da-b7a3265fc1bc@redhat.com>
Date: Wed, 16 Jan 2019 09:32:57 +0100
In-Reply-To: <f907c7b9-5eed-e604-d0da-b7a3265fc1bc@redhat.com> (Paolo
	Bonzini's message of "Tue, 15 Jan 2019 18:57:34 +0100")
Message-ID: <87tvi9atom.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/15] hw/ssi: Remove SSIBus from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-block@nongnu.org, "Michael S.
	Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 15/01/19 13:28, Markus Armbruster wrote:
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>>  hw/arm/strongarm.h      | 1 +
>>>  include/hw/arm/pxa.h    | 1 +
>>>  include/hw/ssi/pl022.h  | 1 +
>>>  include/hw/ssi/ssi.h    | 1 +
>>>  include/qemu/typedefs.h | 1 -
>>>  5 files changed, 4 insertions(+), 1 deletion(-)
>> When typedefs.h changes, we recompile the world, but it pretty much only
>> ever changes when new typedefs are added.  Thus, *keeping* a typedef
>> there is therefore pretty cheap.
>>=20
>> Nevertheless, we shouldn't keep typedefs there without a real reason.
>> Being able to move one away without having to add any new #include
>> directives is a strong sign for "no real reason".  I like patches doing
>> that.
>>=20
>> What I don't like is adding #include directives just so you can move
>> typedefs out of typedefs.h: it slows down the build.  Granted, the four
>
> (three - one added line is the typedef).

Correct.

>> added by this patch are a drop in the bucket.  The point I'm trying to
>> make is typedefs.h's purpose: it's for avoiding #include directives.
>> Circular ones in particular, but others, too.
>
> In this case, adding ssi.h inclusions to SSI controllers seems to be a
> feature, not a bug.

Adding #include can be a necessity.  It can't be a feature any more than
"slowing down your compiles" could be one :)

I'm particularly wary of unnecessary #include in headers.
