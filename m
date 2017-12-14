Received: from eggs.gnu.org ([2001:4830:134:3::10]:36110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1ePb0O-0005Rv-Ol
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 16:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1ePb0N-0003te-VF
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 16:25:24 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1ePb0N-0003qr-EK
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 16:25:23 -0500
Received: by mail-wr0-x241.google.com with SMTP id v34so433179wrb.0
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 13:25:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171207065639.164900-1-lepton@google.com>
References: <20171207065639.164900-1-lepton@google.com>
From: =?UTF-8?B?VGFvIFd1KOWQtOa2m0BFbmcp?= <lepton@google.com>
Date: Thu, 14 Dec 2017 13:25:19 -0800
Message-ID: <CAOvqHj4P17JQ=bJqpZsA3n-sfw927Sad3-YD2FUHff1zhpanGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/input/hid: Add support for several keys.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: qemu-trivial@nongnu.org, kraxel@redhat.com, mjt@tls.msk.ru, Laurent Vivier <laurent@vivier.eu>, Tao Wu <lepton@google.com>

Anybody can merge this?

It's a simple change:  actually it only changed 4 bytes in hid usage
table to enable 4 keys: audiomute volumeup volumedown and power.

It's easy to verify what the patch is doing:

Boot some guest os with argument "-usbdevice keyboard"  and use qemu
monitor console to do "sendkey audiomute", without this patch, nothing
happend inside guest os. with this patch,  all these 4 keys work correctly.

On Wed, Dec 6, 2017 at 10:56 PM, Tao Wu <lepton@google.com> wrote:
> Add support for these keys: audiomute volumedown volumeup power.
> Tested with "sendkey" command in monitor and verify the behavior
> in guest OS.
>
> Signed-off-by: Tao Wu <lepton@google.com>
> ---
>  hw/input/hid.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/input/hid.c b/hw/input/hid.c
> index 0d049ff61c..aa4fb826fd 100644
> --- a/hw/input/hid.c
> +++ b/hw/input/hid.c
> @@ -57,14 +57,14 @@ static const uint8_t hid_usage_keys[0x100] = {
>      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>      0x00, 0x00, 0x00, 0x00, 0x58, 0xe4, 0x00, 0x00,
> -    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -    0x00, 0x00, 0x00, 0x00, 0x00, 0x54, 0x00, 0x46,
> +    0x7f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x81, 0x00,
> +    0x80, 0x00, 0x00, 0x00, 0x00, 0x54, 0x00, 0x46,
>      0xe6, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>      0x00, 0x00, 0x00, 0x00, 0x00, 0x48, 0x48, 0x4a,
>      0x52, 0x4b, 0x00, 0x50, 0x00, 0x4f, 0x00, 0x4d,
>      0x51, 0x4e, 0x49, 0x4c, 0x00, 0x00, 0x00, 0x00,
> -    0x00, 0x00, 0x00, 0xe3, 0xe7, 0x65, 0x00, 0x00,
> +    0x00, 0x00, 0x00, 0xe3, 0xe7, 0x65, 0x66, 0x00,
>      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> --
> 2.15.1.424.g9478a66081-goog
>
