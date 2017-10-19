Received: from eggs.gnu.org ([2001:4830:134:3::10]:41293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e5EBk-0005q9-VU
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 13:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e5EBh-0004Be-Qe
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 13:00:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1e5EBh-0004BQ-K5
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 13:00:53 -0400
Date: Thu, 19 Oct 2017 13:00:52 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1042799717.30087374.1508432452336.JavaMail.zimbra@redhat.com>
In-Reply-To: <f70e846f-fd53-93ad-6cd8-84fbb0960e39@linux.vnet.ibm.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<523bf8e7-0be0-0db9-83da-4e7d7449562f@linux.vnet.ibm.com>
	<969297048.30042590.1508423615378.JavaMail.zimbra@redhat.com>
	<6b6eb9ff-b9de-7480-3f0d-ee2e7b5ab3b1@linux.vnet.ibm.com>
	<f70e846f-fd53-93ad-6cd8-84fbb0960e39@linux.vnet.ibm.com>
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
Cc: amarnath valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org

Hi

----- Original Message -----
> On 10/19/2017 10:44 AM, Stefan Berger wrote:
> > On 10/19/2017 10:33 AM, Marc-Andr=C3=A9 Lureau wrote:
> >> Hi Stefan
> >>
> >> ----- Original Message -----
> >>> On 10/09/2017 06:55 PM, Marc-Andr=C3=A9 Lureau wrote:
> >>>> Hi,
> >>>>
> >>>> I accumulated a series of patch doing some TPM code cleanup while
> >>>> doing review. I removed some dead code, simplified other parts, and
> >>>> tried to isolate implementation of the backend and frontend by using=
 a
> >>>> new TPMIf interface. I solved a few issues, and added some FIXME for
> >>>> what should be tackled.  Finally, I implemented a simple CRB device
> >>>> (tpm 2.0) that is work in progress for now - it works fine with
> >>>> passthrough, but swtpm/libtpms with win10 has some issues that need
> >>>> more investigations.
> >>>>
> >>>> seabios CRB support is required for TPM 2.0 & emulation
> >>>> (https://mail.coreboot.org/pipermail/seabios/2017-October/011839.htm=
l)
> >>>>
> >>>> Comments/review welcome!
> >>> Are you going to post a v2 soon?
> >> I was wondering if you would take the patches that you already
> >> reviewed for the next pull request. That way v2 would be smaller.
> >
> > I'll take them up to 21/42.
>=20
> Tested them and it seems to work fine. I'll post later today.
>=20
> Did you have any more luck with win10 and tpm2 ?

I haven't had time so far to investigate further.

The summary was that Windows refuses to talk with a TPM2/TIS device (it doe=
sn't even shows up in device list), while TPM2/CRB is being recognized and =
communicated with. However, there are some failure with swtpm/libtpms that =
are unclear, and will require more verbosity in libtpms. I plan to resume t=
his effort in a few weeks.

Thanks
