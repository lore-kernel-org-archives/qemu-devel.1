Received: from eggs.gnu.org ([2001:4830:134:3::10]:51471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG9CR-0002BI-7T
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:27:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fG9CN-0001qp-VW
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:27:03 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49679)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fG9CN-0001qZ-LR
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:26:59 -0400
References: <20180508194026.1281-1-laurent@vivier.eu>
	<20180508194026.1281-6-laurent@vivier.eu>
	<CAMo8BfJv_Sg8EhjrUcS-wjbwwiLgv2kY4-GaxtXTygs19hUMqQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1e171cf8-e708-d2cf-5ec4-5b7b6e3b1910@vivier.eu>
Date: Tue, 8 May 2018 22:26:44 +0200
MIME-Version: 1.0
In-Reply-To: <CAMo8BfJv_Sg8EhjrUcS-wjbwwiLgv2kY4-GaxtXTygs19hUMqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/5] linux-user: add sparc/sparc64 specific
 errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

Le 08/05/2018 à 22:22, Max Filippov a écrit :
> On Tue, May 8, 2018 at 12:40 PM, Laurent Vivier <laurent@vivier.eu> wrote:
>> Copied from linux/arch/sparc/include/uapi/asm/errno.h
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  linux-user/sparc/target_syscall.h   | 203 ++++++++++++++++++++++++++++++++++++
>>  linux-user/sparc64/target_syscall.h | 203 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 406 insertions(+)
> 
> The changes are coming from single file, why duplicating them?
> Could they go into e.g. linux-user/sparc/target_errno.h, and get
> #included by both linux-user/sparc/target_syscall.h and
> linux-user/sparc64/target_syscall.h?
> 

Yes, I was also thinking at something like that.

I did like that because in QEMU sparc and sparc64 use two different
directories whereas in linux they use the same one. Duplication seems to
be the rule...

I will do as you suggest in v2 of the series.

Thanks,
Laurent
