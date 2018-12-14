Received: from eggs.gnu.org ([2001:4830:134:3::10]:54269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXlgk-00035Q-4H
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXlgh-00069h-GR
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:31:25 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXlgf-0005wI-Kl
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:31:23 -0500
Received: by mail-oi1-x242.google.com with SMTP id c206so4306458oib.0
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 03:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20181122172653.3413-1-peter.maydell@linaro.org>
In-Reply-To: <20181122172653.3413-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 11:30:56 +0000
Message-ID: <CAFEAcA9jMm2owmxh5w9GL3DRJoNnD69gBZDWxn7i+9M3Og6ZPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0 0/3] Avoid
 cpu_physical_memory_read() in generic code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On Thu, 22 Nov 2018 at 17:28, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset takes three places in generic code which
> use cpu_physical_memory_read(), and changes them to use
> address_space_read() instead.
>
> Changes v1->v2:
>  * patches 1, 2 unchanged (and reviewed)
>  * patch 3: handle as being NULL (which for the
>    load_elf APIs means "use address_space_memory")

I'm adding this to a 'misc' pullreq I'm putting together.

thanks
-- PMM
