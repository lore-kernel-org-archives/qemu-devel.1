Received: from eggs.gnu.org ([2001:4830:134:3::10]:50159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dBNWc-0005hd-0N
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dBNWb-0001mJ-9g
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:39:38 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dBNWb-0001m4-4U
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:39:37 -0400
Received: by mail-qt0-x244.google.com with SMTP id r58so6192289qtb.2
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 08:39:36 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1495117161-22671-1-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <a5b2ed4e-31d0-dd05-18f6-339c1f9bf95a@twiddle.net>
Date: Thu, 18 May 2017 08:39:31 -0700
MIME-Version: 1.0
In-Reply-To: <1495117161-22671-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] target/s390x: Add support for the TEST
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

On 05/18/2017 07:19 AM, Thomas Huth wrote:
> TEST BLOCK was likely once used to execute basic memory
> tests, but nowadays it is just a (slow) way to clear a page.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v3:
>   - Use TCG_CALL_NO_RWG instead of TCG_CALL_NO_WG
>   - Use potential_page_fault() since the helper can generate an exception

You were right the first time, using TCG_CALL_NO_WG, since an exception path 
implies that all of the register values are read (by being live values when we 
restart at the exception handler).

As an aside, we really should convert target/s390 to properly use 
cpu_loop_exit_restore so that we can drop potential_page_fault().


r~
