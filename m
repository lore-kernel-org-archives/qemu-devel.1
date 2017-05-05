Received: from eggs.gnu.org ([2001:4830:134:3::10]:39264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6XZf-0003qI-Rz
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6XZZ-0000Jt-QN
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:22:47 -0400
References: <20170503104441.1349-1-pbonzini@redhat.com>
	<3a1419bd-710a-61f5-bfee-0eb5895a022c@msgid.tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <578c614d-741f-bac5-b42a-86e61a6658e4@redhat.com>
Date: Fri, 5 May 2017 09:22:31 +0200
MIME-Version: 1.0
In-Reply-To: <3a1419bd-710a-61f5-bfee-0eb5895a022c@msgid.tls.msk.ru>
Content-Type: text/plain; charset=windows-1251
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] jazz_led: fix bad snprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, leon.alrae@imgtec.com



On 05/05/2017 08:24, Michael Tokarev wrote:
> 03.05.2017 13:44, Paolo Bonzini wrote:
>> Detected by GCC 7's -Wformat-truncation.  snprintf writes at most
>> 2 bytes here including the terminating NUL, so the result is
>> truncated.  In addition, the newline at the end is pointless.
>> Fix the buffer size and the format string.
> 
> Polo, that's quite a bit too bureaucratic,
> but where's your s-o-b for this patch? :)

Oops, here:

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

> 
> Thanks,
> 
> /mjt
> 
