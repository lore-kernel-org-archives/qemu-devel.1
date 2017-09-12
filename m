Received: from eggs.gnu.org ([2001:4830:134:3::10]:56621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1drjVY-0001vf-VC
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1drjVW-0000Xw-CR
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:37:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1drjVW-0000Xh-6M
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:37:34 -0400
Date: Tue, 12 Sep 2017 13:37:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170912113722.GH29136@localhost.localdomain>
References: <59B7C252.1070004@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59B7C252.1070004@huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?q?question=EF=BC=9A_I_found_a_bug_which_wil?=
 =?utf-8?q?l_lead_to_qemu_crash?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "WangJie (Captain)" <wangjie88@huawei.com>
Cc: berto@igalia.com, stefanha@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com

Am 12.09.2017 um 13:17 hat WangJie (Captain) geschrieben:
> Hi, Kevin.
>=20
> I found a bug about qemu-kvm(version 2.7.0-rc0 adn 2.8.1). but qemu 2.6=
.0 and current master is OK.
> So I git-bisect the master branch=EF=BC=8Cand I found the patch you com=
mited (block: Decouple throttling from BlockDriverState) lead the bug int=
o qemu.
>=20
> The patch which lead the bug into qemu: (https://github.com/qemu/qemu/c=
ommit/7ca7f0f6db1fedd28d490795d778cf23979a2aa7#diff-ea36ba0f79150cc299732=
696a069caba)
>=20
> Because the current master is OK. So I think you had fixed it , can you=
 tell me which patch fixed the bug?        Thank you :>

I can't tell offhand which fix this was, but you can use 'git bisect'
not only to find which commit introduced the bug, but also to find the
fix. You just bisect between a broken commit and master, and then use
the reversed meaning of 'good' and 'bad' (i.e. 'good' means that the bug
is still there, 'bad' means it is already fixed).

Kevin
