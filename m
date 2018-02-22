Received: from eggs.gnu.org ([2001:4830:134:3::10]:45349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eot4x-0000X0-OA
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eot4w-0000WM-U8
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:46:39 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:41718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eot4w-0000W1-Nm
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:46:38 -0500
Received: by mail-oi0-x235.google.com with SMTP id e10so4002983oiy.8
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 07:46:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180222153740.3zkvjen77uwjqhd2@sirius.home.kraxel.org>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219111458.25983-5-kraxel@redhat.com>
	<20180222153740.3zkvjen77uwjqhd2@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Feb 2018 15:46:17 +0000
Message-ID: <CAFEAcA8_VRML=FopCKdGnrPCyZ9MwKokMj60962=tgCNwNT2oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/7] qdev: add hotpluggable to
 DeviceState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 22 February 2018 at 15:37, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Mon, Feb 19, 2018 at 12:14:55PM +0100, Gerd Hoffmann wrote:
>> vfio display support wants disable hotplug for certain devices, because
>> qemu doesn't support hotplugging display devices and qemu consoles.
>>
>> Add a hotpluggable bool to DeviceState, initialize it from
>> DeviceClass->hotpluggable, update device_get_hotpluggable accordingly.
>>
>> Devices can flip the new variable from true to false if needed.
>
> Alex wants an ack for this one.  Who maintains it these days?
>
> MAINTAINERS doesn't list qdev.  For QOM which is closest probably
> Andreas F=C3=A4rber is listed.  Havn't seen him on the list for a while
> though.
>
> Ok, lets try some usual suspects...
> Markus? Eric? Paolo? Peter?  Any comments on this one?

What type of device is only sometimes hotpluggable ?
The commit message says "display devices" and "consoles",
but I would expect those to both be types of device which
have a class which is never hotpluggable, so you can mark
them non-hotpluggable with the existing class flag rather
than needing a per-instance flag.

thanks
-- PMM
