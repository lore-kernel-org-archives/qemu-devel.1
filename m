Received: from eggs.gnu.org ([2001:4830:134:3::10]:43805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCmOf-0006IY-2X
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCmOY-0003Y6-Tn
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gCmOV-0002zx-Bm
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 10:01:52 -0400
References: <cover.1539778764.git.artem.k.pisarenko@gmail.com>
	<cf52eb15927d5517f9d525f6541b366a5b898af3.1539778764.git.artem.k.pisarenko@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d7c6680b-558b-a2a7-fff1-d0bef7338cb3@redhat.com>
Date: Wed, 17 Oct 2018 09:01:45 -0500
MIME-Version: 1.0
In-Reply-To: <cf52eb15927d5517f9d525f6541b366a5b898af3.1539778764.git.artem.k.pisarenko@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] vl,
 qapi: offset value calculation in RTC_CHANGE event reverted to
 match behavior before #1797033 bugfix and documented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artem Pisarenko <artem.k.pisarenko@gmail.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 10/17/18 7:23 AM, Artem Pisarenko wrote:
> Return value of qemu_timedate_diff(), used for calculation offset in QAPI 'RTC_CHANGE' event restored to keep compatibility, although it isn't documented that difference is relative to host clock advancement.
> Added important note to 'RTC_CHANGE' event description to highlight established implementation specifics.
> 

Hmm, I just replied to v1 before seeing that you sent v2; my comments 
about long lines and a typo still apply.

> Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
> ---
>   qapi/misc.json |  3 ++-
>   vl.c           | 10 +++++-----
>   2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/qapi/misc.json b/qapi/misc.json
> index ada9af5..ed866f2 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -3070,7 +3070,8 @@
>   # Emitted when the guest changes the RTC time.
>   #
>   # @offset: offset between base RTC clock (as specified by -rtc base), and
> -#          new RTC clock value
> +#          new RTC clock value. Note that value will be different depending
> +#          on clock choosen to drive RTC (specified by -rtc clock).
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
