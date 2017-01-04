Received: from eggs.gnu.org ([2001:4830:134:3::10]:39572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cOpqn-00007v-7p
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cOpqi-0002bB-Ce
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:59:49 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:52833)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1cOpqi-0002ZQ-4Q
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 12:59:44 -0500
References: <87inqavlzj.fsf@mail.parknet.co.jp>
	<feca54b3-9c38-4ce7-4edc-b1f9f88fb7a1@reactos.org>
	<87fuletg61.fsf@mail.parknet.co.jp>
	<f8044f23-52ef-89f8-5ca7-b27de2989cc7@reactos.org>
	<8737h9xidn.fsf@mail.parknet.co.jp>
	<87mvfhw3i0.fsf_-_@mail.parknet.co.jp>
	<1483519820.5670.45.camel@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <46bcf40d-7c47-733b-44e3-b5a38527524e@reactos.org>
Date: Wed, 4 Jan 2017 18:59:31 +0100
MIME-Version: 1.0
In-Reply-To: <1483519820.5670.45.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] ps2: Fix lost scancodes by recent
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

Le 04/01/2017 =C3=A0 09:50, Gerd Hoffmann a =C3=A9crit :
> On Mi, 2016-12-28 at 04:55 +0900, OGAWA Hirofumi wrote:
>> With "ps2: use QEMU qcodes instead of scancodes", key handling was
>> changed to qcode base. But all scancodes are not converted to new one.
>>
>> This adds some missing qcodes/scancodes what I found in using.
>
> Added to ui queue.

Hi Gerd,

Your pull request (patch 01/11) contains v2 of this patch (which is incom=
plete).
I've only reviewed v3, which is complete.

Regards,

Herv=C3=A9
