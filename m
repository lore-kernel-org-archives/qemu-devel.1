Received: from eggs.gnu.org ([2001:4830:134:3::10]:45923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD5cb-0007Cw-5q
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD5ca-00070b-Ey
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:01:25 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:37520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fD5ca-00070C-8t
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:01:24 -0400
Received: by mail-oi0-x22a.google.com with SMTP id f63-v6so6942174oic.4
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 03:01:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180430112906.20101672.cohuck@redhat.com>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430112906.20101672.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 11:01:03 +0100
Message-ID: <CAFEAcA8=5h=A3hyrUk8LQ8RzAJ+vgG8uwBYHtmOV8mueJumrqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 30 April 2018 at 10:29, Cornelia Huck <cohuck@redhat.com> wrote:
> On a related note: During the development phase, does it make more
> sense to collect stuff until you have a big pile of patches, or is it
> better (from an integration perspective) to do more frequent, smaller
> pull requests?

Generally my preference is for more smaller requests:
 * it means that patches from contributors get into master faster
 * the bigger the pull request the more likely that something in it
   will fail a build test and result in a delay for the whole lot

My rule of thumb for target-arm pull requests is to send one
if my queue gets up to 10 or so patches or if it's been two weeks
since the last one, I think. (I'm not saying 2 weeks is a limit
on how often to send -- it's just about where my personal
tradeoff between how long I hold onto things and how frequently
I want to do the test-and-send-pullreq work is set.)

thanks
-- PMM
