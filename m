Received: from eggs.gnu.org ([2001:4830:134:3::10]:59790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ezNRq-0002tL-0n
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ezNRm-0006o9-TN
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:13:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57814 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ezNRm-0006nn-OF
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 10:13:34 -0400
References: <1521794165-31678-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-KEnE9NKGC-vTnMByFC_LDPt2Ae8G7GfOxakfgMGH90w@mail.gmail.com>
	<6750673e-ffc3-578e-e867-332ac0790935@redhat.com>
	<CAFEAcA_u3cKF1aSHbrjW0Hc403G5GkNNom_9mqkJfregfqMymw@mail.gmail.com>
	<173b1d18-720a-4f61-29cf-4f812b78cb2e@redhat.com>
	<CAFEAcA_HaC6yjX7wW0MscxfiEafFT2uhMiWeN644NTYADhdEnQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ebf41b29-24e1-2f51-e382-22b34260cb34@redhat.com>
Date: Fri, 23 Mar 2018 15:13:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_HaC6yjX7wW0MscxfiEafFT2uhMiWeN644NTYADhdEnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/riscv: Fix crashes with
 "-nodefaults"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Michael Clark <mjc@sifive.com>, QEMU Developers <qemu-devel@nongnu.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 23/03/2018 15:04, Peter Maydell wrote:
>> However, if the machine is emulating a real-world board with a fixed S=
oC
>> and fixed hardware in the SoC, it makes more sense to create a null ba=
ckend.
>
> That's a lot of duplicate code to say "oh, this is NULL, create the
> null backend" in lots of different boards :-(

Note it's a null "backend", not necessarily a null "character device".
Your proposal, namely ensuring that be->chr =3D=3D NULL is handled proper=
ly
in qemu_chr_fe_init, would be just fine.

The main point was that the choice of whether to create the device is up
to the board, and there isn't a single answer valid for all boards.

Paolo
