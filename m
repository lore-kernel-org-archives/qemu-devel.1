Received: from eggs.gnu.org ([209.51.188.92]:51541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggRcX-0005gu-60
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:54:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggRcW-0004D2-Jt
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:54:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggRcW-0004Cl-EJ
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:54:56 -0500
Date: Mon, 7 Jan 2019 10:54:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190107095454.cokxnwinrqmtsfl5@sirius.home.kraxel.org>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<11a6562f583531e5a5473716bea44ee3ae7be120.1545598229.git.DirtY.iCE.hu@gmail.com>
	<66e793ef-dd32-eb81-14f5-cf59ca8c73bb@amsat.org>
	<980b862a-9c2d-8ab7-2937-846524399148@gmail.com>
	<42f870e2-97bc-1028-3587-d9ae31537a13@amsat.org>
	<20a6e023-89be-f2e1-aa11-0686a1dfe021@gmail.com>
	<3ff67b65-935e-9149-05a7-543752723b06@amsat.org>
	<c82a6572-bcb7-3577-7332-5420c8cfdbb0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c82a6572-bcb7-3577-7332-5420c8cfdbb0@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 23/52] audio: remove audio_MIN, audio_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <dirty.ice.hu@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>

> The first one is fixable with an explicit cast (ugly but works), but the
> second one is more problematic. It means we can't write stuff like
> 
> USBPort  uports[MAX(MAXPORTS_2, MAXPORTS_3)];
> 
> when not in a function. So we either need a dumb version of MIN/MAX, or
> scrape the idea altogether.

const_max() for stuff which is a compile time constant maybe?

cheers,
  Gerd
