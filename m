Received: from eggs.gnu.org ([2001:4830:134:3::10]:34563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1elPe1-00034X-RP
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 20:44:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1elPdy-0003wS-PF
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 20:44:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45220 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1elPdy-0003vf-Ju
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 20:44:26 -0500
Date: Tue, 13 Feb 2018 09:44:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180213014408.GB27322@lemon.usersys.redhat.com>
References: <20180209145430.26007-1-f4bug@amsat.org>
	<20180212180032.22198-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180212180032.22198-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RESEND v12 11/30] sdhci: replace DMA magic
 value by BLOCK_SIZE_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

On Mon, 02/12 15:00, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Hmm.. Something is going weird here. It's still not in the archive

https://lists.gnu.org/archive/html/qemu-devel/2018-02/threads.html

So I manually bounced it to importer@patchew.org and then it is seen ther=
e. But
git apply failed:

https://patchew.org/QEMU/20180209145430.26007-1-f4bug@amsat.org/

> Switched to a new branch '20180209145430.26007-1-f4bug@amsat.org'
> Applying: sdhci: use error_propagate(local_err) in realize()
> Applying: sdhci: add qtest to check the SD capabilities register
> Applying: sdhci: add check_capab_readonly() qtest
> Applying: sdhci: add a check_capab_baseclock() qtest
> Applying: sdhci: add a check_capab_sdma() qtest
> Applying: sdhci: add qtest to check the SD Spec version
> Applying: sdhci: add a 'spec_version property' (default to v2)
> Applying: sdhci: use a numeric value for the default CAPAB register
> Applying: sdhci: simplify sdhci_get_fifolen()
> Applying: sdhci: check the Spec v1 capabilities correctness
> Applying: sdhci: replace DMA magic value by BLOCK_SIZE_MASK
> error: sha1 information is lacking or useless (hw/sd/sdhci.c).
> error: could not build fake ancestor
> Patch failed at 0001 sdhci: replace DMA magic value by BLOCK_SIZE_MASK
> The copy of the patch that failed is found in: .git/rebase-apply/patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> Failed to apply patch:
> [PATCH RESEND v12 11/30] sdhci: replace DMA magic value by BLOCK_SIZE_M=
ASK

Fam
