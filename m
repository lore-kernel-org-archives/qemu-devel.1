Received: from eggs.gnu.org ([2001:4830:134:3::10]:41458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgmYF-000534-Bi
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:06:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgmYC-0002WU-7Z
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:06:51 -0500
Received: from [59.151.112.132] (port=10187 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cgmYB-0002WJ-RM
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 01:06:48 -0500
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<8760k3zteg.fsf@dusky.pond.sub.org>
	<3f2d885b-f4c3-e26c-348b-b3996ad5410e@cn.fujitsu.com>
	<87fuj7r61e.fsf@dusky.pond.sub.org>
	<f72d07f6-e00d-8a9c-0e15-e2bab5b83ee2@redhat.com>
	<868d3cc4-8788-8731-ea7a-4e1336863f45@cn.fujitsu.com>
	<739b5892-fb96-0dfa-802d-51bd7ddea2e9@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <b5f333e6-c29d-4e16-aa0e-3bef1a031294@cn.fujitsu.com>
Date: Thu, 23 Feb 2017 14:06:12 +0800
MIME-Version: 1.0
In-Reply-To: <739b5892-fb96-0dfa-802d-51bd7ddea2e9@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V7 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: zhangchen.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, qemu devel <qemu-devel@nongnu.org>, Wen Congyang <wencongyang@gmail.com>, bian naimeng <biannm@cn.fujitsu.com>



On 02/22/2017 11:23 PM, Eric Blake wrote:
> On 02/22/2017 01:54 AM, Zhang Chen wrote:
>
>>> if (err) {
>>>     result->status = REPLICATION_STATUS_ERROR;
>>>     result->has_desc = true;
>>>     result->desc = ...extract string from err
>>> } else {
>>>     result->status = REPLICATION_STATUS_NORMAL;
>>> }
>>>
>>> by modifying the JSON [1]
>> I got your point, but I don't understand this:
>>
>> result->desc = ...extract string from err
>>
>> Where we can get the string from err?
>> Can you give me a example?
> See qmp_query_migrate (migration/migration.c) for similar code that
> populates an optional description member when an error is present:
>
>      case MIGRATION_STATUS_FAILED:
>          info->has_status = true;
>          if (s->error) {
>              info->has_error_desc = true;
>              info->error_desc = g_strdup(error_get_pretty(s->error));
>          }
>          break;

I will fix it in next version.

Thanks
Zhang Chen

>

-- 
Thanks
Zhang Chen
