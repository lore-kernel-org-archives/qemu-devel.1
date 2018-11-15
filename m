Received: from eggs.gnu.org ([2001:4830:134:3::10]:51254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNEm5-00013v-7C
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:21:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gNElx-0003fF-4L
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:21:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gNElt-0003au-Uo
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 05:21:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id 124-v6so18381168wmw.0
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 02:21:08 -0800 (PST)
References: <20180420104743.7396-1-kraxel@redhat.com>
	<3f72757a-4b4c-9241-dd8f-561886cf3295@redhat.com>
	<a17f8629-e628-3b3d-f964-98bcb9b218f3@redhat.com>
	<20181115075637.3lentc3rdn5jlnhd@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eb2e9dcb-b5c1-ec36-c2e7-61a0876030e0@redhat.com>
Date: Thu, 15 Nov 2018 11:21:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181115075637.3lentc3rdn5jlnhd@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] simple firmware.json test tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

On 15/11/18 8:56, Gerd Hoffmann wrote:
>    Hi,
> 
>>> Perhaps print a few shell commands first? Such as:
>>>
>>>     (
>>>       VARSTORE=$(mktemp)
>>>       trap 'rm -f -- "$VARSTORE"' EXIT
>>>       cat -- '[VARSTORE_TEMPLATE]' >> "$VARSTORE"
>>>       qemu ...
>>>     )
>>>
>>> It really does take separate actions, just like when you create a new
>>> disk image with "qemu-img".
> 
>> Any plan to respin this patch?
> 
> -ENOTIME[1].  Also no really good idea how to handle varstore.
> 
> I'd like to have something simple, so it is easy run qemu with the
> correct arguments.  Just ...
> 
>    qemu-system-$arch $(qemu-firmware /path/to/firmware.json)
> 
> ... would be cool, but varstore handling isn't going to fly that way.
> 
> Maybe we really have to print some shell commands and set some specific
> variables, so one can do something like this:
> 
>    eval $(qemu-firmware /path/to/firmware.json)
>    qemu-system-${QEMU_FIRMWARE_ARCH} ${QEMU_FIRMWARE_ARGS}
> 
> cheers,
>    Gerd
> 
> [1] feel free to pick it up.

OK, thanks!

Phil.
