Received: from eggs.gnu.org ([2001:4830:134:3::10]:50616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fFkKd-0001wk-Nz
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fFkKa-0002Bj-Iz
	for qemu-devel@nongnu.org; Mon, 07 May 2018 13:53:51 -0400
References: <152568372989.443627.900708381919207053.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <71b68bd5-e50b-3baa-3f72-f6af78db4e2e@redhat.com>
Date: Mon, 7 May 2018 12:53:45 -0500
MIME-Version: 1.0
In-Reply-To: <152568372989.443627.900708381919207053.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc: e500: use g_strdup_printf() instead
 of snprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 05/07/2018 04:02 AM, Greg Kurz wrote:
> qemu-system-ppc fails to build with GCC 8.0.1:
>=20
> /home/hsp/src/qemu-master/hw/ppc/e500.c: In function =E2=80=98ppce500_l=
oad_device_tree=E2=80=99:
> /home/hsp/src/qemu-master/hw/ppc/e500.c:442:37: error: =E2=80=98/pic@=E2=
=80=99
> directive output may be truncated writing 5 bytes into a region of
> size between 1 and 128 [-Werror=3Dformat-truncation=3D]
>       snprintf(mpic, sizeof(mpic), "%s/pic@%llx", soc, MPC8544_MPIC_REG=
S_OFFSET);
>                                       ^~~~~

>=20
> Fix this by converting e500 to use g_strdup_printf()+g_free() instead
> of snprintf(). This is done globally, even for call sites that don't
> break build, since this is the preferred practice in QEMU.
>=20
> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>   hw/ppc/e500.c |   39 +++++++++++++++++++++++----------------
>   1 file changed, 23 insertions(+), 16 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
