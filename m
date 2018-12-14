Received: from eggs.gnu.org ([2001:4830:134:3::10]:37533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXl25-0007cS-6L
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:49:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXl23-0001dM-S2
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:49:25 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:33739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXl23-0001YD-2Y
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:49:23 -0500
Received: by mail-ot1-x32d.google.com with SMTP id i20so5000800otl.0
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 02:49:23 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_=XAXoFRFUjZsDWb-8puO4b9CbB85DO+iRXiDrO9O7NA@mail.gmail.com>
	<20181214101355.GA31340@stefanha-x1.localdomain>
	<181B5FB7-07A4-4B1F-9C8A-4633A5928577@euphon.net>
In-Reply-To: <181B5FB7-07A4-4B1F-9C8A-4633A5928577@euphon.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 10:49:08 +0000
Message-ID: <CAFEAcA-g15s9y94zPEtQEqfKgqH18igTRFYFpowoQLSi1ssJOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] patchew.org using expired https certificate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fam@euphon.net
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 14 Dec 2018 at 10:22, Fam Zheng <fam@euphon.net> wrote:
> I tried to solve a coming expiration but some misconfiguration and mistak=
es by me stoped it from working today, and I=E2=80=99m unfortunately hittin=
g a rate limit of certbot operations. I=E2=80=99ll fix it when the limit is=
 cleared (next week, hopefully). And until then, we=E2=80=99ll have to use =
HTTP. :(

If this is the "5 duplicate certs a week" limit, you could
work around it by adding "randomextrasubdomain.patchew.org"
to the list of hostnames in the cert :-)

thanks
-- PMM
