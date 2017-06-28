Received: from eggs.gnu.org ([2001:4830:134:3::10]:45926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQB48-00080A-0S
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:23:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQB44-0008K2-Pw
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:23:23 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:58675 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dQB44-0008Jc-CP
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 07:23:20 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149838022308.6497.2104916050645246693.stgit@frigg.lan>
	<149838167780.6497.10644158789800844637.stgit@frigg.lan>
	<20170626181451.GH17935@flamenco>
Date: Wed, 28 Jun 2017 14:23:07 +0300
In-Reply-To: <20170626181451.GH17935@flamenco> (Emilio G. Cota's message of
	"Mon, 26 Jun 2017 14:14:51 -0400")
Message-ID: <87vangcq5g.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 06/26] target: [tcg,
 i386] Port to DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

Emilio G Cota writes:

> On Sun, Jun 25, 2017 at 12:07:57 +0300, Llu=C3=ADs Vilanova wrote:
>> Incrementally paves the way towards using the generic instruction transl=
ation
>> loop.
>>=20
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>

> Just a minor nit: the commit titles are a little strange to me.
> I'd rather do: "target/arch: foo" than "target: [tcg, arch]: foo" --
> it's less characters ("tcg" is redundant) and seems more in line with
> qemu's idioms.

Is tcg redundant? I thought it was necessary for differentiating it from th=
e kvm
target-specific parts.


Cheers,
  Lluis
