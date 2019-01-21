Received: from eggs.gnu.org ([209.51.188.92]:38640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glev2-0007jA-F3
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glekZ-0004yE-9P
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:56:48 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:36323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glekY-0004tk-WD
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:56:47 -0500
Received: by mail-oi1-x235.google.com with SMTP id x23so15378340oix.3
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:56:25 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_ZdOsXbKE=ZcOGUNB4LAnL_wZK5rdm+PvsaeBfyT0DSg@mail.gmail.com>
	<20190111161515.GG2738@work-vm>
	<CAK3tnvKL9QofBfg2-Dk_nJErNc2GeDh7_M2r+J3r-izMi4kyAw@mail.gmail.com>
	<fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
In-Reply-To: <fcc36df4-5900-7c83-836c-14ca6e6d8f09@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:56:13 +0000
Message-ID: <CAFEAcA-ZrpiBu-Xm6dm6bcTkZ49zMBU3=spQ1UTgG61SNUj40w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] test-filter-mirror hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 17 Jan 2019 at 09:46, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2019/1/15 =E4=B8=8A=E5=8D=8812:33, Zhang Chen wrote:
> >
> >
> > On Sat, Jan 12, 2019 at 12:15 AM Dr. David Alan Gilbert
> > <dgilbert@redhat.com <mailto:dgilbert@redhat.com>> wrote:
> >
> >     * Peter Maydell (peter.maydell@linaro.org
> >     <mailto:peter.maydell@linaro.org>) wrote:
> >     > Recently I've noticed that test-filter-mirror has been hanging
> >     > intermittently, typically when run on some other TCG architecture=
.
> >     > In the instance I've just looked at, this was with s390x guest on
> >     > x86-64 host, though I've also seen it on other host archs and
> >     > perhaps with other guests.
> >
> >     Watch out to see if you really do see it for other guests;
> >     it carefully avoids using virtio-net to avoid vhost; but on s390x i=
t
> >     uses virtio-net-ccw - could that hit the vhost it was trying to avo=
id?
> >
> >     > Below is a backtrace, though it seems to be pretty unhelpful.
> >     > Anybody got any theories ? Does the mirror test rely on dirty
> >     > memory bitmaps like the migration test (which also hangs
> >     > occasionally with TCG due to some bug I'm sure we've investigated
> >     > in the past) ?
> >
> >     I don't think it relies on the CPU at all.

> >  I have no idea about this currently, but Jason and I designed the
> > test case.
> > Add Jason: Have any comments about this ?
>
>
> I can't reproduce this locally with s390x-softmmu. It looks to me the
> test should be independent to any kinds of emulation. It should pass
> when mainloop work.

I've just seen a hang with ppc64 guest on s390x host, so it is
indeed not specific to s390x guest (and so not specific to
virtio-net either, since the ppc64 guest setup uses e1000).

thanks
-- PMM
