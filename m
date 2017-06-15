Received: from eggs.gnu.org ([2001:4830:134:3::10]:49761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLXqx-0005bM-Ag
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:42:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dLXqw-0003Ez-GM
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:42:39 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:34209)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dLXqw-0003EN-A1
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 12:42:38 -0400
Received: by mail-wm0-x233.google.com with SMTP id d64so1098520wmf.1
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 09:42:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170615163813.7255-1-stefanha@redhat.com>
References: <20170615163813.7255-1-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 15 Jun 2017 17:42:36 +0100
Message-ID: <CAJSP0QXjOC3Qbeg+TRXzgHkvfZQwkFRNUQOtcbR9Tq4EgNT_tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/5] qemu-iotests: test savevm/loadvm
 iothread (and make it work!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>

On Thu, Jun 15, 2017 at 5:38 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> This series extends qemu-iotests 068 to also run with iothread enabled.

I forgot to mention: this series is based on Kevin's 'block' branch:

  git://repo.or.cz/qemu/kevin.git block

This is necessary in order to get the "[PATCH v3 0/4] block: fix
'savevm' hang with -object iothread" patches that fix savevm.

Stefan
