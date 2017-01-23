Received: from eggs.gnu.org ([2001:4830:134:3::10]:54149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVgKY-0001De-5m
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVgKX-0002WA-7l
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:14:50 -0500
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230]:34226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVgKX-0002Vx-2t
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:14:49 -0500
Received: by mail-ua0-x230.google.com with SMTP id 35so111906831uak.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 07:14:48 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jan 2017 15:14:28 +0000
Message-ID: <CAFEAcA8bVVwdLAuF-wV4_mYCL0XvN6-jdnmnPgQR765xaAc1hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] what is the syntax and meaning of -numa cpus=foo-bar ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

Hi; something we noticed recently is that some versions of
makeinfo gripe about the -numa option syntax in qemu-options.hx:

qemu-options.texi:60: warning: unlikely character [ in @var.
qemu-options.texi:60: warning: unlikely character ] in @var.
qemu-options.texi:61: warning: unlikely character [ in @var.
qemu-options.texi:61: warning: unlikely character ] in @var.

This is provoked by qemu-options.hx having:

@item -numa node[,mem=@var{size}][,cpus=@var{cpu[-cpu]}][,nodeid=@var{node}]
@itemx -numa node[,memdev=@var{id}][,cpus=@var{cpu[-cpu]}][,nodeid=@var{node}]

The obvious simple syntax fix is to change it to
"cpus=@var{cpu}[-@var{cpu}]" (ie the @var{} covers only
the metasyntactic variables the user has to fill in,
not the '-' which is I think a literal and the [] which
are indicating that the second part is optional).

However, this leaves me still rather in the dark as a user of
the documentation about what the option actually does. The
text below doesn't explain what the two 'cpu' fields I
can fill in do, or what values they can take. They should
probably be different names as well (eg "start-end", or
whatever makes sense for the semantics) so that the text
can refer to them usefully.

Would somebody who understands the -numa option like to
propose a few lines of text to clarify things?

thanks
-- PMM
