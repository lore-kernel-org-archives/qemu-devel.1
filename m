Received: from eggs.gnu.org ([2001:4830:134:3::10]:57325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH7XS-0004C4-7t
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH7XR-0003Ef-FW
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:25:02 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH7XR-0003DE-8F
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:25:01 -0400
Received: by mail-ot1-x342.google.com with SMTP id q5so2040236otl.13
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 06:25:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7fc49925-36ff-bd9a-0cd7-e5f8d4bb3672@roeck-us.net>
References: <1540548409-22560-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8EubWya8ey9VxhaCw4m2U=KA+i2C-R9P-p+P6oEBBLew@mail.gmail.com>
	<7fc49925-36ff-bd9a-0cd7-e5f8d4bb3672@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 13:24:37 +0000
Message-ID: <CAFEAcA-UF+SyXvcU+NGZsbqBF2qg+s_x4HPU7yvf7B2G-=HPOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] Deprecate the "collie" machine and
 Strongarm devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 27 October 2018 at 12:04, Guenter Roeck <linux@roeck-us.net> wrote:
> On 10/26/18 3:12 AM, Peter Maydell wrote:
>> Hi Guenter; there's a proposal here to deprecate (and eventually
>> remove) the 'collie' board (strongarm) from QEMU. Is that one of
>> the ones you're currently using in your automated testing of Linux
>> kernels on QEMU?
>>
>
> Yes. I can run the test with older versions of qemu, so it is ok for me
> if it is removed (as long as that removal is not backported).

Mmm, but if we have an active user who's testing them then they
probably shouldn't be in the frontline of boards to remove.
Which other boards do you test with mainline QEMU?

thanks
-- PMM
