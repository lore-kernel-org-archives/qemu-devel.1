Received: from eggs.gnu.org ([2001:4830:134:3::10]:58580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKZLb-0001ml-F1
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 18:34:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKZLY-0002V4-BA
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 18:33:59 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:39043)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hirofumi@parknet.co.jp>) id 1cKZLY-0002Uu-28
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 18:33:56 -0500
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <87inqavlzj.fsf@mail.parknet.co.jp>
	<8eb87c0e-ba00-e748-8cec-fa089403e13c@redhat.com>
Date: Sat, 24 Dec 2016 08:33:51 +0900
In-Reply-To: <8eb87c0e-ba00-e748-8cec-fa089403e13c@redhat.com> (Eric Blake's
	message of "Fri, 23 Dec 2016 15:58:07 -0600")
Message-ID: <8737heb4ps.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] ps2: Fix lost scancodes by recent changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 12/23/2016 07:00 AM, OGAWA Hirofumi wrote:
>> 
>> With "ps2: use QEMU qcodes instead of scancodes", key handling was
>> changed to qcode base. But all scancodes are not converted to new one.
>> 
>> This adds some missing qcodes what I found in using.
>> 
>> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>> ---
>> 
>
>> +++ qemu-hirofumi/qapi-schema.json	2016-12-23 21:14:59.840729469 +0900
>> @@ -3642,7 +3642,8 @@
>>              'kp_9', 'less', 'f11', 'f12', 'print', 'home', 'pgup', 'pgdn', 'end',
>>              'left', 'up', 'down', 'right', 'insert', 'delete', 'stop', 'again',
>>              'props', 'undo', 'front', 'copy', 'open', 'paste', 'find', 'cut',
>> -            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause', 'ro',
>> +            'lf', 'help', 'meta_l', 'meta_r', 'compose', 'pause',
>> +            'ro', 'hiragana', 'henkan', 'yen',
>>              'kp_comma', 'kp_equals', 'power' ] }
>
> Missing documentation (including a 'since 2.9' designation) for the new
> enum members.

Thanks for pointing out.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
