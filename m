Received: from eggs.gnu.org ([2001:4830:134:3::10]:50773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1g0cTG-0001Lv-Fm
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 21:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1g0cTF-0005lS-B1
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 21:00:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1g0cTF-0005kS-1q
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 21:00:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id s14-v6so8598824wrw.6
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 18:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <1536814370-12997-1-git-send-email-zhangckid@gmail.com>
	<ad44caaa-c588-f730-2c6b-dc6896a1cea5@redhat.com>
In-Reply-To: <ad44caaa-c588-f730-2c6b-dc6896a1cea5@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 14 Sep 2018 08:58:48 +0800
Message-ID: <CAK3tnvJ3Pv9pGneHNd6zyMcBUnhvBEVvXL6k3kh1Bw_+A9pT5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V12-fix 01/19] filter-rewriter: Add TCP
 state machine and fix memory leak in connection_track_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, jasowang@redhat.com, Markus Armbruster <armbru@redhat.com>, zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com, Zhang Chen <chen.zhang@intel.com>

On Thu, Sep 13, 2018 at 10:49 PM Eric Blake <eblake@redhat.com> wrote:

> On 9/12/18 11:52 PM, Zhang Chen wrote:
> > We add almost full TCP state machine in filter-rewriter, except
> > TCPS_LISTEN and some simplify in VM active close FIN states.
> > The reason for this simplify job is because guest kernel will track
> > the TCP status and wait 2MSL time too, if client resend the FIN packet,
> > guest will resend the last ACK, so we needn't wait 2MSL time in
> filter-rewriter.
> >
> > After a net connection is closed, we didn't clear its releated resources
>
> s/releated/related/
>

OK.


>
> > in connection_track_table, which will lead to memory leak.
> >
> > Let't track the state of net connection, if it is closed, its related
>
> s/Let't/Let's/
>
>
OK.


> > resources will be cleared up.
> >
> > Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
>
> Should both of these last two S-o-b be present?
>
>

Maybe it will be more convenient to contact me, I use both of the email. :)

Thanks
Zhang Chen


> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
