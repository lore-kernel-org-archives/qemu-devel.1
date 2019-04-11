Received: from eggs.gnu.org ([209.51.188.92]:43172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEczF-0003Ku-4e
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEczE-0002qo-3L
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:55:41 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEczC-0002pd-MW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:55:39 -0400
Received: by mail-oi1-x242.google.com with SMTP id w139so5497975oie.9
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 09:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190328062222.8409-1-joel@jms.id.au>
	<20190328062222.8409-2-joel@jms.id.au>
	<CAFEAcA_K1Rv1G-s=ndVYX6i_BvWME6ToShL6ZBpB4gnE3zdZdA@mail.gmail.com>
	<89438392-9a54-7f43-5dff-6ceeffaf9f3e@kaod.org>
	<8d05734c-2744-290f-0dbc-95f9c2502f21@redhat.com>
In-Reply-To: <8d05734c-2744-290f-0dbc-95f9c2502f21@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 17:55:26 +0100
Message-ID: <CAFEAcA_=uD6AQAd13deXjL83AQPsgxknjBE4jBRRJ9S4Z8nzZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw: timer: Add ASPEED RTC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 11 Apr 2019 at 17:37, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> On 4/11/19 5:30 PM, C=C3=A9dric Le Goater wrote:
> > On 4/11/19 5:25 PM, Peter Maydell wrote:
> >> This is missing a reset function and vmstate.
>
> Is vmstate mandatory for new devices.

Yes, I think so. You can have vmstate that says
"this can't be migrated" if you absolutely must, but
it's generally easy enough to make it properly migratable.
If the device generally has no state to migrate it
should at least provide a comment saying so.
(I think we should add a way to say this in a vmstate,
so that we can then assert that every device sets its
vmsd pointer to something.)

Failing to provide a vmstate means you have a machine
which will silently break if the user tries to do
savevm/loadvm, which is not very nice.

thanks
-- PMM
