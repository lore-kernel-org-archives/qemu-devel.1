Received: from eggs.gnu.org ([2001:4830:134:3::10]:54729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQZjM-0002hz-5Y
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:43:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQZjL-0002ZQ-9J
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:43:36 -0400
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:35482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQZjL-0002Yx-5I
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 09:43:35 -0400
Received: by mail-io0-x230.google.com with SMTP id h134so7119364iof.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 06:43:35 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <87lgoax6t0.fsf@linaro.org>
References: <20170621154244.28309-1-alex.bennee@linaro.org>
	<20170621154244.28309-3-alex.bennee@linaro.org>
	<42ab61f5-47f3-030d-264b-78d3f11d8e20@amsat.org>
	<87lgoax6t0.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 29 Jun 2017 10:43:32 -0300
Message-ID: <CAAdtpL4CTYBOvrxp4SD+oTn_cE=z=ickg0NJ_qNu5fy2Xey3tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v6 02/10] build-all-archs: support
 cross building via docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Thu, Jun 29, 2017 at 10:27 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>> On 06/21/2017 12:42 PM, Alex Benn=C3=A9e wrote:> By default we use the Q=
EMU
>> projects qemu:debian-FOO-cross images as
>>> RISU hackers are likely to be QEMU developers too. However any docker
>>> tag can be passed on the command line.
>>
>> Any thought about starting to push images?
>
> I think it comes down to how much we trust Docker Hub and how much we
> trust whoever does the pushing. Would it be an automatic thing? From
> shippable?

Surely automatic.

Docker Hub offer free builds but you have to provide a full Dockerfile
(which is generated in QEMU).
We might keep those files in the repo... I'll give this a try.
The other possibilities are Travis and Shippable with a bit more
complicated setup.
