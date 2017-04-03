Received: from eggs.gnu.org ([2001:4830:134:3::10]:43740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cv0iK-0006xX-Kv
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cv0iH-0007SJ-If
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:04:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cv0iH-0007S5-DC
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:04:01 -0400
Message-ID: <1491221026.17505.39.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 03 Apr 2017 14:03:46 +0200
In-Reply-To: <e0df6143-81f2-a0e7-2c23-90dd01724e9f@redhat.com>
References: <1490856931-21732-1-git-send-email-kraxel@redhat.com>
	<e1ccd5bc-f683-93b7-374d-0707765a8715@ilande.co.uk>
	<1490881315.28523.11.camel@redhat.com>
	<e0df6143-81f2-a0e7-2c23-90dd01724e9f@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

  Hi,

> I checked the branch, is bitmap_copy_and_clear_atomic correct when you
> have partial updates?  Maybe you need to handle partial updates of the
> first and last word?

Should not be a problem.  We might clear some more bits, but these are
outsize the visible area so they should cause visible corruption (and if
the visible area changes the display code needs to do a full refresh
anyway).

cheers,
  Gerd
