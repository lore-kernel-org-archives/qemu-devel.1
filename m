Received: from eggs.gnu.org ([209.51.188.92]:33945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1glhr7-0001P8-6j
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1glhr6-0006aI-I2
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:15:45 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 21 Jan 2019 22:15:39 +0000
Message-ID: <BN6PR2201MB1251E38EAEAFC4A8C0B13D31C69F0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20190117185628.21862-1-crosa@redhat.com>
In-Reply-To: <20190117185628.21862-1-crosa@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 00/18] Acceptance Tests: target
 architecture support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Fam Zheng <fam@euphon.net>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Cleber Rosa <crosa@redhat.com>

>   class My(Test):
>       def test_nx_cpu_flag(self):
>           """
>           :avocado: tags=3Darch:x86_64
>           """
>           test_code()

> The value of the "arch" key, in this case, "x86_64" will be used when
> selecting the QEMU binary to use in the test.  At the same time, if
> "x86_64-softmmu" is not a built target, the test will be filtered out
> by "make check-acceptance"[3].

I think, the term "arch" is a little problematic in QEMU parlance. IMHO,
"target" should be used instead. ("arch" is used in Linux kernel community)

The overall structure of the "tags" should be a little different. My
suggestion:

"target"
"isa" (instruction set architecture, determeines how the kernel and rootfs =
are built)
"cpu"
"machine"

This would allow clear view what a particular acceptance test tests, and wi=
ll
enforce consistency and clarity in the test organization across the board.

That said, I am very excited about this series.

Regards,
Aleksandar
