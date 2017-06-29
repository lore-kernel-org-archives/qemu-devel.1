Received: from eggs.gnu.org ([2001:4830:134:3::10]:36760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQaBJ-0002fB-Lu
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQaBI-0001Kg-TK
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:12:29 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQaBI-0001KG-N7
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:12:28 -0400
Received: by mail-wm0-x22e.google.com with SMTP id w126so83547340wme.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 07:12:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <B1DA44315104F94D9F3F23C74275EA9D5C2D34@Ikerlan-12.ikerlan.es>
References: <B1DA44315104F94D9F3F23C74275EA9D5C2D34@Ikerlan-12.ikerlan.es>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 15:12:07 +0100
Message-ID: <CAFEAcA_EW4FwQF7UJkDr6coTegx=6xzLNd2x6Sdu-ODTPh7enw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Debugging source code with Eclipse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ormaetxea Xabier <xormaetxea@ikerlan.es>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 29 June 2017 at 10:37, Ormaetxea Xabier <xormaetxea@ikerlan.es> wrote:
> Im trying to debug the source code of Qemu with Eclipse to try to underst=
and how it works. Im not totally sure how should I do this process, but I'v=
e create a Eclipse C project using all the Qemu source code. Unfortunately =
I get a lot of errors for each code piece, and I can't run it.
>
> Those errors are: "type/symbol... '<name>' could not be resolved"
>
> Am I doing in it right? How can I debug the source code of Qemu?

I think most QEMU developers use 'make' to build QEMU,
and 'gdb' to run it.

You might be able to use Eclipse
for the debugging part, but you'd need to ask in an
Eclipse user group about how to get it to work with an
existing just-uses-Make program. (This must be a fairly
common use case so I would expect Eclipse to support it
somehow.)

I would not recommend trying to build QEMU with anything
except our configure/make machinery. It is too complicated
to try to reproduce with anything else.

thanks
-- PMM
