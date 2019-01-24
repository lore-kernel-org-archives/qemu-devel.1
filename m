Received: from eggs.gnu.org ([209.51.188.92]:58437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmfFX-0005ho-7Q
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmfC2-00030e-Rw
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:37:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmfC2-00030G-Km
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:37:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so6523033wrb.2
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 05:37:18 -0800 (PST)
References: <20190124011554.25418-1-philmd@redhat.com>
	<20190124011554.25418-5-philmd@redhat.com>
	<20190124114305.bdxz76bsxk5lvc3d@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b410cf47-3ed6-46c5-ce4b-ebba84310536@redhat.com>
Date: Thu, 24 Jan 2019 14:37:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190124114305.bdxz76bsxk5lvc3d@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/display/milkymist-tmu2: Move
 inlined code from header to source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>, Peter Maydell <peter.maydell@linaro.org>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>

On 1/24/19 12:43 PM, Gerd Hoffmann wrote:
> On Thu, Jan 24, 2019 at 02:15:54AM +0100, Philippe Mathieu-Daudé wrote:
>> Move the complexity of milkymist_tmu2_create() into the
>> source file. Doing so we avoid to include the X11/OpenGL
>> headers in all LM32 devices, and we also avoid the duplicate
>> declaration of glx_fbconfig_attr[] (it is already declared
>> in hw/display/milkymist-tmu2.c).
>> Since TYPE_MILKYMIST_TMU2 is now accessible, use it.
> 
> Oops, fails the build:
> 
>   LINK    lm32-softmmu/qemu-system-lm32
> hw/lm32/milkymist.o: In function `milkymist_init':
> milkymist.c:(.text+0xb0f): undefined reference to `milkymist_tmu2_create'

Funny, I was busy testing your other audio series while you were testing
mine :)

I'll have a look, thanks.

Phil.
