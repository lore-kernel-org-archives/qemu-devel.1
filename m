Received: from eggs.gnu.org ([209.51.188.92]:48893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1gWz-0007xg-2u
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 19:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1gWw-00061g-MW
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 19:05:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1h1gWw-00061K-AH
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 19:04:58 -0500
Date: Wed, 6 Mar 2019 19:04:52 -0500
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190307000452.imsrx5t4egcpoe4h@localhost.localdomain>
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190305172139.32662-2-peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/12] docs/cpu-hotplug.rst: Fix rST
 markup issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Tue, Mar 05, 2019 at 05:21:28PM +0000, Peter Maydell wrote:
> sphinx-build complains:
>=20
> docs/cpu-hotplug.rst:67: ERROR: Unexpected indentation.
> docs/cpu-hotplug.rst:69: ERROR: Unexpected indentation.
> docs/cpu-hotplug.rst:74: WARNING: Block quote ends without a blank line=
; unexpected unindent.
> docs/cpu-hotplug.rst:75: WARNING: Block quote ends without a blank line=
; unexpected unindent.
> docs/cpu-hotplug.rst:76: SEVERE: Unexpected section title.
>=20
> }
> {
> docs/cpu-hotplug.rst:78: WARNING: Block quote ends without a blank line=
; unexpected unindent.
>=20
> These are the result of not indicating one of the literal
> blocks by finishing the preceding paragraph with the "::" marker.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Message-id: 20190228145624.24885-2-peter.maydell@linaro.org
> ---
>  docs/cpu-hotplug.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/docs/cpu-hotplug.rst b/docs/cpu-hotplug.rst
> index 1c268e00b41..e2d4e893b01 100644
> --- a/docs/cpu-hotplug.rst
> +++ b/docs/cpu-hotplug.rst
> @@ -60,7 +60,7 @@ vCPU hotplug
>      hot-plugged (no "qom-path" member).  From its output in step (3), =
we
>      can see that ``IvyBridge-IBRS-x86_64-cpu`` is present in socket 0,
>      while hot-plugging a CPU into socket 1 requires passing the listed
> -    properties to QMP ``device_add``:
> +    properties to QMP ``device_add``::
> =20
>        (QEMU) device_add id=3Dcpu-2 driver=3DIvyBridge-IBRS-x86_64-cpu =
socket-id=3D1 core-id=3D0 thread-id=3D0
>        {
> --=20
> 2.20.1
>=20
>=20

This is an actual reStructuredText syntax violation (at a layer lower
than sphinx) and thus can also be seen by simpler tools such as
rst2{man,html,...}:

   $ rst2html docs/cpu-hotplug.rst 1>/dev/null=20
   docs/cpu-hotplug.rst:67: (ERROR/3) Unexpected indentation.
   docs/cpu-hotplug.rst:69: (ERROR/3) Unexpected indentation.
   docs/cpu-hotplug.rst:74: (WARNING/2) Block quote ends without a blank =
line; unexpected unindent.
   docs/cpu-hotplug.rst:75: (WARNING/2) Block quote ends without a blank =
line; unexpected unindent.
   docs/cpu-hotplug.rst:76: (SEVERE/4) Unexpected section title.

   }
   {
   Exiting due to level-4 (SEVERE) system message.

But I'm assuming the extended sphinx roles/directives will be used, so
the only way to check against future breakage would be to build the
docs.

Do we have strong position in favor or against putting that into the
"common" `make check` flow?  Anyway, these are all possibilities for
future enhancements, so:

Reviewed-by: Cleber Rosa <crosa@redhat.com>
