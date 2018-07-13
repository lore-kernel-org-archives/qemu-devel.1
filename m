Received: from eggs.gnu.org ([2001:4830:134:3::10]:50054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fe1X5-0008Vp-PA
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 13:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fe1X5-0005ue-0T
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 13:07:03 -0400
References: <20180712221208.3732-1-jsnow@redhat.com>
	<20180713070920.GA3896@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <f36cc619-5cf4-75da-454f-3d495455c2c9@redhat.com>
Date: Fri, 13 Jul 2018 13:06:54 -0400
MIME-Version: 1.0
In-Reply-To: <20180713070920.GA3896@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: remove LUKS support from test 226
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/13/2018 03:09 AM, Kevin Wolf wrote:
> Am 13.07.2018 um 00:12 hat John Snow geschrieben:
>> This test doesn't actually care about the format anyway, it just
>> supports "all formats" as a convenience. LUKS however does not use a
>> simple image filename which confuses this iotest.
>>
>> We can simply remove the LUKS "support" and be happier for it.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  tests/qemu-iotests/226 | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/226 b/tests/qemu-iotests/226
>> index 460aea2fc9..ebfaf62e53 100755
>> --- a/tests/qemu-iotests/226
>> +++ b/tests/qemu-iotests/226
>> @@ -40,7 +40,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  . ./common.pattern
>>  
>>  # Generic format, but tests file-protocol specific error handling
>> +# LUKS does not use a simple filename; this test doesn't use the format anyway.
>>  _supported_fmt generic
>> +_unsupported_fmt luks
>>  _supported_proto file
>>  _supported_os Linux
> 
> Maybe it would be better to test for $IMGOPTSSYNTAX = "true", because
> that's the real problem here?
> 
> Kevin
> 

Oh, OK. I didn't know about that var.
