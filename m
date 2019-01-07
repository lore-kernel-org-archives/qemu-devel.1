Received: from eggs.gnu.org ([209.51.188.92]:52585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggRfg-0007so-50
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggRff-0005qI-GU
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:58:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggRff-0005pu-BE
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 04:58:11 -0500
Date: Mon, 7 Jan 2019 10:58:09 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190107095809.2rcbvrf6igqorf5z@sirius.home.kraxel.org>
References: <cover.1545598229.git.DirtY.iCE.hu@gmail.com>
	<5f0cba98be3d59c4f1d6118b0554429f9e7b3ceb.1545598229.git.DirtY.iCE.hu@gmail.com>
	<fae00c2a-032a-a36a-bd86-e23aab2a53cd@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fae00c2a-032a-a36a-bd86-e23aab2a53cd@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 27/52] audio: use size_t where makes
 sense
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

  Hi,

> >  void AUD_close_out (QEMUSoundCard *card, SWVoiceOut *sw);
> > -int  AUD_write (SWVoiceOut *sw, void *pcm_buf, int size);
> 
> Can you add short documentation while modifying headers? Such:
> 
> /**
>  * AUD_write:
>  *
>  * Returns: the number of bytes written.
>  */

While this certainly makes sense I don't think this should be done as
part of this patch series, it is already big enough as-is.

cheers,
  Gerd
