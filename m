Received: from eggs.gnu.org ([2001:4830:134:3::10]:43076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmcdJ-0004sp-Gs
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fmcdE-00036h-Jp
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:21:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:50760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fmcdE-000369-DJ
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 06:20:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fmcdB-0001c8-6x
	for <qemu-devel@nongnu.org>; Mon, 06 Aug 2018 10:20:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 42BBF2E80D3
	for <qemu-devel@nongnu.org>; Mon,  6 Aug 2018 10:20:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Aug 2018 10:09:29 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1785308 <1785308@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153332397534.32176.3210060625384706087.malonedeb@gac.canonical.com>
Message-Id: <153355016942.18255.3991590070189390985.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1785308] Re: 0x8 exception encountered but not
 handled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi Ra,
  We'll need a bit more detail to be able to help here.
The fact something works in Bochs but doesn't work in qemu doesn't necessar=
ily mean it's a qemu bug - for example the OS might be hitting something un=
defined or a timing issue; so we'd need some information on how the double =
page fault happened.
Does it work with KVM enabled? With tcg? What version of qemu are you using?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785308

Title:
  0x8 exception encountered but not handled

Status in QEMU:
  Incomplete

Bug description:
  Present in all QEMU versions.

  OS is triple page faulting and crashing rather than handling the
  expected double page fault properly. The same OS works in Bochs so I
  know its not the problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785308/+subscriptions
