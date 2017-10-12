Received: from eggs.gnu.org ([2001:4830:134:3::10]:50400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2dYC-00089E-S5
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e2dY7-0006Zd-Rv
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:29:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e2dY7-0006ZH-Lu
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:29:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3EBF2D0FAD
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 13:29:18 +0000 (UTC)
Message-ID: <1507814955.24675.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 12 Oct 2017 15:29:15 +0200
In-Reply-To: <20171012112157.15647-1-marcandre.lureau@redhat.com>
References: <20171012112157.15647-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb-ccid: remove needless migration state
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On Thu, 2017-10-12 at 13:21 +0200, Marc-Andr=C3=A9 Lureau wrote:
> This code appears to be unused since its introduction. It should be
> safe to remove from VMState.

Well, almost:

> @@ -1452,7 +1431,6 @@ static VMStateDescription ccid_vmstate =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_STRUCT_AR=
RAY(pending_answers, USBCCIDState,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0PENDING_ANSWERS_NUM, 1, answer_vmstate,
> Answer),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_UINT32(pe=
nding_answers_num, USBCCIDState),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_UINT8(migratio=
n_state, USBCCIDState),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_UINT32(st=
ate_vmstate, USBCCIDState),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0VMSTATE_END_OF_LI=
ST()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}

We have to keep this (or some placeholder) so the vmstate format
doesn't change.

cheers,
   Gerd
