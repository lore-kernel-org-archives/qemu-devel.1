Received: from eggs.gnu.org ([2001:4830:134:3::10]:49509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fSC4d-0004Nl-KQ
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fSC4a-0004lP-Jl
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:56:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fSC4a-0004jx-FO
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:56:44 -0400
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-15-zhangckid@gmail.com>
	<96b6dd17-bbb6-48e9-54c8-6495c8a56c98@redhat.com>
	<CAK3tnv+GkZGVEGeswayaO0esSCWonwwgm30FL3QriOSDscsuvA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6d894c72-0ddf-d915-98bb-b23803fb566f@redhat.com>
Date: Mon, 11 Jun 2018 09:56:37 +0800
MIME-Version: 1.0
In-Reply-To: <CAK3tnv+GkZGVEGeswayaO0esSCWonwwgm30FL3QriOSDscsuvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V8 14/17] filter: Add handle_event method
 for NetFilterClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



On 2018=E5=B9=B406=E6=9C=8810=E6=97=A5 22:09, Zhang Chen wrote:
>> I think when COLO is enabled, qemu should reject all other types of
>> backends.
> Yes, you are right.
> May be we should add a assert here? Because we can not get backend info=
 when
> colo-compare start up.
> Have any idea?
>
>

Is there a global variable or function to detect the COLO existence? If=20
yes, maybe we could use that.

Thanks
