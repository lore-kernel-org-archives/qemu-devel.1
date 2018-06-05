Received: from eggs.gnu.org ([2001:4830:134:3::10]:38271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQ8gV-0002IS-Ls
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fQ8gR-0005ZX-MH
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:55:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fQ8gR-0005Wn-FM
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 05:55:19 -0400
Date: Tue, 5 Jun 2018 11:55:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180605115514.65af4c41.cohuck@redhat.com>
In-Reply-To: <CAFEAcA80XzxdxLfwMUYLpHprX8L=AZyNDw1DiJKshhGvbFJLRA@mail.gmail.com>
References: <20180604162140.20688-1-peter.maydell@linaro.org>
	<20180604191756.1ae61871@w520.home>
	<52a5446f-4624-fd45-ce7d-492269aa5c3f@redhat.com>
	<20180605094613.52bcf85d.cohuck@redhat.com>
	<CAFEAcA80XzxdxLfwMUYLpHprX8L=AZyNDw1DiJKshhGvbFJLRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] CODING_STYLE: Define our preferred form
 for multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 5 Jun 2018 10:19:15 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 5 June 2018 at 08:46, Cornelia Huck <cohuck@redhat.com> wrote:
> > On Tue, 5 Jun 2018 06:33:22 +0200
> > Thomas Huth <thuth@redhat.com> wrote:  

> >> Anyway, could we either use that dense format or the kernel-style
> >> multi-lines-comment format, please? Mixing it asymmetrically is just ugly.  
> >
> > I'd vote for the kernel style, then.  
> 
> I don't particularly object to the kernel style (though it's not
> how I personally default to writing comments). I just didn't want
> to rule a huge chunk of our existing comments as out-of-standard
> for what I see as a relatively minor divergence in form --
> we do have a lot of no-leading-separate-/* comments. I can live
> with mandating kernel-style if it means we can rule out GNU-form
> and other weirdnesses though :-)

Yes, we should be flexible... as long as it isn't GNU :)

Whatever we end up with, we should take care that we don't get zillions
of "cleanup" patches that don't add value... something like "no need to
change preexisting comments, unless you're touching the code anyway".
