Received: from eggs.gnu.org ([2001:4830:134:3::10]:37283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZNu2-0001nq-8h
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:22:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZNu0-00006f-Au
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:22:46 -0500
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:36387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZNu0-000066-4c
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 15:22:44 -0500
Received: by mail-ua0-x22f.google.com with SMTP id 96so19991172uaq.3
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 12:22:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1000152322.892904.1486064716073.JavaMail.zimbra@research.iiit.ac.in>
References: <1000152322.892904.1486064716073.JavaMail.zimbra@research.iiit.ac.in>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Feb 2017 20:22:23 +0000
Message-ID: <CAFEAcA_iF65xBd8=rFATbuR86QABcq6qbSbVHL5eQ-d5SQzySw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] regarding QEMU cloning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shubham Kumar <kumar.shubham@research.iiit.ac.in>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 February 2017 at 19:45, Shubham Kumar
<kumar.shubham@research.iiit.ac.in> wrote:
> I'm unable to clone QEMU using this command on my terminal
>  " git clone git://git.qemu-project.org/qemu.git ".
> The error I'm receiving is
>            " fatal: unable to access 'https://git.qemu-project.org/qemu.git/': Received HTTP code 503 from proxy after CONNECT".
>
> I have tried many solutions given on internet but it doesn't work out.

The error message talks about a proxy, which suggests that the
problem is with the HTTP proxy between you and us (ie probably
your company or institution's). In particular it looks like
your proxy attempts to silently convert git:// protocol
into https://, which is not necessarily going to work.

You could try using HTTPS directly:
git clone https://git.qemu-project.org/git/qemu.git

or HTTP:
git clone http://git.qemu-project.org/git/qemu.git
(note that the url is not quite the same here!)

...but those seem to give 443 timeouts at the moment. I've
asked the qemu server sysadmin if there's something that
needs fixing.

In the meantime, if you can do a git clone that uses
real git:// protocol and doesn't go via your local
proxy then that ought to work.

Or you can use the github mirror:
git clone https://github.com/qemu/qemu.git

thanks
-- PMM
