Received: from eggs.gnu.org ([2001:4830:134:3::10]:50864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTRPH-0008DY-0z
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dTRPD-0006bc-Tb
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 07:26:43 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865922142.17063.17637554632892697681.stgit@frigg.lan>
	<5e3f1bec-5597-172b-1ec0-0a823a4960b0@twiddle.net>
Date: Fri, 07 Jul 2017 13:26:23 +0200
In-Reply-To: <5e3f1bec-5597-172b-1ec0-0a823a4960b0@twiddle.net> (Richard
	Henderson's message of "Sat, 1 Jul 2017 18:54:05 -0700")
Message-ID: <87bmowebds.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 29/29] target/arm: [tcg] Port to
 generic translation framework
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

> On 06/28/2017 07:13 AM, Llu=C3=ADs Vilanova wrote:
>> @@ -11377,6 +11385,9 @@ static void aarch64_trblock_tb_stop(DisasContext=
Base *dcbase, CPUState *cpu)
>> break;
>> }
>> }
>> +
>> +    /* Functions above can change dc->pc, so re-align db->pc_next */
>> +    dc->base.pc_next =3D dc->pc;
>> }
>> static void aarch64_trblock_disas_log(const DisasContextBase *dcbase,

> Surely this belonged in a previous patch.

No, there's pieces of the previous loop that used dc->pc (calculation of
tb->size at the end), and the generic one only has dc->base.pc_next now.


Thanks,
  Lluis
