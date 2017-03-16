Received: from eggs.gnu.org ([2001:4830:134:3::10]:35090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coXva-0003Iw-Hh
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coXvV-0001RK-29
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:07:02 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:33839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coXvU-0001QL-RX
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:06:56 -0400
Received: by mail-wr0-x22b.google.com with SMTP id l37so35394854wrc.1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:06:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170316160012.GX15193@redhat.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<20170316154643.GT15193@redhat.com>
	<CAFEAcA9WdjkAr0eWNApWQGZAw4_67sci3LtY8=9pzYDcDXiLmg@mail.gmail.com>
	<20170316160012.GX15193@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 16:06:35 +0000
Message-ID: <CAFEAcA8Mo2PAE2QE8bd0mNTkjRHjpS9BcRj1kk1wwDXYJ2-4nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 March 2017 at 16:00, Daniel P. Berrange <berrange@redhat.com> wrote:
> I'm just pretty wary of gratuitously deleting stuff that still
> has a reasonable chance of being functional, simply because
> we lack CI testing.

Well, me too, but I think that if nobody turns up to help us
or donate a test machine despite configure yelling at them
for a release cycle or two then it's not all that gratuitous.

(Just for instance there's some grotty code in configure that
looks at 'uname -m' to guess what host OS it is, which is
really not the right way to do it. But I've never been able
to clean that up because maybe it might break something
semi obscure in the process.)

thanks
-- PMM
