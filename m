Received: from eggs.gnu.org ([2001:4830:134:3::10]:43512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fSYf7-0007Ue-Kv
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fSYf3-0003Dc-OK
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:03:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59518 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fSYf3-0003DC-JC
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 22:03:53 -0400
References: <20180611092305.2542-1-lma@suse.com>
	<5cac7e34-4f6f-99f1-a75f-7a2b57d3cb34@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <62828958-4df4-fc81-d1a3-1eb5a310d5af@redhat.com>
Date: Tue, 12 Jun 2018 10:03:47 +0800
MIME-Version: 1.0
In-Reply-To: <5cac7e34-4f6f-99f1-a75f-7a2b57d3cb34@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] net: Fix a potential segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Lin Ma <lma@suse.com>, qemu-devel@nongnu.org



On 2018=E5=B9=B406=E6=9C=8811=E6=97=A5 17:48, Thomas Huth wrote:
> On 11.06.2018 11:23, Lin Ma wrote:
>> If user forgets to provide any backend types for '-netdev' in qemu CLI=
,
>> It triggers seg fault.
>>
>> e.g.
>>
>> Expected:
>> $ qemu -netdev id=3Dnet0
>> qemu-system-x86_64: Parameter 'type' is missing
>>
>> Actual:
>> $ qemu -netdev id=3Dnet0
>> Segmentation fault (core dumped)
>>
>> Signed-off-by: Lin Ma <lma@suse.com>
>> ---
>>   net/net.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/net.c b/net/net.c
>> index efb9eaf779..2a3133990c 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -1093,7 +1093,9 @@ static int net_client_init(QemuOpts *opts, bool =
is_netdev, Error **errp)
>>       int ret =3D -1;
>>       Visitor *v =3D opts_visitor_new(opts);
>>  =20
>> -    if (is_netdev && is_help_option(qemu_opt_get(opts, "type"))) {
>> +    const char *type =3D qemu_opt_get(opts, "type");
>> +
>> +    if (is_netdev && type && is_help_option(type)) {
>>           show_netdevs();
>>           exit(0);
>>       } else {
>>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Applied, and queued for -stable.

Thanks
