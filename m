Received: from eggs.gnu.org ([2001:4830:134:3::10]:35122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZHCy-0004Gy-OC
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZH1b-0005wT-FL
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:11:12 -0500
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:35807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gZH1b-0005qK-8q
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:11:11 -0500
Received: by mail-yb1-xb42.google.com with SMTP id z2-v6so6600465ybj.2
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 07:11:10 -0800 (PST)
MIME-Version: 1.0
References: <20181218100002.11219-1-xieyongji@baidu.com>
	<20181218100002.11219-3-xieyongji@baidu.com>
	<20181218092449-mutt-send-email-mst@kernel.org>
	<CAONzpcYG9mYMMXAQWp-3cUmtvBQaOEekZQqByCDUoDmcmEKG6w@mail.gmail.com>
	<20181218095456-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181218095456-mutt-send-email-mst@kernel.org>
From: Yongji Xie <elohimes@gmail.com>
Date: Tue, 18 Dec 2018 23:10:58 +0800
Message-ID: <CAONzpcbc_qkOoVu=sX67GP+qttzzMvbgPyQviTmQ46r+_PDQcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Jason Wang <jasowang@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Tue, 18 Dec 2018 at 22:57, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Dec 18, 2018 at 10:47:32PM +0800, Yongji Xie wrote:
> > On Tue, 18 Dec 2018 at 22:25, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Dec 18, 2018 at 05:59:57PM +0800, elohimes@gmail.com wrote:
> > > > From: Xie Yongji <xieyongji@baidu.com>
> > > >
> > > > This patch introduces two new messages VHOST_USER_GET_SHM_SIZE
> > > > and VHOST_USER_SET_SHM_FD to support providing shared
> > > > memory to backend.
> > > >
> > > > Firstly, qemu uses VHOST_USER_GET_SHM_SIZE to get the
> > > > required size of shared memory from backend. Then, qemu
> > > > allocates memory and sends them back to backend through
> > > > VHOST_USER_SET_SHM_FD.
> > > >
> > > > Note that the shared memory should be used to record
> > > > inflight I/O by backend. Qemu will clear it when vm reset.
> > >
> > > An interesting design choice. Why not let the backend clear it
> > > on start?
> > >
> >
> > The backend might restart when it has some inflight I/Os. In this case,
> > it should not clear the memory on start, right?
> >
> > Thanks,
> > Yongji
>
> I see. So this allows backend to detect a non-initialized buffer
> by checking e.g. a version is 0? Clever.
>

If the version is a variable in the buffer, yes, we can detect whether
the buffer is initialized or not by checking it.

Thanks,
Yongji
