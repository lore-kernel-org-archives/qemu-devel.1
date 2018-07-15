Received: from eggs.gnu.org ([2001:4830:134:3::10]:38963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1feoPl-0007jb-Pg
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 17:18:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1feoPk-0006DG-Qw
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 17:18:45 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:38267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1feoPk-0006Co-Kv
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 17:18:44 -0400
Received: by mail-oi0-x242.google.com with SMTP id v8-v6so71290492oie.5
	for <qemu-devel@nongnu.org>; Sun, 15 Jul 2018 14:18:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG48ez2Rq18M+a84Ae+N5_=eS2A6zZNrG9r19MWS6hddq=x4Rw@mail.gmail.com>
References: <CAG48ez2Rq18M+a84Ae+N5_=eS2A6zZNrG9r19MWS6hddq=x4Rw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 15 Jul 2018 22:18:23 +0100
Message-ID: <CAFEAcA_+oq2H=-_7+AxqpXb_VhUsSAgVgN8K7Q+ffeKXxs5gWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] insecure git submodule URLs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jann Horn <jannh@google.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 15 July 2018 at 20:50, Jann Horn via Qemu-devel
<qemu-devel@nongnu.org> wrote:
> I noticed that when I build QEMU from git for the first time, it pulls
> in submodules over the insecure git:// protocol - in other words, as
> far as I can tell, if I'm e.g. on an open wifi network while building
> QEMU for the first time, even if I cloned the main repository over
> https, anyone could smuggle in malicious code as part of e.g. a
> submodule's makefile.

Yes, this came up the other week.

> I'm not sure what your preferred fix for this is, so I'm not sending a
> patch yet. As far as I can tell, the two options are:
>
>  - change .gitmodules to use https for everything

We should probably do this...

>  - change .gitmodules to use relative URLs
>
> If you want, I'll send a patch that does one of these, although it's
> probably faster if you just do it yourselves.
>
> Relative URLs would have the advantage that if someone is cloning from
> a mirror (in other words, github), the submodules will also
> automatically come from the same mirror.

Do we mirror all our submodules to github?

> As far as I can tell, the QEMU git server only supports the "dumb" git
> protocol when accessed over HTTPS, not the "smart" protocol. I'm not
> sure whether that might be why QEMU is currently still using the
> insecure git protocol instead of git over HTTPS?

This is why we haven't switched over the submodules yet, yes.
It's on Jeff's todo list for the server, though.

thanks
-- PMM
