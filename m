Received: from eggs.gnu.org ([209.51.188.92]:38759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gkVLB-00059y-Hp
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1gkVLA-0005mw-Ny
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:41:49 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1gkVLA-0005j7-G8
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:41:48 -0500
Received: by mail-io1-f65.google.com with SMTP id k7so10878168iob.6
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20190116191950.94110-1-emaste@freefall.freebsd.org>
	<aaed1717-c03c-4f51-8422-351ab359efb6@redhat.com>
In-Reply-To: <aaed1717-c03c-4f51-8422-351ab359efb6@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Fri, 18 Jan 2019 09:41:33 -0500
Message-ID: <CAPyFy2DQPFbmZu31nDagfX08MD4EbPUn+vUfKLJOoSsey56XOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Thu, 17 Jan 2019 at 01:28, Thomas Huth <thuth@redhat.com> wrote:
>
> > +    bison curl cyrus-sasl fontconfig freetype2 git glib gmake gnutls
>
> I'm still wondering why you need fontconfig and freetype2 here?

They must have crept in from previous experimentation; confirmed still
builds and tests pass on FreeBSD without them. New patch coming.
