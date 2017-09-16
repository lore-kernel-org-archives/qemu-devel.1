Received: from eggs.gnu.org ([2001:4830:134:3::10]:38297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0mS-0003Vd-1S
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0mO-0005Ic-1i
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:16:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0mN-0005IO-RY
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:16:15 -0400
Date: Fri, 15 Sep 2017 21:16:11 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170916001611.GC21016@localhost.localdomain>
References: <20170830225225.27925-1-f4bug@amsat.org>
	<20170830225225.27925-7-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170830225225.27925-7-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/7] mips: replace cpu_mips_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Marcel Apfelbaum <marcel@redhat.com>, James Hogan <james.hogan@imgtec.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 07:52:24PM -0300, Philippe Mathieu-Daud=E9 wrote:
> From: Igor Mammedov <imammedo@redhat.com>
>=20
> now cpu_mips_init() reimplements subset of cpu_generic_init()
> tasks, so just drop it and use cpu_generic_init() directly.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Herv=E9 Poussineau <hpoussin@reactos.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> [PMD: use internal.h instead of cpu.h]
> Tested-by: James Hogan <james.hogan@imgtec.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

--=20
Eduardo
