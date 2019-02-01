Received: from eggs.gnu.org ([209.51.188.92]:36750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpbhV-00026H-2n
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gpbhR-0004hq-1j
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:29:55 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gpbhN-0004dL-Eu
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:29:51 -0500
Received: by mail-wr1-x442.google.com with SMTP id p4so7734275wrt.7
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:29:43 -0800 (PST)
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<20190201145035.22739-2-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190201145035.22739-2-peter.maydell@linaro.org>
Date: Fri, 01 Feb 2019 16:29:41 +0000
Message-ID: <87pnsbv5e2.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/11] docs/cpu-hotplug.rst: Fix rST markup
 issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> sphinx-build complains:
>
> docs/cpu-hotplug.rst:67: ERROR: Unexpected indentation.
> docs/cpu-hotplug.rst:69: ERROR: Unexpected indentation.
> docs/cpu-hotplug.rst:74: WARNING: Block quote ends without a blank line; =
unexpected unindent.
> docs/cpu-hotplug.rst:75: WARNING: Block quote ends without a blank line; =
unexpected unindent.
> docs/cpu-hotplug.rst:76: SEVERE: Unexpected section title.
>
> }
> {
> docs/cpu-hotplug.rst:78: WARNING: Block quote ends without a blank line; =
unexpected unindent.
>
> These are the result of not indicating one of the literal
> blocks by finishing the preceding paragraph with the "::" marker.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  docs/cpu-hotplug.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/cpu-hotplug.rst b/docs/cpu-hotplug.rst
> index 1c268e00b41..e2d4e893b01 100644
> --- a/docs/cpu-hotplug.rst
> +++ b/docs/cpu-hotplug.rst
> @@ -60,7 +60,7 @@ vCPU hotplug
>      hot-plugged (no "qom-path" member).  From its output in step (3), we
>      can see that ``IvyBridge-IBRS-x86_64-cpu`` is present in socket 0,
>      while hot-plugging a CPU into socket 1 requires passing the listed
> -    properties to QMP ``device_add``:
> +    properties to QMP ``device_add``::
>
>        (QEMU) device_add id=3Dcpu-2 driver=3DIvyBridge-IBRS-x86_64-cpu so=
cket-id=3D1 core-id=3D0 thread-id=3D0
>        {


--
Alex Benn=C3=A9e
