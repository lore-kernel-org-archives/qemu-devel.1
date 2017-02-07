Received: from eggs.gnu.org ([2001:4830:134:3::10]:47308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb9iy-0007yS-Bq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb9ix-0000TN-54
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:38:40 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:38064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb9iw-0000SZ-U4
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:38:39 -0500
Received: by mail-wm0-x229.google.com with SMTP id r141so161427593wmg.1
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 09:38:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ihju_3vZmPtbhxkSoc+dj+cghwXQnQFAAi2XEsw+ixQ@mail.gmail.com>
References: <1484247815-15279-1-git-send-email-peter.maydell@linaro.org>
	<1484247815-15279-2-git-send-email-peter.maydell@linaro.org>
	<87wpdg8uec.fsf@linaro.org>
	<CAFEAcA_ihju_3vZmPtbhxkSoc+dj+cghwXQnQFAAi2XEsw+ixQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 17:38:16 +0000
Message-ID: <CAFEAcA-OJj2sqh3aV5frvH3zKfZWGNbbc4t0Ywp5f8wZ12FREA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] stellaris: Document memory map and
 which SoC devices are unimplemented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 27 January 2017 at 14:17, Peter Maydell <peter.maydell@linaro.org> wrote=
:
> On 27 January 2017 at 14:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> Can we at least have the title of the document these came from for
>> future reference?
>
> Good idea; it's
> Stellaris LM3S6965 Microcontroller Data Sheet (rev H)

Added these lines to the comment:

+    /* Memory map of SoC devices, from
+     * Stellaris LM3S6965 Microcontroller Data Sheet (rev I)
+     * http://www.ti.com/lit/ds/symlink/lm3s6965.pdf
+     *

I've put the series into target-arm.next, since that seems
trivial enough not to merit a respin.

thanks
-- PMM
