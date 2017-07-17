Received: from eggs.gnu.org ([2001:4830:134:3::10]:50742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dX2VM-0000ET-K0
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dX2VI-0001LU-La
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:39:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dX2VI-0001LD-FL
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 05:39:48 -0400
Date: Mon, 17 Jul 2017 17:39:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170717093944.GA18516@lemon>
References: <20170717063521.GA7393@lemon>
	<20170717090531.GA7163@stefanha-x1.localdomain>
	<CAFEAcA8kt71pbxggfLdP3-WCc8u8v5iijZBksMSq6Yss2ydgiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8kt71pbxggfLdP3-WCc8u8v5iijZBksMSq6Yss2ydgiw@mail.gmail.com>
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 07/17 10:28, Peter Maydell wrote:
> On 17 July 2017 at 10:05, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > On Mon, Jul 17, 2017 at 02:35:21PM +0800, Fam Zheng wrote:
> >> Q1: In the worst case, you get four individual auto replies from patchew. Is
> >> that too many? Do you prefer one reply with all the results concatenated into
> >> one?
> >
> > I'd like to avoid situations where one of the failure emails is sent
> > hours after the others, because it's possible that the patch series
> > author has already sent the next (still broken) revision by that time.
> > The simplest way to avoid that is by sending just one email.
> >
> >> Q2: Some think the full log in the mail body is more than necessary. Is it
> >> better or worse if it is a "tail -n 200" of the log in the body and the full log
> >> attached?
> >
> > tail output and a link to the full logs would be nice.  Often there is a
> > lot of irrelevant output.
> 
> Ideally we'd streamline our make process to not produce so much
> irrelevant output :-)

Does that mean to make "quite-command" absolutely quiet if V=1 is not specified?
;-)

Fam
