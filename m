Received: from eggs.gnu.org ([2001:4830:134:3::10]:38036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDObB-0005x8-PK
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:49:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDOau-000828-QS
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:49:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gDOap-0007vT-Gy
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:49:10 -0400
References: <cover.1539860473.git.artem.k.pisarenko@gmail.com>
	<3a396555c19468ce89788cc6deabbfef4ab56035.1539860473.git.artem.k.pisarenko@gmail.com>
	<002201d46770$4affc060$e0ff4120$@ru>
	<CANzW0mui0aaCWH0iQT+KxHygmE1TSh9Xko_Qyrwkg=6kUnM_Eg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <28e6277d-cf84-c4a4-8916-1c7168d64a8e@redhat.com>
Date: Fri, 19 Oct 2018 08:48:58 +0200
MIME-Version: 1.0
In-Reply-To: <CANzW0mui0aaCWH0iQT+KxHygmE1TSh9Xko_Qyrwkg=6kUnM_Eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] Optimize record/replay
 checkpointing for all clocks it applies to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 19/10/2018 08:30, Artem Pisarenko wrote:
>> This is wrong at least for QEMU_CLOCK_HOST.
>> =E2=80=A6
>> Reading the host clock here is not protected by the checkpoint.
>> Therefore it may incur the inconsistency when replaying the execution.
>=20
> That's why I didn't like idea of this patch and asked for any possible
> side effects beforehand. So, here is one.
> I have no idea how to fix it properly and would like to recall this
> particular patch from these series (remember, it doesn't match series
> goal). Lets leave this patch/issue for separate resolution, although I'=
m
> not very interested in it.

Yup, I'll send v2 of the pull request with this patch removed.

Paolo
