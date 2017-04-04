Received: from eggs.gnu.org ([2001:4830:134:3::10]:37836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvHi5-0003eR-NU
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cvHi2-0004ir-KZ
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:12:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cvHi2-0004iK-Eg
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:12:54 -0400
Message-ID: <1491286370.1455.22.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 04 Apr 2017 08:12:50 +0200
In-Reply-To: <81c92413-024a-5448-1160-b24ca944e88e@ilande.co.uk>
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
	<1490881315.28523.11.camel@redhat.com>
	<e0df6143-81f2-a0e7-2c23-90dd01724e9f@redhat.com>
	<1491221026.17505.39.camel@redhat.com>
	<b8daec8e-86ed-56e6-d42d-d948508e5b6f@ilande.co.uk>
	<1491223335.17505.48.camel@redhat.com>
	<81c92413-024a-5448-1160-b24ca944e88e@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [RfC PATCH 0/4] make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

  Hi,

> -    unsigned long align =3D 1 << (TARGET_PAGE_BITS + BITS_PER_LEVEL);
> +    unsigned long align =3D 1UL << (TARGET_PAGE_BITS + BITS_PER_LEVEL);

> There were 2 issues here: without the UL suffix on align I was getting
> incorrect first/last addresses since the high bits of align weren't
> being cleared,

Ah, thanks, I'll add that.

> and then offset appeared to be shifted twice.

Yep, noticed that too meanwhile, fixed in the branch pushed half an hour
ago.  I've dropped the other shift though ;)

cheers,
  Gerd
