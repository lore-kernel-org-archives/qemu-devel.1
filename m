Received: from eggs.gnu.org ([2001:4830:134:3::10]:42344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMDTd-0005gh-AF
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMDTa-0008Hu-L5
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:46:09 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:55781)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gMDTa-0008Gz-9i
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:46:06 -0500
References: <20181019161715.12122-1-peter.maydell@linaro.org>
	<7d7f51e2-49fa-7fc9-4d6d-153fa9cff5c5@vivier.eu>
	<CAFEAcA84UV6ahvwG8pVnoUkt75Y0bHbHFCHhvtDZWnK=t09PEQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b2b2f4ba-3b9d-b36d-f2f9-af8cd830122a@vivier.eu>
Date: Mon, 12 Nov 2018 15:45:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA84UV6ahvwG8pVnoUkt75Y0bHbHFCHhvtDZWnK=t09PEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Remove dead error-checking code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Riku Voipio <riku.voipio@iki.fi>

On 12/11/2018 15:38, Peter Maydell wrote:
> On 19 October 2018 at 17:26, Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 19/10/2018 à 18:17, Peter Maydell a écrit :
>>> Remove some dead code spotted by Coverity (CID 1009855,
>>> 1390854, 1390847). The underlying cause in all these cases
>>> is the same: QEMU's put_user operations can't result in
>>> errors, but the kernel's equivalent does. So when code
>>> was copied from the kernel signal-frame-setup/teardown
>>> code, checks on error flags that were needed in the kernel
>>> became dead code for us.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>  linux-user/m68k/signal.c  | 3 ---
>>>  linux-user/sh4/signal.c   | 4 ----
>>>  linux-user/sparc/signal.c | 2 --
>>>  3 files changed, 9 deletions(-)
>>>
>>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> 
> Ping? Looks like you reviewed this but it hasn't made it into
> a pullreq.

Sorry... do you want it in 3.1?

Thanks,
Laurent
