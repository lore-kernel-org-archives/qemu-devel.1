Received: from eggs.gnu.org ([2001:4830:134:3::10]:58268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d2QHs-0005ZE-1v
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d2QHr-0004AK-9X
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:47:24 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:45610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d2QHr-00049x-3D
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:47:23 -0400
Date: Mon, 24 Apr 2017 00:47:20 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170423224720.lbqt7tw5tzy2yuyl@aurel32.net>
References: <20170423223240.17917-1-aurelien@aurel32.net>
	<ae985b05-a8ad-adb8-0e7a-1ec6ba631402@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ae985b05-a8ad-adb8-0e7a-1ec6ba631402@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2] s390x/misc_helper.c: wrap
 s390_virtio_hypercall in BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 2017-04-23 19:38, Philippe Mathieu-Daud=E9 wrote:
> Hi Aurelien!
>=20
> Why don't lock inside s390_virtio_hypercall() directly round the diag500
> dispatch call?

s390_virtio_hypercall is shared between TCG and KVM. For KVM the lock is
already done before calling s390_virtio_hypercall in kvm_arch_handle_exit.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
