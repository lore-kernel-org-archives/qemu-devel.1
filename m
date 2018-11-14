Received: from eggs.gnu.org ([2001:4830:134:3::10]:38211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMtAV-0001xy-00
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMtAU-0002bx-35
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:17:11 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMtAT-0002bN-VF
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:17:10 -0500
Received: by mail-oi1-x242.google.com with SMTP id c206so7685383oib.0
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 03:17:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <74cca5d1-d2b4-6b44-32fe-332136b8b171@redhat.com>
References: <20181101021226.6353-1-zhangckid@gmail.com>
	<20181114104720.GB3955@xz-x1>
	<74cca5d1-d2b4-6b44-32fe-332136b8b171@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Nov 2018 11:16:48 +0000
Message-ID: <CAFEAcA8SeZfsihEeD0Rvoxtf-9iKjR_dtrXQLy=6MVzM0ZAD0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V2] migration/colo.c: Fix compilation issue
 when disable replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Zhang Chen <zhangckid@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 14 November 2018 at 11:06, Thomas Huth <thuth@redhat.com> wrote:
> On 2018-11-14 11:47, Peter Xu wrote:
>> On Thu, Nov 01, 2018 at 10:12:26AM +0800, Zhang Chen wrote:
>>> This compilation issue will occur when user use --disable-replication
>>> to config Qemu.
>>>
>>> Reported-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>>
>> Hi,
>>
>> How's the status of this patch?  Are we gonna merge it for 3.1?
>>
>> I just posted a similar one without knowing this (until Dave pointed
>> it out).  IMHO it can be a good candidate for 3.1.
>
> Maybe Peter Maydell could apply this directly to the repo as a built fix?

I'd rather it just went through the migration tree, really...
it isn't actually breaking any of our travis jobs or other CI.

thanks
-- PMM
