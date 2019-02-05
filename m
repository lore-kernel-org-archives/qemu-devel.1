Received: from eggs.gnu.org ([209.51.188.92]:50507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqvqg-0006Ln-FF
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:12:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqvqf-0003vr-Oi
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:12:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqvqf-0003um-J6
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:12:53 -0500
Date: Tue, 5 Feb 2019 09:12:50 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190205081250.2lixmdjrc6ag7sbe@sirius.home.kraxel.org>
References: <20181106112829.1948-1-kraxel@redhat.com>
	<20181106112829.1948-2-kraxel@redhat.com>
	<20190202003519.GA29706@flamenco>
	<20190204112033.52lvj2pjrolijx5v@sirius.home.kraxel.org>
	<20190204152534.GA16991@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204152534.GA16991@flamenco>
Subject: Re: [Qemu-devel] [PULL 1/1] update seabios to master snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, seabios@seabios.org

On Mon, Feb 04, 2019 at 10:25:34AM -0500, Emilio G. Cota wrote:
> On Mon, Feb 04, 2019 at 12:20:33 +0100, Gerd Hoffmann wrote:
> > > How can I bisect seabios? I can't find a recipe to generate
> > > the .bin files included in this commit.
> > 
> > "make -C roms bios" will build it, using the roms/seabios submodule.
> 
> Thanks! This helped.
> 
> The regression was introduced between 1.11 and 1.12 by:
>   96060ad ("tpm: Wait for interface startup when probing", 2018-03-02)
> 
> Fortunately, the issue is fixed right after the 1.12 tag by:
>   42efebd ("tpm: Check for TPM related ACPI tables before attempting hw
>             probe", 2018-11-27)
> 
> Are there any further seabios updates planned for 4.0? Would be
> nice to get this fix in.

Created 1.12-stable branch and cherry-picked this fix.
We'll do a 1.12.1 stable release in time for qemu 4.0.

cheers,
  Gerd
