Received: from eggs.gnu.org ([2001:4830:134:3::10]:39534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSwzz-0006jU-VL
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSwzw-0001Pj-Sm
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:03:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59340 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fSwzw-0001PX-Nz
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:03:04 -0400
Date: Wed, 13 Jun 2018 12:02:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180613040259.GI15344@xz-mi>
References: <20180612062430.GA15344@xz-mi>
	<CAFEAcA_Bh4U1X_FDbakcc7YDBHFrkCjCKGrtuTWegn7rAGZUeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Bh4U1X_FDbakcc7YDBHFrkCjCKGrtuTWegn7rAGZUeQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Is there a way to package QEMU binaries?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>

On Tue, Jun 12, 2018 at 09:52:45AM +0100, Peter Maydell wrote:
> On 12 June 2018 at 07:24, Peter Xu <peterx@redhat.com> wrote:
> > For example, I wanted to compile QEMU once and install it on multiple
> > systems.  What would be the suggested way to do so?
> 
> For this, I would recommend using whatever the packaging
> format for those systems is. Eg for Debian use the existing
> Debian QEMU packages, for Redhat systems use RPMs, etc.
> If you want a newer version of QEMU than is in the distro's
> packages, you can probably forward port the packaging parts
> to a newer QEMU without too much pain.
> 
> Or you can use a distro-agnostic packaging tool of some sort;
> there are a few out there but I have no particular recommendations.

I'll start my investigation with RPM first.  Thanks Peter.

-- 
Peter Xu
