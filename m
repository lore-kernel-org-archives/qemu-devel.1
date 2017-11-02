Received: from eggs.gnu.org ([2001:4830:134:3::10]:53198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eALHf-0000Mg-Jj
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 15:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eALHe-00070D-UG
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 15:36:11 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eALHe-0006zw-NL
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 15:36:10 -0400
Received: by mail-wm0-x244.google.com with SMTP id t139so1121506wmt.1
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 12:36:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2251f54e-4c55-7495-8f60-af40cdd80594@redhat.com>
References: <20171024230758.31779-1-riggle@google.com>
	<20171025033442.44872-1-zachriggle@gmail.com>
	<CAMP9c5=whCgR4qkOPDRKZ+adpWEPiVM=BwZp_r7qCAR7UAsWAQ@mail.gmail.com>
	<20171027093600.GA29513@kos.to>
	<CAMP9c5mm7icy06goXr3iiOEgqPbzyaWDt775+9+L=oxnqwRhpA@mail.gmail.com>
	<CAMP9c5kTQmKd7GVE8DZzvY8tTtWV=tLsgV1ptWPKhEAh=J-maQ@mail.gmail.com>
	<2251f54e-4c55-7495-8f60-af40cdd80594@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 19:35:48 +0000
Message-ID: <CAFEAcA-r-KxNDkHFJEdQDVnNXf4N-8zptjQK9a-uPixnSMsg+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: fix is_proc_myself to check
 the paths via realpath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Zach Riggle <zachriggle@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, QEMU Trivial <qemu-trivial@nongnu.org>, Laurent Vivier <laurent@vivier.eu>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 28 October 2017 at 06:14, Eric Blake <eblake@redhat.com> wrote:
> By definition, in linux-user, we ARE using glibc; therefore, you are
> free to use all GNU extensions.

Don't we also support musl libc? I forget...

thanks
-- PMM
