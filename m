Received: from eggs.gnu.org ([2001:4830:134:3::10]:37311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW2VD-00067f-1I
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW2VC-0000sw-4p
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:27:34 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dW2VB-0000sY-VK
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:27:34 -0400
Received: by mail-wm0-x230.google.com with SMTP id f67so26068672wmh.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 08:27:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500045231-23322-1-git-send-email-mst@redhat.com>
References: <1500045231-23322-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 16:27:12 +0100
Message-ID: <CAFEAcA9VzBC-mdqWFaXo8P5jyjByx+vb=HQqN0CAck6pi7wq0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vmgenid-test: use boot-sector
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Ben Warren <ben@skyportsystems.com>

On 14 July 2017 at 16:13, Michael S. Tsirkin <mst@redhat.com> wrote:
> There's no requirement for RSDP to be installed last
> by the firmware, so in rare cases vmgen id test hits
> a race: RSDP is there but VM GEN ID isn't.
>
> To fix, switch to common boot sector infrastructure.
> @@ -189,6 +197,10 @@ int main(int argc, char **argv)
>  {
>      int ret;
>
> +    ret = boot_sector_init(disk);
> +    if(ret)
> +        return ret;

This needs braces and a space after "if".

thanks
-- PMM
