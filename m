Received: from eggs.gnu.org ([209.51.188.92]:57330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtU9D-00040I-L4
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtU8Q-0004F7-0I
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:13:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gtU8P-0004Ak-NE
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 04:13:45 -0500
References: <20190211163829.10297-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <002847d1-732d-b777-394c-a784fd359130@redhat.com>
Date: Tue, 12 Feb 2019 10:13:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190211163829.10297-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Kconfig: add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, peter.maydell@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 2019-02-11 17:38, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/kconfig.rst | 284 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 284 insertions(+)
>  create mode 100644 docs/devel/kconfig.rst

Thanks for writing this up - that's a really helpful text!

> diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
> new file mode 100644
> index 0000000000..b653c43b12
> --- /dev/null
> +++ b/docs/devel/kconfig.rst
> @@ -0,0 +1,284 @@
[...]
> +Unlike Linux, there is no user interface to edit the configuration, which is instead
> +specified in per-target files under the ``default-configs/`` directory of the
> +QEMU source tree.  This is because, unlike Linux, configuration and dependencies can be
> +treated as a black box when building QEMU; the default configuration that QEMU
> +ships with should be okay in almost all cases.

I'd like to suggest to replace "Linux" with "Linux-Kconfig".

[...]
> +**reverse dependencies**: ``select <symbol> [if <expr>]``
> +
> +  While ``depends on`` forces a symbol to false, reverse dependencies can be
> +  used to force another symbol to true.  In the following example,
> +  ``CONFIG_BAZ`` will be true whenever ``CONFIG_FOO`` is true::
> +
> +    config FOO
> +      select BAZ
> +
> +  The optional expression will prevent ``select`` from having any effect
> +  unless it is true.
> +
> +  Note that unlike Linux, QEMU will detect contradictions between ``depends on`` and

dito

 Thomas
