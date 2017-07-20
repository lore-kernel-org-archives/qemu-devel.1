Received: from eggs.gnu.org ([2001:4830:134:3::10]:47388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYIbh-0007r9-Ho
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYIbg-0003U3-7u
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:03:37 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:37799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYIbg-0003Te-12
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:03:36 -0400
Received: by mail-wr0-x232.google.com with SMTP id 33so18829391wrz.4
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 14:03:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d4b6f6a0-3479-795a-97b2-68c98a6b0c24@twiddle.net>
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
	<d4b6f6a0-3479-795a-97b2-68c98a6b0c24@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 22:03:14 +0100
Message-ID: <CAFEAcA8tkW2bk_O3iDO-wWpY9EUbUNkUL93OShipsvckj-jkoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10] Use qemu_tolower() and
 qemu_toupper(), not tolower() and toupper()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kamil Rytarowski <kamil@netbsd.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 20 July 2017 at 19:26, Richard Henderson <rth@twiddle.net> wrote:
> On 07/20/2017 06:31 AM, Peter Maydell wrote:
>>
>> gdbstub.c:914:13: warning: array subscript has type 'char'
>>
>> This reflects the fact that toupper() and tolower() give
>> undefined behaviour if they are passed a value that isn't
>> a valid 'unsigned char' or EOF.
>
>
> Not saying we shouldn't use qemu_tolower etc, but this statement is not true
> at all.  Officially, the argument to toupper and tolower is type int.

(I was going to quote POSIX here but I see Eric has done so already.)

> This sounds like a bug in NetBSD -- though it may not even be that, as they
> may have done something clever and put the symbol in the middle of the data.
> A trick that worked before compiler warnings got smarter.

https://ftp.netbsd.org/pub/NetBSD/NetBSD-current/src/sys/sys/ctype_inline.h
The implementation is
  #define toupper(c) ((int)((_toupper_tab_ + 1)[(c)]))

(where I assume _toupper_tab_ is the obvious array.)

thanks
-- PMM
