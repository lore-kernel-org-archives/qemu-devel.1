Received: from eggs.gnu.org ([2001:4830:134:3::10]:34449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cZNiC-0007vc-WD
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cZNiA-0002k9-9R
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:10:32 -0500
References: <20170202195601.11286-1-sw@weilnetz.de>
	<bdfbc0e6-e630-a1ac-5132-24b6a2dd6122@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <a5309467-337b-2827-489d-2abbce8356e4@weilnetz.de>
Date: Thu, 2 Feb 2017 21:10:26 +0100
MIME-Version: 1.0
In-Reply-To: <bdfbc0e6-e630-a1ac-5132-24b6a2dd6122@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tci: Remove invalid assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

Am 02.02.2017 um 21:00 schrieb Eric Blake:
> On 02/02/2017 01:56 PM, Stefan Weil wrote:
>> tb_jmp_insn_offset and tb_jmp_reset_offset are pointers
>> and cannot be used with ARRAY_SIZE.
>>
>> Signed-off-by: Stefan Weil <sw@weilnetz.de>
>> ---
>>  tcg/tci/tcg-target.inc.c | 2 --
>>  1 file changed, 2 deletions(-)
>
> mst posted an alternative patch:
> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg00551.html


Yes, I noticed that, too. It's not obvious that this new
assertion will be correct, and none of the other targets
has that kind of assertion. Only two targets use an
assertion which detects NULL pointers, but NULL pointers
will result in an abort anyway.

Do you think that there are reasons why TCI should use
the assertion suggested by Michael?

Stefan
