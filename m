Received: from eggs.gnu.org ([2001:4830:134:3::10]:57526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8Qb6-0005MP-2T
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:56:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8Qaz-0000dO-J6
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:56:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8Qaz-0000d4-CD
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:56:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id e4-v6so13698365wrs.0
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:56:45 -0700 (PDT)
References: <20181005134608.1251-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cdd4c07b-f53b-9353-55d7-b329d5331268@redhat.com>
Date: Fri, 5 Oct 2018 15:56:42 +0200
MIME-Version: 1.0
In-Reply-To: <20181005134608.1251-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qxl: check qxl_phys2virt return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On 05/10/2018 15:46, Gerd Hoffmann wrote:
> Fixes: CID 1395986

Thomas suggested yesterday [*] to use the 'Buglink:' tag, however I
can't find direct link to Coverity IDs.

[*]
https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message

If your patch fixes a commit that is already in the repository, please
add a line with "Fixes: <full-SHA-commit-id>" below the patch
description / before your "Signed-off-by:" line in the commit message.
If your patch addresses a bug in a public bug tracker, please add a line
with "Buglink: <URL-of-the-bug>" there, too.

> Fixes: 979f7ef8966bc4495a710ed9e4af42098f92ee79> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/display/qxl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 747986478f..bbf14fb42f 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -290,7 +290,7 @@ static void qxl_spice_monitors_config_async(PCIQXLDevice *qxl, int replay)
>      }
>  
>      cfg = qxl_phys2virt(qxl, qxl->guest_monitors_config, MEMSLOT_GROUP_GUEST);
> -    if (cfg->count == 1) {
> +    if (cfg != NULL && cfg->count == 1) {
>          qxl->guest_primary.resized = 1;
>          qxl->guest_head0_width  = cfg->heads[0].width;
>          qxl->guest_head0_height = cfg->heads[0].height;
> 
