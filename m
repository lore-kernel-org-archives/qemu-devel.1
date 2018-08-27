Received: from eggs.gnu.org ([208.118.235.92]:58561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fuFsJ-0005Ha-0q
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fuFjQ-0004VL-53
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:30:53 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fuFjO-0004Qp-VC
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:30:51 -0400
Received: by mail-oi0-x242.google.com with SMTP id r69-v6so25999734oie.3
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 04:30:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180827060744.13770-1-armbru@redhat.com>
References: <20180827060744.13770-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Aug 2018 12:30:27 +0100
Message-ID: <CAFEAcA8kjhJfrwqYRD1cVb4W=0A9TXNg4Yst0JP4MPypBaQgdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Error reporting patches for 2018-08-27
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

On 27 August 2018 at 07:07, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 235c82acca0491465e94be3cae2583b42d37c859:
>
>   Merge remote-tracking branch 'remotes/otubo/tags/pull-seccomp-20180823' into staging (2018-08-25 13:08:57 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2018-08-27
>
> for you to fetch changes up to d111ed70a7d0357dfe92548768751a2b9fadacbc:
>
>   intel-iommu: replace more vtd_err_* traces (2018-08-27 06:38:45 +0200)
>
> ----------------------------------------------------------------
> Error reporting patches for 2018-08-27
>
> * Provide error_report_once(), along with first users
>
> ----------------------------------------------------------------

Compile failure on OSX:

/Users/pm215/src/qemu-for-merges/hw/i386/intel_iommu.c:1069:31: error:
format specifies type 'unsigned short' but the argument has type 'int'
[-Werror,-Wformat]
                              pci_bus_num(vtd_as->bus), vtd_as->devfn);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/Users/pm215/src/qemu-for-merges/include/qemu/error-report.h:58:33:
note: expanded from macro 'error_report_once'
            error_report(fmt, ##__VA_ARGS__);   \
                                ^~~~~~~~~~~
/Users/pm215/src/qemu-for-merges/hw/i386/intel_iommu.c:1069:57: error:
format specifies type 'unsigned short' but the argument has type
'uint8_t' (aka 'unsigned char') [-Werror,-Wformat]
                              pci_bus_num(vtd_as->bus), vtd_as->devfn);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
/Users/pm215/src/qemu-for-merges/include/qemu/error-report.h:58:33:
note: expanded from macro 'error_report_once'
            error_report(fmt, ##__VA_ARGS__);   \
                                ^~~~~~~~~~~
2 errors generated.


thanks
-- PMM
