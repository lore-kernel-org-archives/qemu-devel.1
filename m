Received: from eggs.gnu.org ([2001:4830:134:3::10]:44638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePnXl-0005x4-6c
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:48:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePnXg-0004lp-GJ
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 05:48:41 -0500
Date: Fri, 15 Dec 2017 11:48:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171215114828.1de9a0c3.cohuck@redhat.com>
In-Reply-To: <CAFEAcA_+XYYGzTgJicvXr47YvnTiT=v-4QKDJUEvgB9Yj4D_uw@mail.gmail.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
	<CAFEAcA8tY9=jtsw-MtjWTceLizvpH8oui_+6xf7V6K5o5BLf-A@mail.gmail.com>
	<cf44ca76-d581-8d96-3e2b-78c698dda446@de.ibm.com>
	<20171215101135.447d9316.cohuck@redhat.com>
	<CAFEAcA_VaKua1qjyeX2Ve=JrSUJQbBqMQOJQZ7e3y92+gtxkMA@mail.gmail.com>
	<20171215112138.6040ee82.cohuck@redhat.com>
	<CAFEAcA_+XYYGzTgJicvXr47YvnTiT=v-4QKDJUEvgB9Yj4D_uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL 00/46] First batch of s390x
 patches for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On Fri, 15 Dec 2017 10:33:28 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 15 December 2017 at 10:21, Cornelia Huck <cohuck@redhat.com> wrote:
> > On Fri, 15 Dec 2017 09:51:32 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  
> >> On 15 December 2017 at 09:11, Cornelia Huck <cohuck@redhat.com> wrote:  
> >> > On Fri, 15 Dec 2017 09:35:10 +0100
> >> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >> >  
> >> >> On 12/14/2017 08:05 PM, Peter Maydell wrote:  
> >> >> > (ram_addr_t can be a 32-bit type).  
> >> >
> >> > This a 32 bit host, isn't it? I don't have regular access to one...  
> >>
> >> Yes. Win32 cross compiler also gives this error.  
> >
> > Hm, my mingw build on Fedora did not catch this. Setting up a 32bit vm.  
> 
> Maybe your mingw build is mingw-w64 rather than -w32 ?

It's mingw32-w64 so it seems it's actually w64. Confusing naming.

Anyway, I now have a 32 bit build machine, and the uint64_t cast seems
to work. I'll send an updated pull request (OK if I don't send the
other 45 patches again?)
