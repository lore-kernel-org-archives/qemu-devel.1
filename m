Received: from eggs.gnu.org ([2001:4830:134:3::10]:51426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eFVPC-0002Yg-H3
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 20:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eFVP8-00086T-4M
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 20:25:18 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1199
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eFVP7-00084J-QI
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 20:25:14 -0500
References: <20171116022832.24894-1-maozy.fnst@cn.fujitsu.com>
	<b6ef2227-c462-ccec-9e37-d29a0cdace59@weilnetz.de>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <cb747164-d6e2-d7c9-6586-b3a13ef27bf2@cn.fujitsu.com>
Date: Fri, 17 Nov 2017 09:21:09 +0800
MIME-Version: 1.0
In-Reply-To: <b6ef2227-c462-ccec-9e37-d29a0cdace59@weilnetz.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] colo-compare: fix the dangerous assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>



On 11/17/2017 04:07 AM, Stefan Weil wrote:
> Am 16.11.2017 um 03:28 schrieb Mao Zhongyi:
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Zhang Chen <zhangckid@gmail.com>
>> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Fixes: 8ec14402029d783720f4312ed8a925548e1dad61
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>>  net/colo-compare.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index ccdcba2..1ce195f 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -179,7 +179,7 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
>>                           "drop packet");
>>          }
>>      }
>> -    con = &conn;
>> +    *con = conn;
>>
>>      return 0;
>>  }

Hi, Stefan

> The patch is definitely needed if the new function parameter con
> should work.
>
> It also fixes a gcc compiler warning:
> net/colo-compare.c:139:67: warning: parameter ‘con’ set but not used
> [-Wunused-but-set-parameter]
>
> I‌ think using -Wextra would be really good to catch such bugs earlier.

Thanks a bunch. I got it. :)

Mao
