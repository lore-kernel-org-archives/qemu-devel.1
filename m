Received: from eggs.gnu.org ([2001:4830:134:3::10]:34357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fsm4F-0004Up-Kl
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fsm4E-0004Uo-Ld
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:38:15 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:33327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fsm4E-0004TR-DK
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:38:14 -0400
Received: by mail-wm0-x22a.google.com with SMTP id i134-v6so1618607wmf.0
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 02:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180811205924.4113-1-zhangckid@gmail.com>
	<20180811205924.4113-16-zhangckid@gmail.com>
	<f5b85e98-29ed-86e0-4497-7a63b61a663b@redhat.com>
	<CAK3tnv+CPvV5F09PWx5B2bQp6xYNmyJ--x_qy4mS7XZ6K1=W_Q@mail.gmail.com>
	<f19bc830-61e5-6136-980e-d8f64b7786af@redhat.com>
In-Reply-To: <f19bc830-61e5-6136-980e-d8f64b7786af@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Thu, 23 Aug 2018 17:37:59 +0800
Message-ID: <CAK3tnv+4gxxpv=pmFD-wLrvTAq9oOcaHRTBYtF8BqRHY-5T6OQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V11 15/20] net/net.c: Add net client type
 check function for COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com, Zhang Chen <chen.zhang@intel.com>

On Wed, Aug 22, 2018 at 4:22 PM Jason Wang <jasowang@redhat.com> wrote:

>
>
> On 2018=E5=B9=B408=E6=9C=8821=E6=97=A5 17:26, Zhang Chen wrote:
> >
> >
> > On Tue, Aug 21, 2018 at 11:27 AM Jason Wang <jasowang@redhat.com
> > <mailto:jasowang@redhat.com>> wrote:
> >
> >
> >
> >     On 2018=E5=B9=B408=E6=9C=8812=E6=97=A5 04:59, Zhang Chen wrote:
> >     > From: Zhang Chen <chen.zhang@intel.com
> >     <mailto:chen.zhang@intel.com>>
> >     >
> >     > We add is_colo_support_client_type() to check the net client
> >     type for
> >     > COLO-compare. Currently we just support TAP.
> >     > Suggested by Jason.
> >     >
> >     > Signed-off-by: Zhang Chen <zhangckid@gmail.com
> >     <mailto:zhangckid@gmail.com>>
> >     > Signed-off-by: Zhang Chen <chen.zhang@intel.com
> >     <mailto:chen.zhang@intel.com>>
> >     > ---
> >
> >     This needs more works:
> >
> >     - Forbid vhost
> >     - Deal with hotplug
> >
> >     Looks not a must for this series, so to speed up the process, you
> >     may do
> >     it on top.
> >
> >
> > Do you mean this patch we can stay this status currently?
> >
> > Thanks
> > Zhang Chen
>
> Sorry for being unclear, I mean we need a complete solution rather than
> partial one.
>

OK, I will remove this patch from this series, and send a complete solution
in the future.

Thanks
Zhang Chen


>
> Thanks
>
>
