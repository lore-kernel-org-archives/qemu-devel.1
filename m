Received: from eggs.gnu.org ([2001:4830:134:3::10]:35894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1dwkt1-0001v7-Jj
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1dwksy-00040U-F4
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:06:35 -0400
Received: from thoth.sbs.de ([192.35.17.2]:52240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1dwksy-0003zz-3t
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:06:32 -0400
References: <20170926063820.30773-1-kraxel@redhat.com>
	<053ad89e-9084-905e-a6cd-4a1f4c4638e8@siemens.com>
	<1506410511.32072.11.camel@redhat.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a22df311-b05c-16bf-0752-7f2a44a5dbe9@siemens.com>
Date: Tue, 26 Sep 2017 10:06:27 +0200
MIME-Version: 1.0
In-Reply-To: <1506410511.32072.11.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb: fix libusb config variable name.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 2017-09-26 09:21, Gerd Hoffmann wrote:
> On Tue, 2017-09-26 at 09:16 +0200, Jan Kiszka wrote:
>> On 2017-09-26 08:38, Gerd Hoffmann wrote:
>>> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>>> Fixes: 4e5ee5b21c84fe3023a64b5cc2e12a52ab0597c1
>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>> ---
>>> =C2=A0hw/usb/Makefile.objs | 2 +-
>>> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
>>> index 9255234c63..0e6d54b21f 100644
>>> --- a/hw/usb/Makefile.objs
>>> +++ b/hw/usb/Makefile.objs
>>> @@ -42,7 +42,7 @@ redirect.o-cflags =3D $(USB_REDIR_CFLAGS)
>>> =C2=A0redirect.o-libs =3D $(USB_REDIR_LIBS)
>>> =C2=A0
>>> =C2=A0# usb pass-through
>>> -ifeq ($(CONFIG_LIBUSB)$(CONFIG_USB),yy)
>>> +ifeq ($(CONFIG_USB_LIBUSB)$(CONFIG_USB),yy)
>>> =C2=A0common-obj-y +=3D host-libusb.o host-legacy.o
>>> =C2=A0else
>>> =C2=A0common-obj-y +=3D host-stub.o
>>>
>>
>> This won't still work, only patch did -> CONFIG_USB isn't set when
>> building the common objects.
>=20
> I've tested it, and it did work.  Also note that there are a bunch of
>=20
>    common-obj-$(CONFIG_USB) +=3D something
>=20
> lines in hw/usb/Makefile.objs
>=20

I swear it didn't while developing the fix, but it does indeed now.

Tested-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan
