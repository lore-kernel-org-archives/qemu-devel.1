Received: from eggs.gnu.org ([2001:4830:134:3::10]:35474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db5WQ-0002NA-KM
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db5WP-00060d-Qw
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:41:42 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1db5WP-0005zp-Jd
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:41:41 -0400
Received: by mail-wm0-x229.google.com with SMTP id t201so126145480wmt.1
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 06:41:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170728133430.GS12364@stefanha-x1.localdomain>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<20170726112633.GE18489@stefanha-x1.localdomain>
	<CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
	<20170727104302.GI2555@redhat.com>
	<CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	<20170727152137.GW2555@redhat.com>
	<CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
	<20170727154535.GY2555@redhat.com>
	<20170728133430.GS12364@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2017 14:41:19 +0100
Message-ID: <CAFEAcA9p38P2x3s4grvFPkGaH+JEmwqyAC9SsLWqqFL8k+Eiww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/13] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>, QEMU Developers <qemu-devel@nongnu.org>

On 28 July 2017 at 14:34, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Llu=C3=ADs/Peter: What are the requirements for instrumentation code
> interacting with the running QEMU instance?  simpletrace is
> asynchronous, meaning it does not wait for anyone handle the trace event
> before continuing execution, and is therefore not suitable for
> SystemTap-style scripts that can interact with the program while
> handling a trace event.

I think you'd probably want synchronous -- it's pretty helpful
to be able to say "register a trace event hook that doesn't
fire very often, and use that to get to the region of
execution that's of interest to you, then enable more hooks
to get more detail at that point". (For instance, "wait til
we've executed 5,000,000 instructions, then turn on the
tracing of all instruction execution, register modification
and memory accesses".)

thanks
-- PMM
