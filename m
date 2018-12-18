Received: from eggs.gnu.org ([2001:4830:134:3::10]:54059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZGoA-0008Oo-Aj
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZGo4-00039y-Gv
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:57:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZGo4-00039a-9U
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:57:12 -0500
Date: Tue, 18 Dec 2018 09:57:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218095456-mutt-send-email-mst@kernel.org>
References: <20181218100002.11219-1-xieyongji@baidu.com>
	<20181218100002.11219-3-xieyongji@baidu.com>
	<20181218092449-mutt-send-email-mst@kernel.org>
	<CAONzpcYG9mYMMXAQWp-3cUmtvBQaOEekZQqByCDUoDmcmEKG6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONzpcYG9mYMMXAQWp-3cUmtvBQaOEekZQqByCDUoDmcmEKG6w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0 2/7] vhost-user: Support
 providing shared memory to backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <elohimes@gmail.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Jason Wang <jasowang@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Tue, Dec 18, 2018 at 10:47:32PM +0800, Yongji Xie wrote:
> On Tue, 18 Dec 2018 at 22:25, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Dec 18, 2018 at 05:59:57PM +0800, elohimes@gmail.com wrote:
> > > From: Xie Yongji <xieyongji@baidu.com>
> > >
> > > This patch introduces two new messages VHOST_USER_GET_SHM_SIZE
> > > and VHOST_USER_SET_SHM_FD to support providing shared
> > > memory to backend.
> > >
> > > Firstly, qemu uses VHOST_USER_GET_SHM_SIZE to get the
> > > required size of shared memory from backend. Then, qemu
> > > allocates memory and sends them back to backend through
> > > VHOST_USER_SET_SHM_FD.
> > >
> > > Note that the shared memory should be used to record
> > > inflight I/O by backend. Qemu will clear it when vm reset.
> >
> > An interesting design choice. Why not let the backend clear it
> > on start?
> >
> 
> The backend might restart when it has some inflight I/Os. In this case,
> it should not clear the memory on start, right?
> 
> Thanks,
> Yongji

I see. So this allows backend to detect a non-initialized buffer
by checking e.g. a version is 0? Clever.

-- 
MST
