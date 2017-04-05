Received: from eggs.gnu.org ([2001:4830:134:3::10]:52651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cvuFa-0006x1-9R
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 19:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1cvuFW-0000Km-BF
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 19:22:06 -0400
Received: from mail-he1eur01on0108.outbound.protection.outlook.com
	([104.47.0.108]:51944
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1cvuFV-0000KR-Ov
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 19:22:02 -0400
References: <1491405505-31620-1-git-send-email-den@openvz.org>
	<1491405505-31620-3-git-send-email-den@openvz.org>
	<9b9dc574-b6bb-e0ef-adf0-84d35bf4a883@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <61dfa919-93be-10a7-2597-6eb6d5b62d55@openvz.org>
Date: Wed, 5 Apr 2017 18:47:35 +0300
MIME-Version: 1.0
In-Reply-To: <9b9dc574-b6bb-e0ef-adf0-84d35bf4a883@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] block: assert no image modification
 under BDRV_O_INACTIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 04/05/2017 06:37 PM, Eric Blake wrote:
> On 04/05/2017 10:18 AM, Denis V. Lunev wrote:
>> As long as BDRV_O_INACTIVE is set, the image file is only opened so we=

>> have a file descriptor for it. We're definitely not supposed to modify=

>> the image, it's still owned by the migration source.
>>
>> This commit is an addition to 09e0c771 but the assert() is added to
>> bdrv_truncate().
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> ---
>>  block.c | 2 ++
>>  1 file changed, 2 insertions(+)
> I don't feel comfortable adding an assert this late in the 2.9 phase,
> but think it makes perfect sense as a 2.10 addition.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
no-no, this is for 2.10 for sure. No way for 2.9. I have stated that in
cover letter :(
Sorry for inconvenience.

Den
