Received: from eggs.gnu.org ([2001:4830:134:3::10]:56046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbOt-0007Kb-Vk
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbOp-00067N-59
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:42:04 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:57393 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dMbOo-000668-PG
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 10:41:59 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
	<20170615180216.GA8411@flamenco>
Date: Sun, 18 Jun 2017 17:41:45 +0300
In-Reply-To: <20170615180216.GA8411@flamenco> (Emilio G. Cota's message of
	"Thu, 15 Jun 2017 14:02:16 -0400")
Message-ID: <87efuhcq8m.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v6 0/6] translate: [tcg] Generic
 translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

Emilio G Cota writes:

> On Mon, Jun 12, 2017 at 17:53:47 +0300, Llu=C3=ADs Vilanova wrote:
>> This series proposes a generic (target-agnostic) instruction translation
>> framework.
>>=20
>> It basically provides a generic main loop for instruction disassembly, w=
hich
>> calls target-specific functions when necessary. This generalization makes
>> inserting new code in the main loop easier, and helps in keeping all tar=
gets in
>> synch as to the contents of it.
>>=20
>> This series also paves the way towards adding events to trace guest code
>> execution (BBLs and instructions).
>>=20
>> I've ported i386/x86-64 and arm/aarch64 as an example to see how it fits=
 in the
>> current organization, but will port the rest when this series gets merge=
d.

> It seems patch 5 didn't make it through the list (the list drops patches
> sometimes):
>   https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02833.html

> I think I've found it in your qemu-dbi tree though (1c97cf92b06).
> I pasted it here: https://pastebin.ca/3832616

> 		E.

Yes, I realized that but was waiting to accumulate some changes before send=
ing a
new series. Thanks! :)

Lluis
