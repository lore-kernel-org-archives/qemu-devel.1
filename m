Received: from eggs.gnu.org ([2001:4830:134:3::10]:36047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xir-0005TF-Im
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xim-0003fW-Q3
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:50:17 -0400
Received: from mail.ispras.ru ([83.149.199.45]:48776)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e6xim-0003fK-I5
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 07:50:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 24 Oct 2017 14:50:11 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
In-Reply-To: <CABdb7345MdDY1J4gX2nh=GiSdA3Dn+-eLWXDXZ2_a9NzMJt2MQ@mail.gmail.com>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
	<150642389121.3900.12320775067244184010.stgit@Misha-PC.lan02.inno>
	<CABdb7345MdDY1J4gX2nh=GiSdA3Dn+-eLWXDXZ2_a9NzMJt2MQ@mail.gmail.com>
Message-ID: <6acc44e581334f8457cefffae88a0262@ispras.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/43] windbg: hook to wrmsr operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-10-03 14:57:
> On Tue, Sep 26, 2017 at 1:04 PM, Mihail Abakumov
> <mikhail.abakumov@ispras.ru> wrote:
>=20
> Most people use QEMU with KVM and won't ever hit this code. Does your
> work rely on TCG only for FS/GS write interception?
>=20
> If KVM is out of scope for you, you should at least make sure that
> users won't expect -windbg to work with it. So either fall back to TCG
> if -windbg is passed or issue a warning.
>=20

KVM is unsupported, at the moment. Therefore, I added additional=20
checking on it in windbg_server_start.

Thanks,
Mihail Abakumov
