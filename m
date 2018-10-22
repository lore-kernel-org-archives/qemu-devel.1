Received: from eggs.gnu.org ([2001:4830:134:3::10]:48724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gEhTP-0004Yg-3K
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 17:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gEhTL-0001Jp-P1
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 17:10:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1gEhTL-0001JZ-J4
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 17:10:47 -0400
Date: Tue, 23 Oct 2018 05:10:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20181022211010.GA17002@magic>
References: <20181013004034.6968-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181013004034.6968-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/8] tests/vm: Improvements when KVM is
 not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Sat, 10/13 02:40, Philippe Mathieu-Daud=E9 wrote:
> Hi Fam,
>=20
> Few patches I added while testing the VM tests without KVM access.
> I doubt many people want to suffer using TCG for VM testing, but
> it was handy to debug/support aarch64 VM tests.
>=20
> Also this could be a useful TCG stress test...?
>=20
> Since v2: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg0408=
4.html
> - use default args.jobs (Fam)
> - move kvm_available() to scripts/QEMU so it can be used by Avocado
> - do not use -smp 1
> - add a BaseVM::arch property to help cross vm testing

Looks good! Queued, thanks!

Fam
