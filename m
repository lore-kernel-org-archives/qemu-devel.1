Received: from eggs.gnu.org ([2001:4830:134:3::10]:38929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVLkN-0008Iv-60
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVLkI-0006RS-9E
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:48:23 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVLkI-0006Qt-0I
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 13:48:18 -0400
Received: by mail-wm0-f41.google.com with SMTP id t70so309225wmt.0
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 10:48:17 -0700 (PDT)
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-20-git-send-email-cota@braap.org>
	<8737a18wzf.fsf@linaro.org>
	<9d22af0e-e87f-4f6c-2369-5affe7e1d468@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <9d22af0e-e87f-4f6c-2369-5affe7e1d468@twiddle.net>
Date: Wed, 12 Jul 2017 18:47:14 +0100
Message-ID: <871spl8s4d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 19/22] tcg: introduce tcg_context_clone
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org


Richard Henderson <rth@twiddle.net> writes:

> On 07/12/2017 06:02 AM, Alex Bennée wrote:
>> Why a copy approach as opposed to a plain tcg_context_new() with the
>> appropriate init cleanup.
>
> We need the globals that were set up by the target/foo/translate.c
> code to be the same for each thread.  That's what makes it easier to
> copy the struct.

Ahh I see. Maybe expand the comment for the function a little then?


--
Alex Bennée
