Received: from eggs.gnu.org ([2001:4830:134:3::10]:46106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYG9z-0002W3-HG
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:26:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYG9y-0002b6-RB
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 14:26:51 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d4b6f6a0-3479-795a-97b2-68c98a6b0c24@twiddle.net>
Date: Thu, 20 Jul 2017 08:26:29 -1000
MIME-Version: 1.0
In-Reply-To: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org

On 07/20/2017 06:31 AM, Peter Maydell wrote:
> gdbstub.c:914:13: warning: array subscript has type 'char'
> 
> This reflects the fact that toupper() and tolower() give
> undefined behaviour if they are passed a value that isn't
> a valid 'unsigned char' or EOF.

Not saying we shouldn't use qemu_tolower etc, but this statement is not true at 
all.  Officially, the argument to toupper and tolower is type int.

This sounds like a bug in NetBSD -- though it may not even be that, as they may 
have done something clever and put the symbol in the middle of the data.  A 
trick that worked before compiler warnings got smarter.

Anyway, should we poison the iso name so this doesn't creep in again?

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
