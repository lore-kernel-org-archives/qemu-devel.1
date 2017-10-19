Received: from eggs.gnu.org ([2001:4830:134:3::10]:55036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e5BtG-0003jf-Kg
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e5BtD-0000Vu-Hu
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:33:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1e5BtD-0000Rl-C1
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:33:39 -0400
Date: Thu, 19 Oct 2017 10:33:35 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <969297048.30042590.1508423615378.JavaMail.zimbra@redhat.com>
In-Reply-To: <523bf8e7-0be0-0db9-83da-4e7d7449562f@linux.vnet.ibm.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<523bf8e7-0be0-0db9-83da-4e7d7449562f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/42] TPM: code cleanup & CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, amarnath valluri <amarnath.valluri@intel.com>

Hi Stefan

----- Original Message -----
> On 10/09/2017 06:55 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >
> > I accumulated a series of patch doing some TPM code cleanup while
> > doing review. I removed some dead code, simplified other parts, and
> > tried to isolate implementation of the backend and frontend by using a
> > new TPMIf interface. I solved a few issues, and added some FIXME for
> > what should be tackled.  Finally, I implemented a simple CRB device
> > (tpm 2.0) that is work in progress for now - it works fine with
> > passthrough, but swtpm/libtpms with win10 has some issues that need
> > more investigations.
> >
> > seabios CRB support is required for TPM 2.0 & emulation
> > (https://mail.coreboot.org/pipermail/seabios/2017-October/011839.html)
> >
> > Comments/review welcome!
>=20
> Are you going to post a v2 soon?

I was wondering if you would take the patches that you already reviewed for=
 the next pull request. That way v2 would be smaller.

thanks
