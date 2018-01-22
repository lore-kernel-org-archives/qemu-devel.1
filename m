Received: from eggs.gnu.org ([2001:4830:134:3::10]:54046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edcMW-00010A-Hq
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 08:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edcMV-000680-M7
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 08:42:12 -0500
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:35215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edcMV-00067s-H1
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 08:42:11 -0500
Received: by mail-oi0-x236.google.com with SMTP id b11so5924726oif.2
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 05:42:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e2a7e3fa-a660-a1e1-9e34-4585a10ae6ad@redhat.com>
References: <1511276888-17834-1-git-send-email-peter.maydell@linaro.org>
	<e2a7e3fa-a660-a1e1-9e34-4585a10ae6ad@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 13:41:50 +0000
Message-ID: <CAFEAcA9Q5XF_wbiyHBYRXoZSo2sNrCdE6F8ce2eWF=TAkiK4eQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] memory-internal.h: Remove obsolete claim
 that header is obsolete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 21 November 2017 at 15:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 21/11/2017 16:08, Peter Maydell wrote:
>> The memory-internal.h header claims that it is for "obsolete
>> exec.c functions" which "will be removed soon". This statement
>> was added in 2011, six years ago, but the header is still here.
>> (Admittedly none of the prototypes added in commit 67d95c153bef55f6
>> are still in the header.)
>>
>> It's convenient to have a place to put prototypes for functions
>> which are used internally to the various .c files of the memory
>> system or by the accel/tcg code, which is inevitably fairly
>> closely coupled. So keep the header but update the comments to
>> reflect what we're actually using it for.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Ping? Paolo, I was expecting this to go in via your tree --
should it go somewhere else instead?

thanks
-- PMM
