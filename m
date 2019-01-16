Received: from eggs.gnu.org ([209.51.188.92]:56616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjdhN-0006QG-4n
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjdhL-0000pU-Da
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:25:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjdhJ-0000k5-8S
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:25:07 -0500
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-7-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7aa007ec-126d-2a97-aa45-91468f7f8ad4@redhat.com>
Date: Wed, 16 Jan 2019 06:24:49 +0100
MIME-Version: 1.0
In-Reply-To: <20190115145256.9593-7-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/12] chardev: remove unused 'sioc'
 variable & cleanup paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 2019-01-15 15:52, Daniel P. Berrang=C3=A9 wrote:
> The 'sioc' variable in qmp_chardev_open_socket was unused since
>=20
>   commit 3e7d4d20d3a528b1ed10b1dc3d83119bfb0c5f24
>   Author: Peter Xu <peterx@redhat.com>
>   Date:   Tue Mar 6 13:33:17 2018 +0800
>=20
>     chardev: use chardev's gcontext for async connect
[...]
> -error:
> -    if (sioc) {
> -        object_unref(OBJECT(sioc));
> -    }

So who is doing the object_unref() now in case of errors? That commit
did not take care of it ... so it sounds like we could be leaving
references behind in case of errors here?

 Thomas
