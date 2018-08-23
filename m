Received: from eggs.gnu.org ([2001:4830:134:3::10]:52145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsn3e-0003Li-Gm
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsn3d-0002vW-Ki
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:41:42 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fsn3d-0002vL-EE
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 06:41:41 -0400
Received: by mail-oi0-x241.google.com with SMTP id z185-v6so8002157oia.5
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 03:41:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180823102502.28122-1-berrange@redhat.com>
References: <20180823102502.28122-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 11:41:20 +0100
Message-ID: <CAFEAcA-jfnWjAA3zhUKZ2ZBJdD+JmndLgrigJnxuVFJN5e=pXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts: report on author emails that are
 mangled by the mailing list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 August 2018 at 11:25, Daniel P. Berrang=C3=A9 <berrange@redhat.com> w=
rote:
> In some cases the Author: email address in patches submitted to the
> list gets mangled such that it says
>
>     John Doe via Qemu-devel <qemu-devel@nongnu.org>
>
> This change is a result of workarounds for DMARC policies.

I do wonder if overall we'd be better off with the other
workaround (don't change From lines in list emails, don't
add "[Qemu-devel]" prefix to subject lines)... It would be
a one-off annoyance to people who filter list mail on subject
rather than other headers, but it would get rid of this annoying
wart where a handful of senders end up with their mail with
a from address that our patch management tools don't handle
very well...

thanks
-- PMM
