Received: from eggs.gnu.org ([209.51.188.92]:47918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1glbd4-00067w-DB
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1glbd2-0007Gr-EB
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:36:50 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:38197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1glbd0-0007D1-Fh
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:36:48 -0500
Received: by mail-wm1-x32c.google.com with SMTP id m22so11281061wml.3
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 07:36:46 -0800 (PST)
References: <20190116191950.94110-1-emaste@freefall.freebsd.org>
	<20190118144724.66914-1-emaste@freebsd.org>
	<87a7ju1de5.fsf@linaro.org>
	<CAPyFy2CTXcq2ue7BVAHWeOtCh4+ovtKHvgMDoVhetNKdKRTSsQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAPyFy2CTXcq2ue7BVAHWeOtCh4+ovtKHvgMDoVhetNKdKRTSsQ@mail.gmail.com>
Date: Mon, 21 Jan 2019 15:36:43 +0000
Message-ID: <877eey10qc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freebsd.org>
Cc: qemu-devel <qemu-devel@nongnu.org>


Ed Maste <emaste@freebsd.org> writes:

> On Mon, 21 Jan 2019 at 06:03, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> I should be able to add CirrusCI to the QEMU project github when we
>> merge. I see there is another revision coming in so I''ll wait for that
>> before I queue it up.
>
> Do you mean my eadd119 commit "cirrus: tail dmesg to see if this is
> due to OOM"? I didn't intend to submit that (at least not in exactly
> the current form); I added it while looking at what I believe was a
> transient Cirrus failure.

Ahh no - I thought Thomas had a failure with long build times. However
if it's a hanging test that goes away on retry it's good to go.

--
Alex Benn=C3=A9e
