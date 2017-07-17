Received: from eggs.gnu.org ([2001:4830:134:3::10]:38991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX9jZ-0003dz-KN
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dX9jY-0003lH-QT
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:23:01 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dX9jY-0003ks-J1
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:23:00 -0400
Received: by mail-wr0-x22f.google.com with SMTP id w4so26062119wrb.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 10:23:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170717164641.GA31820@work-vm>
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
	<20170717164641.GA31820@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 18:22:38 +0100
Message-ID: <CAFEAcA9ew+gRR2rUyKHmRoeEc+2gF7QWv68OKRpuW-my_VPswA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>

On 17 July 2017 at 17:46, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> You may find this doesn't help in some windows builds;  the assert
> functions aren't always marked as noreturn (because they pop up a dialog
> that asks you whether you want to run into a debugger etc).

Oh, is that why?

In any case, we rely on g_assert() and friends from glib being
definitely marked noreturn, so we could use them instead.

thanks
-- PMM
