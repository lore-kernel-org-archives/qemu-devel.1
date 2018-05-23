Received: from eggs.gnu.org ([2001:4830:134:3::10]:58869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLSID-0007vl-I0
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLSIC-0005CM-PI
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:50:57 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:37595)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLSIC-0005Bz-KT
	for qemu-devel@nongnu.org; Wed, 23 May 2018 07:50:56 -0400
Received: by mail-ot0-x241.google.com with SMTP id 77-v6so24832709otd.4
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 04:50:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <013774a0-6ec4-7a37-79c7-d3068b4cc5bc@kaod.org>
References: <20180522173713.26282-1-peter.maydell@linaro.org>
	<d8c13782-48b1-0975-ee2c-0d2ec2eecebe@kaod.org>
	<CAFEAcA_3P-JEsiz_3ZdVhG2kcQ+Y3yOAufLQtHknuzufRosANQ@mail.gmail.com>
	<013774a0-6ec4-7a37-79c7-d3068b4cc5bc@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 May 2018 12:50:35 +0100
Message-ID: <CAFEAcA-2q246LU77uxfwsdfE_iQ3ZNnqsrqZ-PQUc+zWGRGpDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Correct CPACR reset value for v7 cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 23 May 2018 at 10:13, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On 05/22/2018 09:26 PM, Peter Maydell wrote:
>> (You're not using trustzone, are you? I know of a bug with
>> migration of cpus with TZ enabled which I'm probably going to
>> look at later this week)
>
> The PSR is :
>
>         PSR=3D20000093 --C- A S svc32
>
> 'S' for secure. Is that also trustzone ?

Yes. In that case this very likely is the same bug (we don't
migrate the secure-bank registers properly, so if Linux
is executing in secure state it doesn't resume right).

thanks
-- PMM
