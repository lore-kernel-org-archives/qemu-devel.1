Received: from eggs.gnu.org ([2001:4830:134:3::10]:52796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRic4-0006dt-E0
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:52:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRic0-0005U9-4h
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:52:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRibz-0005TM-V7
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:52:28 -0500
Date: Thu, 12 Jan 2017 14:52:25 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170112165225.GC27893@thinpad.lan.raisama.net>
References: <20170112154731.1028-1-alex.bennee@linaro.org>
	<20170112154731.1028-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170112154731.1028-3-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/3] cpu_common_reset: wrap TCG specific
 code in tcg_enabled()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: rth@twiddle.net, qemu-devel@nongnu.org

On Thu, Jan 12, 2017 at 03:47:30PM +0000, Alex Benn=E9e wrote:
> Both the cpu->tb_jmp_cache and SoftMMU TLB structures are only used
> when running TCG code so we might as well skip them for anything else.
>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
