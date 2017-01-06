Received: from eggs.gnu.org ([2001:4830:134:3::10]:44219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPUq2-0005OQ-Es
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:45:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPUq1-0005h7-LE
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:45:46 -0500
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:36368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPUq1-0005gu-9a
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 08:45:45 -0500
Received: by mail-vk0-x22c.google.com with SMTP id p9so313553488vkd.3
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 05:45:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0C9DA454-E3DC-4291-806E-9A96557DE833@gmail.com>
References: <0C9DA454-E3DC-4291-806E-9A96557DE833@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 13:45:24 +0000
Message-ID: <CAFEAcA8Y5k_GNFw+ZgaY09tLTc0V=9FZLRGY-uDZHVMY_SoPxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: add toast file support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 30 December 2016 at 20:42, Programmingkid <programmingkidx@gmail.com> wrote:
> Add the ability for the user to use .toast files with QEMU. This format works
> just like ISO files.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  ui/cocoa.m | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 26d4a1c..c81f7b6 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -879,7 +879,7 @@ QemuCocoaView *cocoaView;
>          // set the supported image file types that can be opened
>          supportedImageFileTypes = [NSArray arrayWithObjects: @"img", @"iso", @"dmg",
>                                   @"qcow", @"qcow2", @"cloop", @"vmdk", @"cdr",
> -                                  nil];
> +                                  @"toast", nil];
>          [self make_about_window];
>      }
>      return self;
> --

Applied to cocoa.next, thanks.

-- PMM
