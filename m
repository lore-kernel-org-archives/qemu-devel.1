Received: from eggs.gnu.org ([2001:4830:134:3::10]:41518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPWL0-0005Sk-1V
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPWKw-00024z-TH
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:30:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gPWKu-00020G-6A
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:30:48 -0500
References: <1542799319-2595-1-git-send-email-liq3ea@gmail.com>
	<CAJ+F1C+FQ8WWkrw3Qup-DzyryZZ3UqHdomjzY=-kfCiHcvLWEw@mail.gmail.com>
	<20181121115718.GN26577@redhat.com>
	<20181121072237-mutt-send-email-mst@kernel.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <60500f8b-47e8-c530-076a-d7f14d0f0ee5@redhat.com>
Date: Wed, 21 Nov 2018 11:30:41 -0600
MIME-Version: 1.0
In-Reply-To: <20181121072237-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: tap: use qemu_set_nonblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>

On 11/21/18 6:23 AM, Michael S. Tsirkin wrote:

>>
>> I agree it is good to preserve fcntl flags though, so this patch
>> looks desirable.
>>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> Sure
>=20
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> but really not for this release I guess as we are in freeze.

We're in freeze, so the criteria is: Does this fix a bug that we would=20
otherwise not want in 3.1.  If the code is pre-existing (that is, if 3.0=20
was released with the same problem), or then delaying the patch to 4.0=20
is an easier call to make.  If the problem is new to 3.1, then fixing it=20
for -rc3 is still reasonable with maintainer discretion (although once=20
-rc3 lands, we want as little as possible to go into -rc4, even if our=20
track record says we will be unable to avoid -rc4 altogether).

I think that losing flags is likely enough to be a noticeable bug worth=20
fixing for 3.1, but I did not research when the problem was introduced,=20
so I don't have a strong preference for 3.1 vs. 4.0.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
