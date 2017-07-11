Received: from eggs.gnu.org ([2001:4830:134:3::10]:39630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dUxXG-0004QP-1G
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dUxXC-0008Gd-TF
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:57:13 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865801156.17063.15618379976159104550.stgit@frigg.lan>
	<244b5aab-8863-3139-f252-09cc02333eda@twiddle.net>
	<87inj4ebqn.fsf@frigg.lan>
	<c35a41d9-4c9d-3daf-2759-17a784b8711b@twiddle.net>
	<87a84gcfv6.fsf@frigg.lan>
	<9611b022-c352-0191-67f6-716b36c8f1e6@twiddle.net>
Date: Tue, 11 Jul 2017 18:56:55 +0300
In-Reply-To: <9611b022-c352-0191-67f6-716b36c8f1e6@twiddle.net> (Richard
	Henderson's message of "Fri, 7 Jul 2017 07:41:49 -1000")
Message-ID: <87o9srhsqg.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 24/29] target/arm: [tcg,
 a64] Port to translate_insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Richard Henderson writes:

> On 07/07/2017 07:32 AM, Llu=C3=ADs Vilanova wrote:
[...]
>> I can restore the NULL approach or add a default empty hook implementati=
on
>> (translator_ignored_op?) if there's a strong feeling to change it.

> Ok, we can work that out.

I'm not sure what you mean. Leave as-is (targets must define all hooks), ig=
nore
NULLs as before, add a default empty implementation for each hook?


Cheers,
  Lluis
