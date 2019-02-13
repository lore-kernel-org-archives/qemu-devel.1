Received: from eggs.gnu.org ([209.51.188.92]:46097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gtkfm-0006uR-CH
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 21:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gtkfl-0003h0-HT
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 21:53:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gtkfh-0003c0-Tv
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 21:53:15 -0500
Date: Wed, 13 Feb 2019 10:53:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190213025300.GB11247@xz-x1>
References: <20190212095749.20313-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190212095749.20313-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] Kconfig: add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, cohuck@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, armbru@redhat.com

On Tue, Feb 12, 2019 at 10:57:49AM +0100, Paolo Bonzini wrote:

[...]

> +Writing and modifying default configurations
> +--------------------------------------------
> +
> +In addition to the Kconfig files under hw/, each target also includes
> +a file called ``default-configs/TARGETNAME-softmmu.mak``.  These files
> +initialize some Kconfig variables to non-default values and provide the
> +starting point to turn on devices and subsystems.
> +
> +A file in ``default-configs/`` looks like the following example::
> +
> +    # Default configuration for alpha-softmmu
> +
> +    # Uncomment the following lines to disable these optional devices:
> +    #
> +    #CONFIG_PCI_DEVICES=n
> +    #CONFIG_TEST_DEVICES=n
> +
> +    # Boards:
> +    #
> +    CONFIG_DP264=y
> +
> +The first part, consisting of commented-out ``=n`` assignments, tells
> +the user which devices or device groups are implied by the boards.
> +The second part, consisting of ``=y`` assignments, tells the user which
> +boards are supported by the target.  The user will typically modify
> +default the configuration by uncommenting lines in the first group,

(noticed a trivial typo when read...)

s/default the/the default/

-- 
Peter Xu
