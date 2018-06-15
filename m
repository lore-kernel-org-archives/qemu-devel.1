Received: from eggs.gnu.org ([2001:4830:134:3::10]:34152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <evgreen@chromium.org>) id 1fTxa5-0002hm-BW
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 18:52:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <evgreen@chromium.org>) id 1fTxa2-0002p8-9R
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 18:52:33 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:38805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <evgreen@chromium.org>)
	id 1fTxa2-0002mq-3H
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 18:52:30 -0400
Received: by mail-ot0-x243.google.com with SMTP id p95-v6so12685393ota.5
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 15:52:29 -0700 (PDT)
Received: from mail-ot0-f170.google.com (mail-ot0-f170.google.com.
	[74.125.82.170]) by smtp.gmail.com with ESMTPSA id
	t4-v6sm9811691otd.40.2018.06.15.15.52.27 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 15 Jun 2018 15:52:27 -0700 (PDT)
Received: by mail-ot0-f170.google.com with SMTP id 92-v6so12673416otw.9
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 15:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180531224911.23725-1-richard.henderson@linaro.org>
	<20180531224911.23725-7-richard.henderson@linaro.org>
	<788ee514-a026-d415-73ce-67cc996e6259@vivier.eu>
	<149da730-950c-a527-2373-9cb0433543b1@linaro.org>
	<d9298b1e-d600-879b-b19d-0e38e15dbbd6@vivier.eu>
	<5d817a6f-a963-148f-bb8d-f62b8f7c0207@linaro.org>
In-Reply-To: <5d817a6f-a963-148f-bb8d-f62b8f7c0207@linaro.org>
From: Evan Green <evgreen@chromium.org>
Date: Fri, 15 Jun 2018 15:51:50 -0700
Message-ID: <CAE=gft5EYwvZQKEWtfXQ0B7t3L4ckePvZ1p+ehGCQLhrUAtDDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 6/6] linux-user: Use *at functions to
 implement interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Apologies for getting lost in the dust storm, but where does this
leave this patch? Sounds like there's a real failure caused by it?
-Evan
On Thu, Jun 7, 2018 at 9:43 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 06/07/2018 01:01 AM, Laurent Vivier wrote:
> >> Your script doesn't work outside debian, lacking debootstrap.
> >> At the moment, I can't build on debian *at all*.  Some bit of the build
> >> infrastructure is off and QEMU_FULL_VERSION gets incorrectly defined.  I have
> >> no idea how or why it is different than Fedora.
> >
> > I had this problem on Fedora building in a separate directory, "make
> > distclean" at the top source directory fixed the problem for me.
>
> Thanks.  I had never seen this failure mode before.
>
>
> r~
