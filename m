Received: from eggs.gnu.org ([2001:4830:134:3::10]:46604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e9mPw-0005Cl-QR
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 02:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e9mPs-0003x5-3t
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 02:22:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e9mPr-0003vy-T0
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 02:22:20 -0400
References: <CAFEAcA81ENKOYTCvhpBrXnreyy9zodk-EXqvwLZq=1w6UvkoAg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <832ea538-6347-9b00-6a44-48159f94748f@redhat.com>
Date: Wed, 1 Nov 2017 07:22:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA81ENKOYTCvhpBrXnreyy9zodk-EXqvwLZq=1w6UvkoAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] we allow passing -machine type=foo more than once
 but are confused about which to use...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>

On 31.10.2017 19:33, Peter Maydell wrote:
> (cc Markus because I know how much he likes weirdnesses in our
> command line parsing :-))
> 
> https://stackoverflow.com/questions/46955244/qemu-run-arm-ubuntu-unsupported-machine-type/47042282
> has a user who's run into a confusing error message, because
> we allow the user to pass "-machine type=foo" more than once on
> the command line. When we decide which one to use, we go with the
> last one on the list. However if it's not valid, when we print the
> "don't recognize that machine type" message, the name we use in
> the message is the *first* one on the list :-)
> 
> Maybe we should just not allow users to pass the argument
> more than once...?

I think we at least need that in some of our qtests - to override the
default "-M accel=qtest" with "-M accel=tcg". So if we disallow to use
the option more than once, we've got to find a different solution for
the qtests.

 Thomas
