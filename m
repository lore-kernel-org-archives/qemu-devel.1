Received: from eggs.gnu.org ([2001:4830:134:3::10]:56110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmisx-0001QN-UV
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:57:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmisx-0005Bi-4L
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:57:03 -0400
MIME-Version: 1.0
In-Reply-To: <20170829183303-mutt-send-email-mst@kernel.org>
References: <20170829152751.3174-1-marcandre.lureau@redhat.com>
	<20170829183303-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Aug 2017 17:57:01 +0200
Message-ID: <CAJ+F1CKm=2FmxUdiz44vtuUz3B2LQ6WUVgdjdBqy5qTQxziycw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] vhost-user-bridge reconnect
 regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Victor Kaplansky <victork@redhat.com>, QEMU <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

Hi

On Tue, Aug 29, 2017 at 5:34 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Tue, Aug 29, 2017 at 05:27:49PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Hi,
>>
>> libvhost-user doesn't support resuming with the same trick vubr had
>> since commit 523b018dde3b7650fe5401d0499b30cf2f117515. The following
>> two patches fix that regression.
>
>
> Thanks! Do we need this in 2.10? If not pls ping after 2.10 is out.

I think it's not necessary since the regression appeared in 2.9
already, and it's a manual test.

I'll ping after 2.10

>
>> Thanks
>>
>> Marc-Andr=C3=A9 Lureau (2):
>>   libvhost-user: support resuming vq->last_avail_idx based on used_idx
>>   vhost-user-bridge: fix resume regression (since 2.9)
>>
>>  contrib/libvhost-user/libvhost-user.h |  7 +++++++
>>  contrib/libvhost-user/libvhost-user.c | 13 +++++++++++++
>>  tests/vhost-user-bridge.c             |  7 +++++++
>>  3 files changed, 27 insertions(+)
>>
>> --
>> 2.14.1.146.gd35faa819
>



--=20
Marc-Andr=C3=A9 Lureau
