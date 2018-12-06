Received: from eggs.gnu.org ([2001:4830:134:3::10]:40857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUoUN-0005aj-MF
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:54:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gUoUM-0008H1-Qz
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:54:27 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:37627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gUoUM-000864-J8
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:54:26 -0500
Received: by mail-yb1-xb41.google.com with SMTP id w129-v6so8860404ybe.4
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 23:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<20181206063552.6701-2-xieyongji@baidu.com>
	<CAJ+F1C+hedZC1EkvpScEP5aw3a-exvBauwyecfrM-LB_2rt=bw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+hedZC1EkvpScEP5aw3a-exvBauwyecfrM-LB_2rt=bw@mail.gmail.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Thu, 6 Dec 2018 15:53:57 +0800
Message-ID: <CAONzpcadpQvcibeRrxTDSLNZCr3DiFoFFGsPyNkn7e66ZJp8yQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 1/6] char-socket: Enable "wait"
 option for client mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, nixun@baidu.com, qemu-devel@nongnu.org, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Thu, 6 Dec 2018 at 15:23, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Thu, Dec 6, 2018 at 10:38 AM <elohimes@gmail.com> wrote:
> >
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > Now we attempt to connect asynchronously for "reconnect socket"
> > during open(). But vhost-user device prefer a connected socket
> > during initialization. That means we may still need to support
> > sync connection during open() for the "reconnect socket".
> >
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
>
> I am not sure this makes much sense, since upon reconnect it won't
> "wait" (if I am not mistaken)
>

Yes, qemu won't wait when reconnecting. The "wait" here just means that
we should wait connection at first time (during open()). I'm not sure wheth=
er
reuse the "wait" option is OK here.

If no this option, current qemu will fail to initialize vhost-user-blk
device when
"reconnect" option is specified no matter the backend is running or not.

Thanks,
Yongji
