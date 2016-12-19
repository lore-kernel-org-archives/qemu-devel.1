Received: from eggs.gnu.org ([2001:4830:134:3::10]:45179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cIq3e-0002iB-DQ
	for Qemu-devel@nongnu.org; Mon, 19 Dec 2016 00:00:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cIq3Z-0006Ge-VE
	for Qemu-devel@nongnu.org; Mon, 19 Dec 2016 00:00:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1cIq3Z-0006GG-LU
	for Qemu-devel@nongnu.org; Mon, 19 Dec 2016 00:00:13 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBJ4x66x040260
	for <Qemu-devel@nongnu.org>; Mon, 19 Dec 2016 00:00:12 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27dw84u8t6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <Qemu-devel@nongnu.org>; Mon, 19 Dec 2016 00:00:11 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <Qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Sun, 18 Dec 2016 22:00:11 -0700
References: <20161216054723.96055-1-haoqf@linux.vnet.ibm.com>
	<20161216054723.96055-2-haoqf@linux.vnet.ibm.com>
	<b70a8f66-81e9-6e3b-0245-2eab3ec27d0f@redhat.com>
From: Hao QingFeng <haoqf@linux.vnet.ibm.com>
Date: Mon, 19 Dec 2016 13:00:09 +0800
MIME-Version: 1.0
In-Reply-To: <b70a8f66-81e9-6e3b-0245-2eab3ec27d0f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b30264d5-9d80-dfdc-4178-47d5543c3592@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v1 1/1] iotests: Fix a problem
 in common.filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, qemu-trivial <qemu-trivial@nongnu.org>



=E5=9C=A8 2016-12-16 22:34, Eric Blake =E5=86=99=E9=81=93:
> [adding qemu-devel, ALL patches should include the main list]
>
> On 12/15/2016 11:47 PM, QingFeng Hao wrote:
>> If TEST_DIR is set to /tmp, test case 144 will fail. The reason is tha=
t
>> TEST_DIR duplicates with 144's test image name tmp.qcow2.
> s/duplicates with/resembles/
yes
>
>> when 144 is testing $TEST_DIR/tmp.qcow2, it wants to replace
>> $TEST_DIR/tmp.qcow2 to TEST_DIR/tmp.qcow2, but actually it will fail
>> and get TEST_DIRTEST_DIR.qcow2 in this case.
>> The fix is just to modify the code to replace $TEST_DIR/ with TEST_DIR=
/.
>>
>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>> ---
>>   tests/qemu-iotests/common.filter | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/com=
mon.filter
>> index 240ed06..d29e965 100644
>> --- a/tests/qemu-iotests/common.filter
>> +++ b/tests/qemu-iotests/common.filter
>> @@ -35,7 +35,7 @@ _filter_generated_node_ids()
>>   # replace occurrences of the actual TEST_DIR value with TEST_DIR
>>   _filter_testdir()
>>   {
>> -    sed -e "s#$TEST_DIR#TEST_DIR#g"
>> +    sed -e "s#$TEST_DIR\/#TEST_DIR\/#g"
> Why do you need \/?  It should be sufficient to use / without escaping.
>
> But overall I agree with including the / in the pattern.  It's too late
> to include this in 2.8, but with the commit message grammar improved an=
d
> \ escape removed, I'm fine with:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
Right! We can use / directly in this case. Thanks :-)
> I'm also adding qemu-trivial in cc, in case we want to take it through
> that tree instead of the usual qemu-iotests.
>

--=20
QingFeng Hao(Robin)
