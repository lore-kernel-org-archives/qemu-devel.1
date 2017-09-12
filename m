Received: from eggs.gnu.org ([2001:4830:134:3::10]:49032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1droBX-0004t5-9f
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1droBW-0006B5-BY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:37:15 -0400
References: <20170912144459.11359-1-pbonzini@redhat.com>
	<20170912144459.11359-3-pbonzini@redhat.com>
	<1a8dff3e-1519-e092-4619-934a584ee12a@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df6cffe6-7f1f-5362-5010-2255afc53b34@redhat.com>
Date: Tue, 12 Sep 2017 18:36:54 +0200
MIME-Version: 1.0
In-Reply-To: <1a8dff3e-1519-e092-4619-934a584ee12a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/10] qemu-iotests: get rid of AWK_PROG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org

On 12/09/2017 18:30, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Paolo,
>=20
> Hmm did you just resend your v1? Except the cover the patches don't hav=
e
> "v2" and I remember reviewing this one (also Eric Blake replied with hi=
s
> R-b).

I didn't include the R-bs, sorry (most of the later patches had
non-trivial context changes, this one is the exception).

But it's definitely v2, because v1 had 12 patches. :)

Paolo


> On 09/12/2017 11:44 AM, Paolo Bonzini wrote:
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   tests/qemu-iotests/check         | 4 ++--
>>   tests/qemu-iotests/common        | 2 +-
>>   tests/qemu-iotests/common.config | 3 ---
>>   3 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>> index 4a6ed67b42..5c0d0c51dc 100755
>> --- a/tests/qemu-iotests/check
>> +++ b/tests/qemu-iotests/check
>> @@ -128,7 +128,7 @@ tmp=3D"${TEST_DIR}"/$$
>>     _wallclock()
>>   {
>> -    date "+%H %M %S" | $AWK_PROG '{ print $1*3600 + $2*60 + $3 }'
>> +    date "+%H %M %S" | awk '{ print $1*3600 + $2*60 + $3 }'
>>   }
>>     _timestamp()
>> @@ -147,7 +147,7 @@ _wrapup()
>>           if [ -f $TIMESTAMP_FILE -a -f $tmp.time ]
>>           then
>>               cat $TIMESTAMP_FILE $tmp.time \
>> -            | $AWK_PROG '
>> +            | awk '
>>           { t[$1] =3D $2 }
>>   END        { if (NR > 0) {
>>               for (i in t) print i " " t[i]
>> diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
>> index 867918895b..130f647a4d 100644
>> --- a/tests/qemu-iotests/common
>> +++ b/tests/qemu-iotests/common
>> @@ -366,7 +366,7 @@ testlist options
>>       if $xpand
>>       then
>>           have_test_arg=3Dtrue
>> -        $AWK_PROG </dev/null '
>> +        awk </dev/null '
>>   BEGIN        { for (t=3D'$start'; t<=3D'$end'; t++) printf "%03d\n",=
t }' \
>>           | while read id
>>           do
>> diff --git a/tests/qemu-iotests/common.config
>> b/tests/qemu-iotests/common.config
>> index b599c72211..0f571d46eb 100644
>> --- a/tests/qemu-iotests/common.config
>> +++ b/tests/qemu-iotests/common.config
>> @@ -56,9 +56,6 @@ _fatal()
>>       exit 1
>>   }
>>   -export AWK_PROG=3D"`set_prog_path awk`"
>> -[ "$AWK_PROG" =3D "" ] && _fatal "awk not found"
>> -
>>   if [ -z "$QEMU_PROG" ]; then
>>       export QEMU_PROG=3D"`set_prog_path qemu`"
>>   fi
>>
