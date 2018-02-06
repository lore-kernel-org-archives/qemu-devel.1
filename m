Received: from eggs.gnu.org ([2001:4830:134:3::10]:39692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ej6ha-0000f4-Ed
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:06:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ej6hX-0001pf-Aw
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:06:38 -0500
References: <20180203084315.20497-1-armbru@redhat.com>
	<20180203084315.20497-10-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fccceb83-814c-2e6c-1845-3b2ab309bf52@redhat.com>
Date: Tue, 6 Feb 2018 18:06:22 +0100
MIME-Version: 1.0
In-Reply-To: <20180203084315.20497-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 09/14] hw/ppc: Replace
 fprintf(stderr, "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, eblake@redhat.com, f4bug@amsat.org, alistair.francis@xilinx.com

On 03.02.2018 09:43, Markus Armbruster wrote:
> From: Alistair Francis <alistair.francis@xilinx.com>
>=20
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
[...]
> Some lines were then manually tweaked to pass checkpatch and some curly
> braces were added to match QEMU style.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: qemu-ppc@nongnu.org
>=20
> Conversions that aren't followed by exit() dropped, because they might
> be inappropriate.
>=20
> Also trim trailing punctuation from error messages.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/ppc/e500.c          | 16 ++++++++--------
>  hw/ppc/mac_newworld.c  |  2 +-
>  hw/ppc/mac_oldworld.c  |  2 +-
>  hw/ppc/ppc405_boards.c | 15 ++++++---------
>  hw/ppc/ppc440_bamboo.c | 16 ++++++++--------
>  hw/ppc/prep.c          |  4 ++--
>  hw/ppc/virtex_ml507.c  |  4 ++--
>  7 files changed, 28 insertions(+), 31 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
