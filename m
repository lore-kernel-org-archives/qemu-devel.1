Received: from eggs.gnu.org ([2001:4830:134:3::10]:40647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYusS-0000QL-Kd
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:23:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYusO-0007US-KJ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:23:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYusO-0007UD-EN
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:23:08 -0500
Message-ID: <1485955386.1076.57.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 01 Feb 2017 14:23:06 +0100
In-Reply-To: <20170131115926.7132.9645.stgit@PASHA-ISP>
References: <20170131115926.7132.9645.stgit@PASHA-ISP>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] replay: add record/replay for audio
 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

  Hi,

>      if (audio_is_timer_needed ()) {
>          if (!timer_pending(s->ts)) {
> -            timer_mod (s->ts,
> +            timer_mod(s->ts,
>                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + conf.period.tick=
s);
>          }
>      }

whitespace change sneaked in.

Otherwise looks sane to me, I don't know much about replay though.

cheers,
  Gerd
