Received: from eggs.gnu.org ([2001:4830:134:3::10]:50073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dkimG-0008Pr-SO
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 23:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dkimC-0000GP-U9
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 23:25:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:33783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dkimC-0000Ff-Nj
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 23:25:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dkim9-000054-NM
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 03:25:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7873F2E80CE
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 03:25:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Aug 2017 03:17:40 -0000
From: li <1711828@bugs.launchpad.net>
Reply-To: Bug 1711828 <1711828@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150314599227.11619.13522742205316684478.malonedeb@wampee.canonical.com>
	<150329128414.8072.13458130413478779268.malone@soybean.canonical.com>
Message-Id: <d125291.435c.15e123ed33f.Coremail.lgj1718@163.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1711828] Re: lock mov non generated #UD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

sorry i english poor=EF=BC=9A


intel manual say=EF=BC=9A
The LOCK prefix can be prepended only to the following instructions and onl=
y to those forms of the instructions
where the destination operand is a memory operand: ADD, ADC, AND, BTC, BTR,=
 BTS, CMPXCHG, CMPXCH8B,
CMPXCHG16B, DEC, INC, NEG, NOT, OR, SBB, SUB, XOR, XADD, and XCHG. If the L=
OCK prefix is used with one of
these instructions and the source operand is a memory operand, an undefined=
 opcode exception (#UD) may be
generated. An undefined opcode exception will also be generated if the LOCK=
 prefix is used with any instruction not
in the above list. The XCHG instruction always asserts the LOCK# signal reg=
ardless of the presence or absence of
the LOCK prefix.


but qemu NO!
lock mov   forms of the instructions non generated #UD exception!
my OS : debian 9.1 =

QEMU: qemu 2.8.1




At 2017-08-21 12:54:44, "Thomas Huth" <1711828@bugs.launchpad.net> wrote:
>Could you please add a proper description to this bug? Please also try
>first whether your problem also occurs with the latest released version
>of QEMU (version 2.9 or the 2.10 release candidate), to see whether it
>has been fixed there already.
>
>** Changed in: qemu
>       Status: New =3D> Incomplete
>
>-- =

>You received this bug notification because you are subscribed to the bug
>report.
>https://bugs.launchpad.net/bugs/1711828
>
>Title:
>  lock mov non generated #UD
>
>Status in QEMU:
>  Incomplete
>
>Bug description:
>  qemu 2.8.1 debian 9.1
>
>To manage notifications about this bug go to:
>https://bugs.launchpad.net/qemu/+bug/1711828/+subscriptions

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1711828

Title:
  lock mov non generated #UD

Status in QEMU:
  Incomplete

Bug description:
  qemu 2.8.1 debian 9.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1711828/+subscriptions
