Received: from eggs.gnu.org ([2001:4830:134:3::10]:56853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cwRcm-0000BJ-SI
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:00:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cwRci-0005Iq-Dx
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:00:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cwRci-0005H1-8b
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:00:12 -0400
Message-ID: <1491562807.26308.47.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 07 Apr 2017 13:00:07 +0200
In-Reply-To: <3aff73da-2e94-eef5-c0db-74a4ded14311@ilande.co.uk>
References: <1491381329-3995-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1491560929.26308.41.camel@redhat.com>
	<3aff73da-2e94-eef5-c0db-74a4ded14311@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 00/14] TCX/CG3 adapter cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org

  Hi,

> Yes, I can do. I think it makes sense to merge them before your display
> thread-safety series, so if that still works for you I'll send a pull
> request early on when the tree opens for 2.10 to clear the way for your
> updates.

Sounds good.  Maybe I split the series anyway, first merge the snapshot
infrastructure patches, then all the display updates, finally revert the
temporary workaround, to reduce the ordering headaches.

cheers,
  Gerd
