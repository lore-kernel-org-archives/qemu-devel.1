Received: from eggs.gnu.org ([2001:4830:134:3::10]:58828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dvIEE-0004lN-Ha
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dvIEB-0000tE-A3
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:18:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dvIEB-0000re-3l
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:18:23 -0400
References: <1506049617-25716-1-git-send-email-thuth@redhat.com>
	<df8f9d2e-9b89-f5b2-3f2e-222cd08ff8df@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b9131ae0-3395-8e4f-1b4a-7e518d2341bc@redhat.com>
Date: Fri, 22 Sep 2017 09:18:10 +0200
MIME-Version: 1.0
In-Reply-To: <df8f9d2e-9b89-f5b2-3f2e-222cd08ff8df@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/boot-sector: Increase timeout to 600
 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>, Victor Kaplansky <victork@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On 22.09.2017 08:21, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Thomas,
>=20
> On 09/22/2017 12:06 AM, Thomas Huth wrote:
>> If QEMU has been compiled with the flags --enable-tcg-interpreter and
>> --enable-debug, the guest is running incredibly slow. The pxe boot tes=
t
>=20
> There already is a qtest_get_arch(), it might be convenient to have a
> qtest_get_accel() at some point.

The "accelerator" (or rather "decelerator") is still TCG in this case -
it's just its backend that is so slow.

Anyway, Luk=C3=A1=C5=A1 recently reported that he could reproduce similar=
 issues
with systems that are under heavy stress:

https://marc.info/?i=3Ddafbe774-2544-f64e-aad2-9cf957025e8d@redhat.com

So I think we should apply this anyway, without any TCI-related checks.

 Thomas
