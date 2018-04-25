Received: from eggs.gnu.org ([2001:4830:134:3::10]:58332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBMid-0005Oc-LS
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBMiZ-0006J1-MO
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:52:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40822 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBMiZ-0006Im-HE
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:52:27 -0400
References: <20180425153343.24023-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cb41b3a5-0e3b-f30b-a02c-1cc333d38ab1@redhat.com>
Date: Wed, 25 Apr 2018 17:52:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180425153343.24023-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] hw/core: expand description of
 null-machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>

On 25.04.2018 17:33, Alex Benn=C3=A9e wrote:
> People following old instructions for QEMU get the message "No machine
> specified, and there is no default" and run -machine help to pick a
> new machine. Lay people might consider the null-machine to be such a
> basic starting point but they won't get far. This leads to confusion,
> see https://bugs.launchpad.net/qemu/+bug/1766896 as an example.
>=20
> I'm open to better words - I figured "THIS PROBABLY ISN'T WHAT YOU
> WANT" seemed less helpful though.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/core/null-machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index cde4d3eb57..72f0815045 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -50,7 +50,7 @@ static void machine_none_init(MachineState *mch)
> =20
>  static void machine_none_machine_init(MachineClass *mc)
>  {
> -    mc->desc =3D "empty machine";
> +    mc->desc =3D "empty machine (for probing/QMP)";

Actually, with certain CPUs, you can really use the "none" machine as a
pure instruction set testing system. For example, on m68k, there used to
be an explicit "dummy" machine for this job, and we removed it in favour
of the "none" machine:

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D22f2dbe7eaf3e12e38c=
9c210

So I'd rather not add such wording. We should rather fix those segfaults
instead (QEMU should never segfault - in case a device can not be used
with the "none" machine, there rather should be an error message instead)=
.

 Thomas
