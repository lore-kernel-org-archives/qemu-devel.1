Received: from eggs.gnu.org ([2001:4830:134:3::10]:51982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsr0P-0005hM-EE
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsr0O-0003x6-Gw
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:50:05 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:43735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsr0O-0003wa-8f
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:50:04 -0400
Received: by mail-wm0-x22f.google.com with SMTP id a137so2923845wma.0
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 06:50:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <877ex0gjnd.fsf@frigg.lan>
References: <150525010239.15988.8172586618197849619.stgit@frigg.lan>
	<CAFEAcA-rmX=gUdYTLK4g5TAWVTkCfkbkXXfCxmaaivv8XGdMXg@mail.gmail.com>
	<877ex0gjnd.fsf@frigg.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Sep 2017 14:49:42 +0100
Message-ID: <CAFEAcA9Ux91tSfYpE_giuSHBEuZEuHeNsp=79h=aHwO2N85cgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/22] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 15 September 2017 at 14:45, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> wr=
ote:
> Do you have an opinion on specific trace points, or an observation in gen=
eral?
>
> I wanted to have the following events:
>
> * cpu hotplug/hotunplug
> * cpu reset
> * memory access translation/execution
> * BBL/TB translation/execution
> * instruction translation/execution
> * exceptions / syscalls

My initial stab at a "basic" set of events would be:
 * instruction executes
 * memory accesses
 * exceptions

But the better approach would probably be to survey the
existing trace APIs in other models.

thanks
-- PMM
