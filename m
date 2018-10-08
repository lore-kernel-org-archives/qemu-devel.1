Received: from eggs.gnu.org ([2001:4830:134:3::10]:47106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9SI0-0006AK-Qx
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9S2v-0006jw-0d
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:41:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9S2u-0006jH-PX
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 05:41:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id 61-v6so19291026wrb.6
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 02:41:47 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-5-alex.bennee@linaro.org>
	<20181007014216.GC23787@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181007014216.GC23787@flamenco>
Date: Mon, 08 Oct 2018 10:41:45 +0100
Message-ID: <877eisojvq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 04/21] trace: enable the exec_tb trace
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>


Emilio G. Cota <cota@braap.org> writes:

> On Fri, Oct 05, 2018 at 16:48:53 +0100, Alex Benn=C3=A9e wrote:
>> Our performance isn't so critical that we can't spare a simple flag
>> check when we exec a TB considering everything else we check in the
>> outer loop.
>
> [I know this is just done to illustrate how function names
> in plugins can bind to tracing calls, but someone might
> get confused by expecting more from "exec_tb" than it
> actually does.]
>
> This flag check costs nothing because "exec_tb" is
> almost never called. The way it works right now, we
> need -d nochain for "exec_tb" to actually generate
> an event every time a TB executes.

I'll reword the commit a bit.

> IMO an eventual plugin API should let plugins decide whether
> to subscribe to the execution of a particular TB, when
> said TB is being translated, instead of providing
> an all-or-nothing switch.

Well we will want pre/post instruction translation hooks which would be
the obvious place to add this. Using -d nochain is a useful enough hack
for now.

>
> Thanks,
>
> 		E.


--
Alex Benn=C3=A9e
