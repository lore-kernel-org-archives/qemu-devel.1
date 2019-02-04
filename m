Received: from eggs.gnu.org ([209.51.188.92]:58540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gqg8B-0000Gq-9f
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:25:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gqg87-0002FC-GU
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:25:53 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35651)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gqg85-00020x-B0
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:25:49 -0500
Date: Mon, 4 Feb 2019 10:25:34 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190204152534.GA16991@flamenco>
References: <20181106112829.1948-1-kraxel@redhat.com>
	<20181106112829.1948-2-kraxel@redhat.com>
	<20190202003519.GA29706@flamenco>
	<20190204112033.52lvj2pjrolijx5v@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204112033.52lvj2pjrolijx5v@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PULL 1/1] update seabios to master snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Feb 04, 2019 at 12:20:33 +0100, Gerd Hoffmann wrote:
> > How can I bisect seabios? I can't find a recipe to generate
> > the .bin files included in this commit.
> 
> "make -C roms bios" will build it, using the roms/seabios submodule.

Thanks! This helped.

The regression was introduced between 1.11 and 1.12 by:
  96060ad ("tpm: Wait for interface startup when probing", 2018-03-02)

Fortunately, the issue is fixed right after the 1.12 tag by:
  42efebd ("tpm: Check for TPM related ACPI tables before attempting hw
            probe", 2018-11-27)

Are there any further seabios updates planned for 4.0? Would be
nice to get this fix in.

Thanks,

		Emilio
