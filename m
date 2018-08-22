Received: from eggs.gnu.org ([2001:4830:134:3::10]:40706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fsOPw-0002v5-8C
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fsOPr-0008HG-8K
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:23:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fsOPq-0008Fc-8q
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:22:58 -0400
References: <20180811205924.4113-1-zhangckid@gmail.com>
	<20180811205924.4113-16-zhangckid@gmail.com>
	<f5b85e98-29ed-86e0-4497-7a63b61a663b@redhat.com>
	<CAK3tnv+CPvV5F09PWx5B2bQp6xYNmyJ--x_qy4mS7XZ6K1=W_Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f19bc830-61e5-6136-980e-d8f64b7786af@redhat.com>
Date: Wed, 22 Aug 2018 16:22:50 +0800
MIME-Version: 1.0
In-Reply-To: <CAK3tnv+CPvV5F09PWx5B2bQp6xYNmyJ--x_qy4mS7XZ6K1=W_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com, Zhang Chen <chen.zhang@intel.com>



On 2018=E5=B9=B408=E6=9C=8821=E6=97=A5 17:26, Zhang Chen wrote:
>
>
> On Tue, Aug 21, 2018 at 11:27 AM Jason Wang <jasowang@redhat.com=20
> <mailto:jasowang@redhat.com>> wrote:
>
>
>
>     On 2018=E5=B9=B408=E6=9C=8812=E6=97=A5 04:59, Zhang Chen wrote:
>     > From: Zhang Chen <chen.zhang@intel.com
>     <mailto:chen.zhang@intel.com>>
>     >
>     > We add is_colo_support_client_type() to check the net client
>     type for
>     > COLO-compare. Currently we just support TAP.
>     > Suggested by Jason.
>     >
>     > Signed-off-by: Zhang Chen <zhangckid@gmail.com
>     <mailto:zhangckid@gmail.com>>
>     > Signed-off-by: Zhang Chen <chen.zhang@intel.com
>     <mailto:chen.zhang@intel.com>>
>     > ---
>
>     This needs more works:
>
>     - Forbid vhost
>     - Deal with hotplug
>
>     Looks not a must for this series, so to speed up the process, you
>     may do
>     it on top.
>
>
> Do you mean this patch we can stay this status currently?
>
> Thanks
> Zhang Chen

Sorry for being unclear, I mean we need a complete solution rather than=20
partial one.

Thanks
