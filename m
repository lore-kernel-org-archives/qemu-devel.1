Received: from eggs.gnu.org ([2001:4830:134:3::10]:40655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRg9D-0003YO-4W
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRg9B-0008Id-Ec
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:14:35 -0500
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:36610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cRg9B-0008I0-Ab
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:14:33 -0500
Received: by mail-ua0-x229.google.com with SMTP id 96so14795938uaq.3
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 06:14:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_53j-DGqW7WMzWaofUK9zFmeORUSFNAdHUPFKTZyqZ+Q@mail.gmail.com>
References: <1449101933-24928-1-git-send-email-mdavidsaver@gmail.com>
	<1449101933-24928-2-git-send-email-mdavidsaver@gmail.com>
	<CAFEAcA_53j-DGqW7WMzWaofUK9zFmeORUSFNAdHUPFKTZyqZ+Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jan 2017 14:14:12 +0000
Message-ID: <CAFEAcA9u2MPh7tKoaMwfeMf04VOWnR-ScJhBvnpBNO-7-kkywg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 01/26] armv7m: MRS/MSR handle
 unprivileged access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On 17 December 2015 at 13:10, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 3 December 2015 at 00:18, Michael Davidsaver <mdavidsaver@gmail.com> wrote:
>> The MRS and MSR instruction handling isn't checking
>> the current permission level.
>>
>> Prevent privlaged from changing writing EPSR fields.
>> Access to unknown/undefined special registers not
>> fatal (read 0, write ignored) w/ guest error message.
>
> This patch and all the others in this series seem to be
> missing your Signed-off-by: line.

Michael has confirmed to me that this was just an oversight.
Cleanup of the NVIC has finally reached the top of my todo
list, so I'm planning to take this patchset and finish
the process of fixing it up to go into master.

thanks
-- PMM
