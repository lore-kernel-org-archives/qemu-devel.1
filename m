Received: from eggs.gnu.org ([2001:4830:134:3::10]:55353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cyiWo-0001qh-KZ
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cyiWl-0007TH-I3
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:27:30 -0400
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:60105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cyiWl-0007Rq-CR
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:27:27 -0400
Received: from player715.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 605AF31621
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 19:27:24 +0200 (CEST)
References: <1492076514-28821-1-git-send-email-clg@kaod.org>
	<1492076514-28821-6-git-send-email-clg@kaod.org>
	<cae91a9e-cc37-347f-d8fb-85a3173d9dcd@amsat.org>
	<20170413140818.flntaxvwt54a2pgp@var.youpi.perso.aquilenet.fr>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <779b9c49-dc28-22c5-80f9-4f1110459f5b@kaod.org>
Date: Thu, 13 Apr 2017 19:27:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170413140818.flntaxvwt54a2pgp@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/5] slirp: add a fake NC-SI backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Dmitry Fleytman <dmitry@daynix.com>

On 04/13/2017 04:08 PM, Samuel Thibault wrote:
> Hello,
>=20
> Philippe Mathieu-Daud=E9, on jeu. 13 avril 2017 08:45:23 -0300, wrote:
>>> The NCSI header file <ncsi-pkt.h> comes from mainline Linux
>=20
> Please mention within the file which file it comes from exactly.

OK.


>>> +    case NCSI_PKT_CMD_SMA:
>>> +        rnh->common.length =3D htons(4);
>>> +        break;
>>> +    case NCSI_PKT_CMD_GVI:
>>> +        rnh->common.length =3D htons(36);
>>> +        break;
>>> +    case NCSI_PKT_CMD_GC: {
>>> +        rnh->common.length =3D htons(32);
> ...
>>> +        break;
>>> +    }
>>> +
>>> +    case NCSI_PKT_CMD_GLS: {
>>> +        rnh->common.length =3D htons(16);
>>> +        break;
>>> +    }
>>> +
>>> +    slirp_output(slirp->opaque, ncsi_reply, sizeof(ncsi_reply));
>=20
> Are we really supposed to send sizeof(ncsi_reply), and not accordingly
> to the size announced withing the packet?

no. it should be: sizeof(header) + payload + 4.  I will that in the next=20
version.

=20
> Appart from that,
>=20
> Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks,

C.=20
=20
