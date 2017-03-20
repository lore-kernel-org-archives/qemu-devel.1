Received: from eggs.gnu.org ([2001:4830:134:3::10]:59674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cq0GO-0006rG-5X
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cq0GN-0003Cv-Ai
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:34:32 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cq0GN-0003Bj-4R
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:34:31 -0400
Received: by mail-wr0-x230.google.com with SMTP id g10so96170329wrg.2
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 09:34:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_Rg_0WePeSg2COsmnDsGQbeWjFjNjvB+HjtLRzeouSGQ@mail.gmail.com>
References: <1490000743-3615-1-git-send-email-kraxel@redhat.com>
	<CAFEAcA_Rg_0WePeSg2COsmnDsGQbeWjFjNjvB+HjtLRzeouSGQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 16:34:09 +0000
Message-ID: <CAFEAcA9T=XSbZ7ydPQtiqMFv6=VYLaC1Q=T-1qVDem3hLv4m_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] audio: catch missing sdl support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 March 2017 at 15:43, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 20 March 2017 at 09:05, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> sdl is probed before audio, so we can simply look at $sdl so see
>> whenever we have support or not.  Throw an error in case sdl audio
>> is requested without sdl being available.

> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Tested-by: Peter Maydell <peter.maydell@linaro.org>
>
> I'll apply this to master as a buildfix in a bit.

...now applied.

thanks
-- PMM
