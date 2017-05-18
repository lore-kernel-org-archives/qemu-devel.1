Received: from eggs.gnu.org ([2001:4830:134:3::10]:58498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dBPES-0003Qx-DH
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dBPER-0008J4-Kp
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:29:00 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dBPER-0008Iq-HE
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:28:59 -0400
Received: by mail-qt0-x242.google.com with SMTP id a46so6595104qte.0
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 10:28:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1495128400-23759-1-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ca84f48b-4d7f-f018-89a1-d4d9e88c073b@twiddle.net>
Date: Thu, 18 May 2017 10:28:55 -0700
MIME-Version: 1.0
In-Reply-To: <1495128400-23759-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] target/s390x: Add support for the TEST
 BLOCK instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>
Cc: David Hildenbrand <david@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 05/18/2017 10:26 AM, Thomas Huth wrote:
> TEST BLOCK was likely once used to execute basic memory
> tests, but nowadays it's just a (slow) way to clear a page.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   v4:
>   - Switched TCG_CALL_NO_RWG back to TCG_CALL_NO_WG as indicated by Richard
> 
>   v3:
>   - Use TCG_CALL_NO_RWG instead of TCG_CALL_NO_WG
>   - Use potential_page_fault() since the helper can generate an exception
> 
>   v2:
>   - Use DEF_HELPER_FLAGS_2 instead for DEF_HELPER_2 for returning CC value
>   - Convert real to absolute address
>   - Added a check for valid RAM page
>   - Added low-address protection check
> 
>   target/s390x/cpu.h         |  1 +
>   target/s390x/helper.h      |  1 +
>   target/s390x/insn-data.def |  2 ++
>   target/s390x/mem_helper.c  | 28 ++++++++++++++++++++++++++++
>   target/s390x/mmu_helper.c  |  2 +-
>   target/s390x/translate.c   | 11 +++++++++++
>   6 files changed, 44 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
