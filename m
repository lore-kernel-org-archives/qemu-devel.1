Received: from eggs.gnu.org ([2001:4830:134:3::10]:58812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUUci-0004Tg-KJ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUUce-0000ea-M0
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:04:56 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUUce-0000c9-Bp
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:04:52 -0400
Received: by mail-wr0-x233.google.com with SMTP id k67so129121090wrc.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 02:04:50 -0700 (PDT)
References: <CACbE=3qTtR39sbOcvDhTmVPxOSY+ORjMCKOQcAwDQEX2VbB1YQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CACbE=3qTtR39sbOcvDhTmVPxOSY+ORjMCKOQcAwDQEX2VbB1YQ@mail.gmail.com>
Date: Mon, 10 Jul 2017 10:04:47 +0100
Message-ID: <87y3rwaci8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] HTTPS on qemu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Rys <spleefer90@gmail.com>
Cc: qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


Martin Rys <spleefer90@gmail.com> writes:

> Hi, I don't know which mailing list to use for website things, so I'm
> just using devel, hopefully reaching the correct people.
>
> https://www.ssllabs.com/ssltest/analyze.html?d=qemu.org
>
> Qemu.org still uses HTTP (it should redirect from HTTP to HTTPS
> instead) and HTTPS is broken, only because the TLS certificate seems
> to be self-generated.

The https URL also takes you to the Apache default pages (if you skip
the dire warnings). Anyway CC'ing the relevant names as per:

  http://wiki.qemu.org/AdminContacts

>
> You can easily get a free non-wildcard certificate from Let's Encrypt
> via certbot and automate certificate renewing with something as easy
> as a cron job that calls certbot.
>
> https://letsencrypt.org/
>
> Hopefully I'll see you switch to HTTPS in the future!
>
> Thanks, Martin.


--
Alex Bennée
