Received: from eggs.gnu.org ([2001:4830:134:3::10]:60783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUtFC-0003xF-4A
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:59:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUtF7-0001S4-64
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:59:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUtF6-0001QP-W7
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:59:01 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181205203737.9011-1-marcandre.lureau@redhat.com>
	<20181205203737.9011-5-marcandre.lureau@redhat.com>
	<87bm5zkx0o.fsf@dusky.pond.sub.org>
	<CAMxuvazPAjrEt2nyEVSwsVhap-dEGGXSa-N1GcdgK-UuhMfN+Q@mail.gmail.com>
	<87tvjrhvb4.fsf@dusky.pond.sub.org>
	<CAMxuvawvii_FQCaZLAhrOmKZsVRZCbQw1Q67=wuajH1idszt9w@mail.gmail.com>
	<87h8frhu5s.fsf@dusky.pond.sub.org>
	<CAMxuvayaPzLrPrmv=-EoTfws3_5rj5HYjqX9hd6mFA5xfhDbKg@mail.gmail.com>
Date: Thu, 06 Dec 2018 13:58:51 +0100
In-Reply-To: <CAMxuvayaPzLrPrmv=-EoTfws3_5rj5HYjqX9hd6mFA5xfhDbKg@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 6 Dec 2018
	13:55:28 +0400")
Message-ID: <87zhtig6b8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 4/7] monitor: check if chardev
 can switch gcontext for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: lizhijian@cn.fujitsu.com, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, zhangckid@gmail.com, "Bonzini, Paolo" <pbonzini@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
> On Thu, Dec 6, 2018 at 1:38 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
[...]
>> This makes me think we should drop the CHARDEV_IS_MUX() check from
>> monitor_init(), and update the commit message to say
>>
>>     We already forbid MUX because not all frontends are ready to run out=
side
>>     main loop.  Replace that by a context-switching feature check.
>>
>> What do you think?
>
> ack, can you do that on commit?
>
> thanks

Sure.
