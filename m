Received: from eggs.gnu.org ([2001:4830:134:3::10]:46339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cPal2-0007i0-IK
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 15:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cPaky-0002Hq-OQ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 15:05:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cPaky-0002Hh-JF
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 15:04:56 -0500
Date: Fri, 6 Jan 2017 22:04:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170106215615-mutt-send-email-mst@kernel.org>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
	<148192392306.37.10111381964118487672@790289a7ca88>
	<CAFEAcA97bb-LBoPVvm_wqS6GVyYoFhwR6qBRJDPVRLG8sOGqsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA97bb-LBoPVvm_wqS6GVyYoFhwR6qBRJDPVRLG8sOGqsA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL for-2.9 0/9] virtio, vhost, pc: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, mlureau@redhat.com

On Sat, Dec 17, 2016 at 11:18:03AM +0000, Peter Maydell wrote:
> On 16 December 2016 at 21:32,  <no-reply@patchew.org> wrote:
> > Your series seems to have some coding style problems. See output below for
> > more information:
> >
> > Type: series
> > Subject: [Qemu-devel] [PULL for-2.9 0/9] virtio, vhost, pc: fixes
> > Message-id: 1481922841-4324-1-git-send-email-mst@redhat.com
> 
> > Checking PATCH 5/9: contrib: add libvhost-user...
> > ERROR: Invalid UTF-8, patch and commit message should be encoded in UTF-8
> > #75: FILE: contrib/libvhost-user/libvhost-user.c:9:
> > + *  Marc-Andr Lureau <mlureau@redhat.com>
> >               ^
> >
> > ERROR: Invalid UTF-8, patch and commit message should be encoded in UTF-8
> > #1579: FILE: contrib/libvhost-user/libvhost-user.h:8:
> > + *  Marc-Andr Lureau <mlureau@redhat.com>
> >               ^
> >
> > total: 2 errors, 0 warnings, 1950 lines checked
> 
> Michael, could you check the encoding in that file and respin
> the patchset if necessary, please?
> 
> thanks
> -- PMM

I have no idea what this means.

00000000: 202a 2020 4d61 7263 2d41 6e64 72c3 a920   *  Marc-Andr.. 
00000010: 4c75 7265 6175 203c 6d6c 7572 6561 7540  Lureau <mlureau@
00000020: 7265 6468 6174 2e63 6f6d 3e0a            redhat.com>.

So c3 a9, seems to be right:
https://mothereff.in/utf-8#%C3%A9

Any idea?
-- 
MST
