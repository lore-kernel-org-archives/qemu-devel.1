Received: from eggs.gnu.org ([2001:4830:134:3::10]:47342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnOwM-0000p9-FQ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnOwL-0006Ss-BK
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:51:22 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:34556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnOwL-0006Sa-5B
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 08:51:21 -0400
Received: by mail-wm0-x232.google.com with SMTP id 137so8337967wmj.1
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 05:51:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2017 13:50:59 +0100
Message-ID: <CAFEAcA_Enhiay0P2Q_jLJ1LVQzWVzUam6eCdKH+AcYVuQpw5AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/44] first batch of s390x patches for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>

On 30 August 2017 at 17:52, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit 1ab5eb4efb91a3d4569b0df6e824cc08ab4bd8ec:
>
>   Update version for v2.10.0 release (2017-08-30 17:02:54 +0100)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170830
>
> for you to fetch changes up to 2f21b8d431030bcb7478ee9521bdfd3d0ef3901d:
>
>   s390x/pci: fixup trap_msix() (2017-08-30 18:23:26 +0200)
>
> ----------------------------------------------------------------
> First batch of s390x patches:
> - 2.11 compat machine
> - support the new --s390-pgste linker option, making it possible to
>   avoid enabling the global vm.allocate_pgste systl if all pieces
>   are in place
> - correctly identify some devices as not hotpluggable
> - clean up some tests and enable them for s390x
> - wire up the diag288 watchdog in tcg
> - clean up dependencies on CONFIG_PCI, making it possible to disable
>   it by hand
> - lots of cleanup in target/s390x/
> - fix alignment of the ccw1 structure in the s390-ccw bios
> - and some more bugfixes
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
