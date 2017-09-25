Received: from eggs.gnu.org ([2001:4830:134:3::10]:48873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dwZGZ-0005LP-3u
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dwZGW-0005km-0A
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:42:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dwZGV-0005kY-QP
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 15:42:03 -0400
Date: Mon, 25 Sep 2017 15:42:02 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170925194202.GA19618@flamenco>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<150529666493.10902.14830445134051381968.stgit@frigg.lan>
	<CAFEAcA9p9B8AFaaSaSOOSsFsEhHW=XPLBFs5MrozWq=7p4_9Zg@mail.gmail.com>
	<87poasgjyh.fsf@frigg.lan>
	<CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
	<87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
	<87o9pywt8k.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o9pywt8k.fsf@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Sep 25, 2017 at 21:03:39 +0300, Lluís Vilanova wrote:
> I know it's not exactly the same we're discussing, but the plot in [1] compares
> a few different ways to trace memory accesses on SPEC benchmarks:
> 
> * First bar is using a Intel's tool called PIN [2].
> * Second is calling into an instrumentation function on every executed memory
>   access in QEMU.
> * Third is embedding the hot path of writing the memory access info to an array
>   into the TCG opcode stream (more or less equivalent to supporting filtering;
>   when the array is full, a user's callback is called - cold path -)
> * Fourth bar can be ignored.
> 
> This was working on a much older version of instrumentation for QEMU, but I can
> implement something that does the first use-case point above and some filtering
> example (second use-case point) to see what's the performance difference.
> 
> [1] https://filetea.me/n3wy9WwyCCZR72E9OWXHArHDw

Interesting! Unfortunately, this URL gives me a 404.

		E.
