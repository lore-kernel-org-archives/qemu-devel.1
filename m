Received: from eggs.gnu.org ([2001:4830:134:3::10]:45684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgC0V-00064l-IJ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgC0U-00026u-Dx
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:05:35 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgC0U-00026P-8E
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:05:34 -0500
Received: by mail-wm0-x232.google.com with SMTP id r141so77968500wmg.1
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:05:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487680479-15132-1-git-send-email-armbru@redhat.com>
References: <1487680479-15132-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 15:05:12 +0000
Message-ID: <CAFEAcA-LMO4vZBNSq7bAEj2oNnavSm1zUKZu8mPdNrhJuygqCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/11] Changes to -drive without if= and
 with if=scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 February 2017 at 12:34, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit b856256179f14c33a513d0b9cc3e4be355b95f43:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-usb-20170221-1' into staging (2017-02-21 09:35:15 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-block-2017-02-21
>
> for you to fetch changes up to f778a82f0c179634892ea716970d4d35264dc841:
>
>   hw/i386: Deprecate -drive if=scsi with PC machine types (2017-02-21 13:17:45 +0100)
>
> ----------------------------------------------------------------
> Changes to -drive without if= and with if=scsi
>
> ----------------------------------------------------------------
> Markus Armbruster (11):
>       hw: Default -drive to if=ide explicitly where it works
>       hw/arm/cubieboard hw/arm/xlnx-ep108: Fix units_per_default_bus
>       hw: Default -drive to if=none instead of ide when ide cannot work
>       hw: Default -drive to if=none instead of scsi when scsi cannot work
>       hw/arm/highbank: Default -drive to if=ide instead of if=scsi
>       blockdev: Improve message for orphaned -drive
>       blockdev: Make orphaned -drive fatal
>       hw: Drop superfluous special checks for orphaned -drive
>       hw/scsi: Concentrate -drive if=scsi auto-create in one place
>       hw: Deprecate -drive if=scsi with non-onboard HBAs
>       hw/i386: Deprecate -drive if=scsi with PC machine types

Applied, thanks.

-- PMM
