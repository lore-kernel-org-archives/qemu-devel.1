Received: from eggs.gnu.org ([2001:4830:134:3::10]:34596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn2Ks-0005B1-A2
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn2Kr-00033G-KB
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:47:42 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fn2Kr-00032V-Dj
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:47:41 -0400
Received: by mail-oi0-x243.google.com with SMTP id k12-v6so28466739oiw.8
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 06:47:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180807130958.GQ7335@redhat.com>
References: <20180807114501.12370-1-peter.maydell@linaro.org>
	<20180807125223.GF2556@work-vm> <20180807125819.GP7335@redhat.com>
	<00ac9577-52cc-bf48-f0b8-7d15abb2c21f@redhat.com>
	<20180807130958.GQ7335@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Aug 2018 14:47:20 +0100
Message-ID: <CAFEAcA99ybqO=f+s2_S8ypU6-Hy5iRGwviFceaN8Trne+MA8jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0] slirp: Correct size check in
 m_inc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, "patches@linaro.org" <patches@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, liqsub1 <liqsub1@163.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-stable <qemu-stable@nongnu.org>

On 7 August 2018 at 14:09, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wr=
ote:
> On Tue, Aug 07, 2018 at 03:07:07PM +0200, Thomas Huth wrote:
>> But 864036e251f54c9 was never part of an official QEMU release, was it?
>> Or did it go into a stable release already? If not, I think you simply
>> need both patches to fix the CVE instead.
>
> Ah possibly - I  didn't look at where 864036e251f54c9 was actually
> release or not. If its onyl git master, then yeah, we can use the
> same CVE we already have.

Yeah, we haven't released anything with 864036e251f54c9 in it yet.
(In particular we did not flag it up for stable and so it is not
in 2.12.1...)

thanks
-- PMM
