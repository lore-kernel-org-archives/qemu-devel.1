Received: from eggs.gnu.org ([209.51.188.92]:53635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqavA-00010T-6r
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqav9-00005o-CP
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:52:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gqav9-000056-3b
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:52:07 -0500
References: <20190203220744.11734-1-philmd@redhat.com>
	<CAP+75-Ve9NwAfgmXoXDGuK5ykZWn-9+Y8Wj1+M91noNFtuVNDw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <203ecbc6-b82b-9d55-9919-36c4a8023882@redhat.com>
Date: Mon, 4 Feb 2019 10:51:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAP+75-Ve9NwAfgmXoXDGuK5ykZWn-9+Y8Wj1+M91noNFtuVNDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] Kconfig dependencies for MIPS machines
 (but Malta)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, James Hogan <jhogan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 2019-02-04 01:06, Philippe Mathieu-Daud=C3=A9 wrote:
> On Sun, Feb 3, 2019 at 11:07 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> Express the MIPS machine dependencies with Kconfig.
>=20
> I forgot this serie misses a rule such "depends of MIPS64".
> Asked here: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00=
064.html

I guess the easiest solution is to simply set a CONFIG_MIPS64=3Dy in the
default-configs/mips64*softmmu* files.

 Thomas
