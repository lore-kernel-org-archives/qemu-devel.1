Received: from eggs.gnu.org ([2001:4830:134:3::10]:33352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f7WQ9-00021u-Qq
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 21:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f7WQ8-0006Dv-OQ
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 21:25:33 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:43221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f7WQ8-0006DK-F7
	for qemu-devel@nongnu.org; Sat, 14 Apr 2018 21:25:32 -0400
Received: by mail-wr0-x22e.google.com with SMTP id y7so16817997wrh.10
	for <qemu-devel@nongnu.org>; Sat, 14 Apr 2018 18:25:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <15bb2d94.286e.162c4d4ab19.Coremail.suhang16@mails.ucas.ac.cn>
References: <1523245158-16443-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1523245158-16443-2-git-send-email-suhang16@mails.ucas.ac.cn>
	<CAJSP0QVJbCz=n-huxj3grUtcMAgOYzcExEZHh8rJEoaxnz_jgA@mail.gmail.com>
	<15bb2d94.286e.162c4d4ab19.Coremail.suhang16@mails.ucas.ac.cn>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 15 Apr 2018 09:25:30 +0800
Message-ID: <CAJSP0QW2e7w6bvv5RdWo3etrYipNj5=sVUwVMBodW4W5HkhgKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 1/2] Implement .hex file loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: jim mussared <jim@groklearning.com>, qemu-devel <qemu-devel@nongnu.org>, joel stanley <joel@jms.id.au>

On Sat, Apr 14, 2018 at 11:44 PM, Su Hang <suhang16@mails.ucas.ac.cn> wrote:
> Thanks for your detailed reply! I  will carefully treat
> all the content that you mentioned, and apply them in v5.

By the way, if you are wondering why the parser needs to validate
everything, here is an example scenario:

QEMU may be used to host an online micro:bit simulator where the user
can provide a .hex file.  In that case QEMU is running on a server and
the .hex file is provided by an untrusted user.  That user must not be
able to crash QEMU (and exploit security holes).

Stefan
