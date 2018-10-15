Received: from eggs.gnu.org ([2001:4830:134:3::10]:33674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gC7R9-0007qq-J9
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gC7R8-0001mQ-Qr
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:17:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gC7R8-0001lp-HU
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 14:17:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id q5-v6so22468008wrw.12
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 11:17:50 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-9-alex.bennee@linaro.org>
	<07e7c534-c9b4-4d07-6f1a-797b2904d9e4@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <07e7c534-c9b4-4d07-6f1a-797b2904d9e4@linaro.org>
Date: Mon, 15 Oct 2018 19:17:47 +0100
Message-ID: <87ftx73whg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 08/21] accel/tcg/cputlb: convert
 remaining tlb_debug() to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, cota@braap.org, Pavel.Dovgaluk@ispras.ru, Paolo Bonzini <pbonzini@redhat.com>, vilanova@ac.upc.edu, Richard Henderson <rth@twiddle.net>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/5/18 8:48 AM, Alex Benn=C3=A9e wrote:
>> To avoid overly long lines in trace events I've split the event into
>> tlb_set_page and tlb_set_page_attrs.
>
> I don't think this split is a good idea.  It allows data from different t=
hreads
> to be interleaved.

Won't we soon have a lock serialising this?

It was mainly to shut-up checkpatch because the trace-events don't seem
to do multi-line.

--
Alex Benn=C3=A9e
