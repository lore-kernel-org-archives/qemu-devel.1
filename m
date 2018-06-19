Received: from eggs.gnu.org ([2001:4830:134:3::10]:60291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVCVj-0007fs-M4
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:01:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVCVa-0005uh-GX
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:01:11 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:41216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fVCVa-0005uO-9U
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:01:02 -0400
Received: by mail-wr0-x242.google.com with SMTP id h10-v6so19668856wrq.8
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 02:01:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619062323.t6hbpvmcsrcgwmmm@sirius.home.kraxel.org>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-11-marcandre.lureau@redhat.com>
	<20180619062323.t6hbpvmcsrcgwmmm@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Jun 2018 11:01:00 +0200
Message-ID: <CAJ+F1CLTege16ZM_-Ar6V92uGHsouBxNeOGFx6JPR7Qwvcbp_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 10/26] vhost-user: split
 vhost_user_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Jun 19, 2018 at 8:23 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> @@ -237,7 +251,7 @@ static int vhost_user_read(struct vhost_dev *dev, Vh=
ostUserMsg *msg)
>>          error_report("Failed to read msg header."
>>                  " Size %d exceeds the maximum %zu.", msg->hdr.size,
>>                  VHOST_USER_PAYLOAD_SIZE);
>> -        goto fail;
>> +        return -1;
>
> Hmm?  Looks like a pointless indirection ...

Isn't it removed by the patch? :)

>
>>      }
>>
>>      if (msg->hdr.size) {
>> @@ -247,14 +261,11 @@ static int vhost_user_read(struct vhost_dev *dev, =
VhostUserMsg *msg)
>>          if (r !=3D size) {
>>              error_report("Failed to read msg payload."
>>                           " Read %d instead of %d.", r, msg->hdr.size);
>> -            goto fail;
>> +            return -1;
>>          }
>>      }
>>
>>      return 0;
>> -
>> -fail:
>> -    return -1;
>
> ... if there is nothing to cleanup here.
>
> cheers,
>   Gerd
>
>



--=20
Marc-Andr=C3=A9 Lureau
