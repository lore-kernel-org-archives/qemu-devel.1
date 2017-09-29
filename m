Received: from eggs.gnu.org ([2001:4830:134:3::10]:55596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dy4s8-0007TC-QJ
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 19:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dy4s8-0007WM-3M
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 19:39:08 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:50282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dy4s7-0007W6-SS
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 19:39:08 -0400
Received: by mail-wm0-x229.google.com with SMTP id u138so1957821wmu.5
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 16:39:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAPUEspiEoZk2ems4L_f9J7y9r+65EKu85COJzkBoH_YYuu+q8A@mail.gmail.com>
References: <1506703816-7359-1-git-send-email-zhuoweizhang@yahoo.com>
	<46ce7f3c-f0cb-bdfe-25fc-984276601f7d@vivier.eu>
	<CAPUEspiEoZk2ems4L_f9J7y9r+65EKu85COJzkBoH_YYuu+q8A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Sep 2017 16:38:46 -0700
Message-ID: <CAFEAcA9w6ok+XjRmBF1=o+pKh=D356UFb7LwjJZzOyWUkgSyWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] syscall: fix special case of write(fd, NULL,
 0)
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Carlo Arenas <carenas@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, zhuoweizhang@yahoo.com, QEMU Developers <qemu-devel@nongnu.org>
List-ID: <qemu-devel.nongnu.org>

On 29 September 2017 at 16:33, Carlo Arenas <carenas@gmail.com> wrote:
> a return of 0 is a valid response for write per POSIX and just indicates 0
> bytes were written.

The interface we are implementing here is not the POSIX write()
function but the Linux write syscall, whose semantics are not
necessarily identical, though perhaps they may be in this case.

thanks
-- PMM
