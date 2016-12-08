Received: from eggs.gnu.org ([2001:4830:134:3::10]:52389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cF0nI-0006wQ-8w
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:39:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cF0nF-00036h-6y
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:39:36 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cF0nF-000339-2W
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:39:33 -0500
Received: by mail-vk0-f44.google.com with SMTP id p9so230831207vkd.3
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 07:39:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c1475981-5d6f-a623-525c-fa72b101a96b@redhat.com>
References: <CAFEAcA9kODkdK96a=rdZS7+xSW0drj4vLMev-AVio-uewm6Cbw@mail.gmail.com>
	<20161207120419.GA1476@redhat.com>
	<CAFEAcA8UofRa9Yo93vsFYDqJaW5YuKKF68X+2ae=GKdp8w9HWg@mail.gmail.com>
	<20161207140715.GB1476@redhat.com>
	<CAFEAcA-8P3cv=ce_jjQRAa5Oh-1EDUByuJq-tX2sX29vVm-5mQ@mail.gmail.com>
	<20161207142449.GC1476@redhat.com>
	<CAFEAcA-riLzPyfT+CSbEgLzRoJiGVRByk7Ft7EdDqhVcOH4vHg@mail.gmail.com>
	<c1475981-5d6f-a623-525c-fa72b101a96b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Dec 2016 15:37:50 +0000
Message-ID: <CAFEAcA9R=_Fc-eV+yOH1ZhC8tQdVKSqfHWmTtG2mgJEVp46LSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu -netdev tun/tap support can't handle macvtap
 type devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 8 December 2016 at 01:52, Jason Wang <jasowang@redhat.com> wrote:
> On 2016=E5=B9=B412=E6=9C=8807=E6=97=A5 22:32, Peter Maydell wrote:
>> It's particularly confusing in this case that fd=3D doesn't work with
>> queues=3D, because the user isn't trying to pass multiple fds, just
>> the one is fine.
>
>
> Since fd can only accept on file descriptor, so it implies 1 queue. For
> "fds", specifying queues seems redundant, since qemu can count the #fds b=
y
> itself.

Opening /dev/net/tun like net/tap-linux.c does also only gives
you one file descriptor, but it still supports multiple queues,
unless I'm misunderstanding how this works (quite possible).

thanks
-- PMM
