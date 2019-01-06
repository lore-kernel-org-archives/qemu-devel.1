Received: from eggsout.gnu.org ([209.51.188.92]:52333 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1gg44i-0007ZI-G8
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 03:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1gg44g-0007Ej-GC
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 03:46:28 -0500
Received: from mail-it1-x132.google.com ([2607:f8b0:4864:20::132]:36755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1gg44f-0007Dg-Np
	for qemu-devel@nongnu.org; Sun, 06 Jan 2019 03:46:26 -0500
Received: by mail-it1-x132.google.com with SMTP id c9so6599644itj.1
	for <qemu-devel@nongnu.org>; Sun, 06 Jan 2019 00:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20190106053409.10712-1-fam@euphon.net>
	<20190106053409.10712-4-fam@euphon.net>
In-Reply-To: <20190106053409.10712-4-fam@euphon.net>
From: Carlo Arenas <carenas@gmail.com>
Date: Sun, 6 Jan 2019 00:46:10 -0800
Message-ID: <CAPUEspjTMyObH=8000pEeLumcyTHARH-jfi43VsLuboxdRUFMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 3/3] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <fam@euphon.net>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Sat, Jan 5, 2019 at 9:39 PM Fam Zheng <fam@euphon.net> wrote:
> +        self.ssh_root("shutdown -p now")

could use `halt -p` as a more direct/obvious/effective command
