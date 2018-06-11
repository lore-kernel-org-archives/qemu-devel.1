Received: from eggs.gnu.org ([2001:4830:134:3::10]:41217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fSGb7-0003jK-9T
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fSGb6-0000cl-Ep
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:46:37 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:56264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fSGb6-0000bi-7D
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:46:36 -0400
Received: by mail-wm0-x22f.google.com with SMTP id v16-v6so12616258wmh.5
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 23:46:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6d894c72-0ddf-d915-98bb-b23803fb566f@redhat.com>
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-15-zhangckid@gmail.com>
	<96b6dd17-bbb6-48e9-54c8-6495c8a56c98@redhat.com>
	<CAK3tnv+GkZGVEGeswayaO0esSCWonwwgm30FL3QriOSDscsuvA@mail.gmail.com>
	<6d894c72-0ddf-d915-98bb-b23803fb566f@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 11 Jun 2018 14:46:34 +0800
Message-ID: <CAK3tnvKX-QkNRv=pbZenDnBaEdnXvVZfPa3oYVQf6rMd3pKKhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Jason Wang <jasowang@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jun 11, 2018 at 9:56 AM, Jason Wang <jasowang@redhat.com> wrote:

>
>
> On 2018=E5=B9=B406=E6=9C=8810=E6=97=A5 22:09, Zhang Chen wrote:
>
>> I think when COLO is enabled, qemu should reject all other types of
>>> backends.
>>>
>> Yes, you are right.
>> May be we should add a assert here? Because we can not get backend info
>> when
>> colo-compare start up.
>> Have any idea?
>>
>>
>>
> Is there a global variable or function to detect the COLO existence? If
> yes, maybe we could use that.
>

May be we can reuse the "qmp_query_colo_status" in 11/17 patch.
I will add this check in next version.


Thanks
Zhang Chen


>
> Thanks
>
>
