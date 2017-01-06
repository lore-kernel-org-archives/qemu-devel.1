Received: from eggs.gnu.org ([2001:4830:134:3::10]:53255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cPLFT-0000bC-EU
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cPLFP-0006F7-Ho
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:31:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cPLFP-0006CP-Ck
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 22:31:19 -0500
Date: Fri, 6 Jan 2017 11:31:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170106033112.GB4135@pxdev.xzpeter.org>
References: <1483438205-31110-1-git-send-email-peterx@redhat.com>
	<1483438205-31110-3-git-send-email-peterx@redhat.com>
	<20170104150938.GA9029@potion>
	<20170105030746.GN22664@pxdev.xzpeter.org>
	<20170105194401.GD29430@potion>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170105194401.GD29430@potion>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v2 2/2] run_tests: allow run
 tests in parallel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>

On Thu, Jan 05, 2017 at 08:44:02PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:

[...]

> > Anyway, IMHO squashing you suggestion of "trap exit SIGINT" at the
> > entry of for_each_unittest() is an acceptable solution - it works in
> > all cases.
>=20
> Seems like the best solution at this time ...
> We actually want to "exit 130", as it would when using normal wait does=
,
> and maybe it could be improved a bit by adding a wait:
>=20
>   trap 'wait; exit 130' SIGINT

Sounds better, thanks!

Will repost with this one.

-- peterx
