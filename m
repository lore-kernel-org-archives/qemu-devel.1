Received: from eggs.gnu.org ([209.51.188.92]:38035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggXU5-0004h6-Al
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggXU4-0000zm-I9
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 11:10:37 -0500
Date: Mon, 7 Jan 2019 17:10:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190107171029.35418046.cohuck@redhat.com>
In-Reply-To: <CAFEAcA8pRzsVbnWDnLqhOeiJ9Ytw--8Cv9qHycr-pYHnaFs_2g@mail.gmail.com>
References: <20190103151612.51399-1-liq3ea@163.com>
	<20190104151005.42b6f111.cohuck@redhat.com>
	<5C2F6ED2.33D0D1.16460@m12-13.163.com>
	<20190107164801.32e9d6dc.cohuck@redhat.com>
	<CAFEAcA_BzQaZM01_q29q+RfnqF2_YDSM0zfqKYDFwzRQOq7now@mail.gmail.com>
	<20190107165748.442cc0c1.cohuck@redhat.com>
	<CAFEAcA8pRzsVbnWDnLqhOeiJ9Ytw--8Cv9qHycr-pYHnaFs_2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390: avoid potential null dereference
 ins390_pcihost_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Li Qiang <liq3ea@163.com>, "walling@linux.ibm.com" <walling@linux.ibm.com>, "rth@twiddle.net" <rth@twiddle.net>, "david@redhat.com" <david@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Mon, 7 Jan 2019 16:04:35 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 7 Jan 2019 at 15:57, Cornelia Huck <cohuck@redhat.com> wrote:
> > On Mon, 7 Jan 2019 15:54:21 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:  
> > > On Mon, 7 Jan 2019 at 15:48, Cornelia Huck <cohuck@redhat.com> wrote:  
> > > > Sounds good. But please return anyway in the unplug case, so that the
> > > > code is fine if asserts have been configured out.  
> > >
> > > Hopefully that won't cause the compiler to complain about
> > > unreachable code :-)  
> >
> > BTW: Is there a common configuration where asserts are configured out?
> > Not that this is an accident waiting to happen...  
> 
> No -- we insist they are always enabled, and osdep.h will #error
> out if either NDEBUG or G_DISABLE_ASSERT are set.

Ah, now I remember (I thought we still had that problem.)

In that case, no return is needed.
