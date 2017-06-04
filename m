Received: from eggs.gnu.org ([2001:4830:134:3::10]:48986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZGs-0004oX-7i
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZGo-0004B3-AU
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:24:58 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZGo-00049m-5I
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:24:54 -0400
Received: by mail-pg0-x242.google.com with SMTP id v18so3971045pgb.3
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:24:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529121228.2789-1-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <44928323-0869-a258-a100-ab97c1beffc2@twiddle.net>
Date: Sun, 4 Jun 2017 10:24:47 -0700
MIME-Version: 1.0
In-Reply-To: <20170529121228.2789-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] target/s390x: addressing exceptions are
 suppressing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com

On 05/29/2017 05:12 AM, David Hildenbrand wrote:
> We have to make the address in the old PSW point at the next
> instruction, as addressing exceptions are suppressing and not
> nullifying.
> 
> I assume that there are a lot of other broken cases (as most instructions
> we care about are suppressing) - all trigger_pgm_exception() specifying
> and explicit number or ILEN_LATER look suspicious, however this is another
> story that might require bigger changes (and I have to understand when
> the address might already have been incremented first).
> 
> This is needed to make an upcoming kvm-unit-test work.
> 
> Signed-off-by: David Hildenbrand<david@redhat.com>
> ---
>   target/s390x/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.


r~
