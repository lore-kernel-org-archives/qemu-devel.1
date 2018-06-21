Received: from eggs.gnu.org ([2001:4830:134:3::10]:56678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVz0V-0005kR-5U
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVz0U-0003d1-D5
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:48:11 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:43066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fVz0U-0003c2-6A
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:48:10 -0400
Received: by mail-wr0-x234.google.com with SMTP id d2-v6so3050578wrm.10
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 05:48:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621123320.GA19274@debian>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-5-marcandre.lureau@redhat.com>
	<20180621123320.GA19274@debian>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Jun 2018 14:48:08 +0200
Message-ID: <CAJ+F1CKPbdXx5sAA1ershQ_YeSOupocjfZsFWqha8-7ObkvUTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 04/26] vhost-user: simplify
 vhost_user_init/vhost_user_cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Jun 21, 2018 at 2:33 PM, Tiwei Bie <tiwei.bie@intel.com> wrote:
> On Mon, Jun 18, 2018 at 06:17:07PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> [...]
>> diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
>> index 049089b5e2..323dfcc46a 100644
>> --- a/hw/virtio/vhost-stub.c
>> +++ b/hw/virtio/vhost-stub.c
>> @@ -7,7 +7,7 @@ bool vhost_has_free_slot(void)
>>      return true;
>>  }
>>
>> -VhostUserState *vhost_user_init(void)
>> +bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **er=
rp)
>>  {
>>      return NULL;
>
> It would be better to return false.
>

Good catch, fixed.

Except that, would you give a reviewed-by?

> Best regards,
> Tiwei Bie
>
>>  }
> [...]
>



--=20
Marc-Andr=C3=A9 Lureau
