Received: from eggs.gnu.org ([2001:4830:134:3::10]:57109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewnnG-0004Ui-GL
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ewnnB-0007d8-HW
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:45:06 -0400
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:33336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ewnnB-0007cm-AB
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:45:01 -0400
Received: by mail-pl0-x22d.google.com with SMTP id c11-v6so5737239plo.0
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 04:45:00 -0700 (PDT)
References: <20180316103408.22295-1-richard.henderson@linaro.org>
	<CAFEAcA_fABdsR8z4NTNP9Ux6ZLGVsfw5NpPyqB1HqV72_VjgDQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fd1e45ca-53b5-1e3d-eacc-2c9a91467674@linaro.org>
Date: Fri, 16 Mar 2018 19:44:55 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_fABdsR8z4NTNP9Ux6ZLGVsfw5NpPyqB1HqV72_VjgDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Allocate extra space for brk
 in PIE executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, 1749393@bugs.launchpad.net

On 03/16/2018 07:01 PM, Peter Maydell wrote:
> PS: do you know what the intention of the
>         if (reserved_va) {
>             mmap_next_start = reserved_va;
>         }
> code in linux-user/main.c is? It seems a bit odd to say "ok,
> we have reserved a big region. we will start trying to mmap
> outside it.", especially when that region covers the full
> 4G that the guest can access...

My guess is that it probably should have been

  mmap_next_start = MIN(TASK_UNMAPPED_BASE, reserved_va);

I can't think of any other reason it should be modified at all.


r~
