Received: from eggs.gnu.org ([2001:4830:134:3::10]:35120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g9lVb-0000sz-Gj
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g9lVY-0007od-DB
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:28:43 -0400
Received: from mail.ispras.ru ([83.149.199.45]:43580)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1g9lVX-0007ju-7i
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:28:40 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
Date: Tue, 9 Oct 2018 09:28:36 +0300
Message-ID: <001201d45f99$4f710930$ee531b90$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH  00/21] Trace updates and plugin RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Any serious analysis tool should allow for us to track all memory
> accesses so I think the guest_mem_before trace point should probably
> be split into guest_mem_before_store and guest_mem_after_load. We
> could go the whole hog and add potential trace points for start/end of
> all memory operations.

I wanted to ask about memory tracing and found this one.
Is it possible to use tracepoints for capturing all memory accesses?
In our implementation we insert helpers before and after tcg read/write =
operations.

Pavel Dovgalyuk
