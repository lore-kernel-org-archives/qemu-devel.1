Received: from eggs.gnu.org ([2001:4830:134:3::10]:45950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cf9ua-00070b-Mn
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 13:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cf9uZ-0000xZ-PT
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 13:39:12 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cf9uZ-0000xE-JG
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 13:39:11 -0500
Received: by mail-wm0-x22d.google.com with SMTP id v186so43233445wmd.0
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 10:39:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1e2962d7-1b50-9543-3e1d-9c388d4167c3@gmail.com>
References: <1486065742-28639-1-git-send-email-peter.maydell@linaro.org>
	<1486065742-28639-4-git-send-email-peter.maydell@linaro.org>
	<87mvdnvcxx.fsf@linaro.org>
	<CAFEAcA-PFJp_9=NOCFqiQp=xF6Y-TnmE3bfU3zDa6xH7nK2Zfg@mail.gmail.com>
	<CAFEAcA8X1qvweDHBWQjZwH68xWdn4K+Wfqv0yRhjM5QCxd=VBA@mail.gmail.com>
	<1e2962d7-1b50-9543-3e1d-9c388d4167c3@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Feb 2017 18:38:49 +0000
Message-ID: <CAFEAcA-9w-bKJY=gb9Bo9c45vLParh8zVwit3t4GPHqTJZxnJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 3/9] armv7m: Rewrite NVIC to not use any
 GIC code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Liviu Ionescu <ilg@livius.net>

On 18 February 2017 at 17:45, Michael Davidsaver <mdavidsaver@gmail.com> wrote:
> On 02/16/2017 09:11 AM, Peter Maydell wrote:
>> I haven't actually checked real hardware behaviour, but I think
>> we can fairly safely implement this as not checking the IPSR
>> exception field. (We might as well go with the "reads 1 in
>> handler mode" choice of UNKNOWN that the M3 documents, though.)
>
> For what it's worth, I dug up my TI TM4C1294 eval board and re-ran
> test10.c [1] which is designed to probe this behavior by nesting
> exceptions PendSV within SVC.  RETTOBASE is 0x800 in ICSR.

That's a Cortex-M4. From the test it looks like it
has a different choice of UNKNOWN behaviour for
the value in Handler mode, so real code in the field
isn't going to be relying on that and it doesn't
matter what we choose.

I don't think the test looks at the "what happens if the
exception in the IPSR exception field isn't actually
active" case, right?

thanks
-- PMM
