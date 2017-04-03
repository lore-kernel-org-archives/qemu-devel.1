Received: from eggs.gnu.org ([2001:4830:134:3::10]:51896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1LD-0000Nv-Fn
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1L8-0008M3-R1
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:44:15 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cv1L8-0008Lf-Me
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:44:10 -0400
Received: by mail-qt0-x244.google.com with SMTP id n37so18663229qtb.3
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:44:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-14-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9ee3ef21-59f3-5a10-1b7e-5d29b5883bf6@amsat.org>
Date: Mon, 3 Apr 2017 09:44:05 -0300
MIME-Version: 1.0
In-Reply-To: <20170401004624.30886-14-ehabkost@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 13/19] unimplemented-device: Remove
 user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 03/31/2017 09:46 PM, Eduardo Habkost wrote:
> unimplemented-device needs to be created and mapped using
> create_unimplemented_device(), and won't work with -device.
> Remove the user_creatable flag from the device class.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/misc/unimp.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
> index 284f096beb..bcbb585888 100644
> --- a/hw/misc/unimp.c
> +++ b/hw/misc/unimp.c
> @@ -90,11 +90,6 @@ static void unimp_class_init(ObjectClass *klass, void *data)
>
>      dc->realize = unimp_realize;
>      dc->props = unimp_properties;
> -    /*
> -     * FIXME: Set only for compatibility on q35 machine-type.
> -     * Probably never meant to be user-creatable
> -     */
> -    dc->user_creatable = true;
>  }
>
>  static const TypeInfo unimp_info = {
>
