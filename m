Received: from eggs.gnu.org ([209.51.188.92]:51372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqcPC-00059r-Hz
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqcNn-0005Wr-H4
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:25:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqcNn-0005Of-5N
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 06:25:47 -0500
Date: Mon, 4 Feb 2019 12:20:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190204112033.52lvj2pjrolijx5v@sirius.home.kraxel.org>
References: <20181106112829.1948-1-kraxel@redhat.com>
	<20181106112829.1948-2-kraxel@redhat.com>
	<20190202003519.GA29706@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190202003519.GA29706@flamenco>
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
Cc: qemu-devel@nongnu.org

  Hi,

> How can I bisect seabios? I can't find a recipe to generate
> the .bin files included in this commit.

"make -C roms bios" will build it, using the roms/seabios submodule.

HTH,
  Gerd
