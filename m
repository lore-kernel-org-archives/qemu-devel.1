Received: from eggs.gnu.org ([2001:4830:134:3::10]:45524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePnaO-0006uF-Pv
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ePnaN-0000iw-Sq
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:51:24 -0500
References: <20171215101651.13911-1-david@gibson.dropbear.id.au>
	<20171215101651.13911-5-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8c3ee849-7c3c-9afd-8906-5c3712323fbd@redhat.com>
Date: Fri, 15 Dec 2017 11:51:18 +0100
MIME-Version: 1.0
In-Reply-To: <20171215101651.13911-5-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] tests/pxe-test: Add some extra tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, mst@redhat.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 15.12.2017 11:16, David Gibson wrote:
> Previously virtio-net was only tested for ppc64 in "slow" mode.  That
> doesn't make much sense since virtio-net is used much more often in
> practice than the spapr-vlan device which was tested always.  So, move
> virtio-net to always be tested on ppc64.

Actually, I just moved virtio-net on ppc64 to the slow category a couple
of months ago:

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dab06ec43577177a442e=
8e5

This has been done since some people complained that SLOF is incredibly
slow in in TCG mode and thus there is the risk of hitting the timeout on
slow systems if they are overloaded.

Things will hopefully get a little bit better with the "Use
tcg_gen_lookup_and_goto_ptr" patch that you've queued in your
ppc-for-2.12 branch, but still, the test is very slow on ppc64, so I'd
rather keep it in the "slow" category. (virtio-net is already tested in
big endian mode on s390x anyway, so we at least got some endianess test
coverage for that NIC already).

> We had no tests at all for the q35 machine, which doesn't seem wise giv=
en
> it's increasing prominence.  Add a couple of tests for it, including
> testing the newer e1000e adapter.

That sounds like a good idea! I wonder whether we should also test some
"old" machine versions (in "slow" mode only, of course), like "pc-0.12"
for example, to make sure that there are no regressions with old machines=
?

 Thomas
