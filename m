Received: from eggs.gnu.org ([2001:4830:134:3::10]:55352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cyfQB-0007F8-BO
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1cyfQ7-0000YX-D1
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:08:27 -0400
Date: Thu, 13 Apr 2017 16:08:18 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170413140818.flntaxvwt54a2pgp@var.youpi.perso.aquilenet.fr>
References: <1492076514-28821-1-git-send-email-clg@kaod.org>
	<1492076514-28821-6-git-send-email-clg@kaod.org>
	<cae91a9e-cc37-347f-d8fb-85a3173d9dcd@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cae91a9e-cc37-347f-d8fb-85a3173d9dcd@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] slirp: add a fake NC-SI backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Dmitry Fleytman <dmitry@daynix.com>

Hello,

Philippe Mathieu-Daudé, on jeu. 13 avril 2017 08:45:23 -0300, wrote:
> > The NCSI header file <ncsi-pkt.h> comes from mainline Linux

Please mention within the file which file it comes from exactly.

> > +    case NCSI_PKT_CMD_SMA:
> > +        rnh->common.length = htons(4);
> > +        break;
> > +    case NCSI_PKT_CMD_GVI:
> > +        rnh->common.length = htons(36);
> > +        break;
> > +    case NCSI_PKT_CMD_GC: {
> > +        rnh->common.length = htons(32);
...
> > +        break;
> > +    }
> > +
> > +    case NCSI_PKT_CMD_GLS: {
> > +        rnh->common.length = htons(16);
> > +        break;
> > +    }
> > +
> > +    slirp_output(slirp->opaque, ncsi_reply, sizeof(ncsi_reply));

Are we really supposed to send sizeof(ncsi_reply), and not accordingly
to the size announced withing the packet?

Appart from that,

Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Samuel
