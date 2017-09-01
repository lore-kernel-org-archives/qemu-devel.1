Received: from eggs.gnu.org ([2001:4830:134:3::10]:36142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnoUR-0003ag-Df
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnoUM-00005v-MI
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:08:15 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnoUM-00005Z-FU
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:08:10 -0400
Received: by mail-qk0-x244.google.com with SMTP id a77so474773qkb.1
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 09:08:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170901125742.4249-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ff830cfa-a8fa-0852-596f-4fc535512b1c@amsat.org>
Date: Fri, 1 Sep 2017 13:08:05 -0300
MIME-Version: 1.0
In-Reply-To: <20170901125742.4249-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/5] Vga 20170901 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

Hi Gerd,

On 09/01/2017 09:57 AM, Gerd Hoffmann wrote:
> The following changes since commit 223cd0e13f2e46078d7b573f0b8402bfbee339be:
> 
>    Merge remote-tracking branch 'remotes/elmarco/tags/tidy-pull-request' into staging (2017-08-31 15:52:43 +0100)
> 
> are available in the git repository at:
> 
>    git://git.kraxel.org/qemu tags/vga-20170901-pull-request
> 
> for you to fetch changes up to 138bc2df843105edb22978284fc2e16307f16211:
> 
>    vga/migration: Update memory map in post_load (2017-09-01 13:52:43 +0200)
> 
> ----------------------------------------------------------------
> qxl: chunked cursor support.
> stdvga: bugfixes.
> 
> ----------------------------------------------------------------
> 
> Dr. David Alan Gilbert (1):
>    vga/migration: Update memory map in post_load
> 
> Gerd Hoffmann (4):
>    vga: fix display update region calculation (split screen)
>    vga: stop passing pointers to vga_draw_line* functions
>    qxl: drop mono cursor support
>    qxl: add support for chunked cursors.

I'v been reviewing your patches and took some notes but didn't finished, 
since there is something bothering me.
I see they haven't been reviewed yet, can you hold this PR and wait the 
weekend?

Thanks,

Phil.

> 
>   hw/display/vga-helpers.h | 202 ++++++++++++++++++++++++++---------------------
>   hw/display/vga_int.h     |   1 +
>   hw/display/qxl-render.c  |  45 +++++++----
>   hw/display/vga.c         |  16 +++-
>   4 files changed, 152 insertions(+), 112 deletions(-)
> 
