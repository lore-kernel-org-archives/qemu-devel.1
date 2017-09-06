Received: from eggs.gnu.org ([2001:4830:134:3::10]:47591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpapU-0002cn-7w
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpapO-0005Ov-53
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:57:20 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dpapN-0005Nm-Ul
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 09:57:14 -0400
Received: by mail-wm0-x242.google.com with SMTP id e64so5400052wmi.2
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 06:57:12 -0700 (PDT)
Date: Wed, 6 Sep 2017 14:57:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170906135708.GD15535@stefanha-x1.localdomain>
References: <20170905035457.3753-1-Sergio.G.DelReal@gmail.com>
	<20170905035457.3753-9-Sergio.G.DelReal@gmail.com>
	<CAMzKsXu29K+b=fGuPLti5if6zj5=pQhpmQz1iei6-hgjbq_41Q@mail.gmail.com>
	<CAMzKsXu0LOR=mzBNq-=sbv3YRBCjKXxx2NjeJya-TPkK6mYT2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMzKsXu0LOR=mzBNq-=sbv3YRBCjKXxx2NjeJya-TPkK6mYT2Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/14] hvf: add compilation rules to
 Makefile.objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio =?iso-8859-1?Q?Andr=E9s_G=F3mez?= del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Sep 05, 2017 at 08:12:31PM -0500, Sergio Andrés Gómez del Real wrote:
> Stefan, is this acceptable? I mean delaying the compiling; up until patch 7
> no hvf code is compiled. Or should I just squash everything from patch 2 to
> 7?

It's okay.  Feel free to delay until patch 7 for now.

There is value in importing code verbatim and making changes in separate
patches.  That way it's easy to diff the code against the upstream
source to verify that it was imported correctly.

Stefan
