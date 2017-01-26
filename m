Received: from eggs.gnu.org ([2001:4830:134:3::10]:59055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cWaSK-0008Rs-Sy
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 22:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cWaSG-0004K4-Sp
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 22:10:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cWaSG-0004Jq-Mr
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 22:10:32 -0500
References: <1483596532-14552-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<6a928d63-59c5-a763-0156-40e5958512c5@cn.fujitsu.com>
	<71bda662-8a14-01d4-9db6-ce96640dfee9@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <61ae330c-b431-fff3-dd58-ba24b081dc60@redhat.com>
Date: Thu, 26 Jan 2017 11:10:25 +0800
MIME-Version: 1.0
In-Reply-To: <71bda662-8a14-01d4-9db6-ce96640dfee9@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V6 0/2] Add new qmp commands to suppurt Xen
 COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>
Cc: "eddie . dong" <eddie.dong@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Bian Naimeng <biannm@cn.fujitsu.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



On 2017=E5=B9=B401=E6=9C=8826=E6=97=A5 11:04, Zhang Chen wrote:
> Hi~
>
> No news for a week.
>
> We need comments ~~
>
> Ping...
>

Cc David who is one of the maintainer of migration.


>
> Thanks
>
> Zhang Chen
>
>
> On 01/19/2017 05:57 PM, Zhang Chen wrote:
>> Hi~~
>>
>> Anyone have any comments?
>>
>> Ping....
>>
>>
>> Thanks
>>
>> Zhang Chen
>>
>>
>> On 01/05/2017 02:08 PM, Zhang Chen wrote:
>>> Xen COLO depend on qemu COLO replication function.
>>> So, We need new qmp commands for Xen to use qemu replication.
>>>
>>> Corresponding libxl patches already in xen.git.
>>> Commit ID:
>>>
>>> ed37ef1f91c20f0ab162ce60f8c38400b917fa64
>>> COLO: introduce new API to prepare/start/do/get_error/stop replicatio=
n
>>>
>>> a0ddc0b359375b2418213966dfbdbfab593ecc6f
>>> tools/libxl: introduction of libxl__qmp_restore to load qemu state
>>>
>>>
>>> Zhang Chen (2):
>>>    Add a new qmp command to start/stop replication
>>>    Add a new qmp command to do checkpoint, query xen replication stat=
us
>>>
>>>   docs/qmp-commands.txt | 42 +++++++++++++++++++++++++++++++
>>>   migration/colo.c      | 40 +++++++++++++++++++++++++++++
>>>   qapi-schema.json      | 69=20
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 151 insertions(+)
>>>
>>
>
