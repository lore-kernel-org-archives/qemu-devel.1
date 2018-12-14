Received: from eggs.gnu.org ([2001:4830:134:3::10]:57149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gXkby-0000gl-Ox
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gXkbu-0001ub-4I
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:22:26 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17474
	helo=sender1.zoho.com.cn) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gXkbo-0001nX-A4
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:22:18 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
From: Fam Zheng <fam@euphon.net>
In-Reply-To: <20181214101355.GA31340@stefanha-x1.localdomain>
Date: Fri, 14 Dec 2018 18:21:32 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <181B5FB7-07A4-4B1F-9C8A-4633A5928577@euphon.net>
References: <CAFEAcA_=XAXoFRFUjZsDWb-8puO4b9CbB85DO+iRXiDrO9O7NA@mail.gmail.com>
	<20181214101355.GA31340@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] patchew.org using expired https certificate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>



> On Dec 14, 2018, at 18:13, Stefan Hajnoczi <stefanha@redhat.com> =
wrote:
>=20
> On Fri, Dec 14, 2018 at 09:54:06AM +0000, Peter Maydell wrote:
>> Connecting to https://patchew.org/ makes my browser complain:
>>=20
>> # patchew.org uses an invalid security certificate.
>> # The certificate expired on 19 November 2017, 00:27:00 GMT.
>> # The current time is 14 December 2018, 09:52.
>> # Error code: SEC_ERROR_EXPIRED_CERTIFICATE
>>=20
>> which is a bit odd, given I don't think this has been
>> broken since 2017. Did a cert-renewal script go wrong?
>=20
> Hi Fam,
> Let's Encrypt isn't set up correctly on patchew.org.  Any ideas?

I tried to solve a coming expiration but some misconfiguration and =
mistakes by me stoped it from working today, and I=E2=80=99m =
unfortunately hitting a rate limit of certbot operations. I=E2=80=99ll =
fix it when the limit is cleared (next week, hopefully). And until then, =
we=E2=80=99ll have to use HTTP. :(

Fam

>=20
> Also, is there a backup admin for the patchew VM at OSUOSL?  I have =
root
> access but I'd prefer for someone with patchew internals knowledge to =
be
> backup admin:
> https://wiki.qemu.org/AdminContacts
>=20
> Stefan
