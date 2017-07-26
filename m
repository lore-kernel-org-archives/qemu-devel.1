Received: from eggs.gnu.org ([2001:4830:134:3::10]:57798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daITo-00054L-Do
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daITj-0005wl-Fo
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:19:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daITj-0005v7-Ac
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:19:39 -0400
References: <1500990514-30326-1-git-send-email-pbonzini@redhat.com>
	<1500990514-30326-3-git-send-email-pbonzini@redhat.com>
	<d82f2f89-2d40-9bf3-9b89-50ed734fb5e6@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <191c6c0b-ef06-d479-7533-fbf891ae7935@redhat.com>
Date: Wed, 26 Jul 2017 11:19:34 +0200
MIME-Version: 1.0
In-Reply-To: <d82f2f89-2d40-9bf3-9b89-50ed734fb5e6@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] rtc-test: introduce more update tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: peng.hao2@zte.com.cn, liu.yi24@zte.com.cn

On 26/07/2017 03:28, Philippe Mathieu-Daud=C3=A9 wrote:
> On 07/25/2017 10:48 AM, Paolo Bonzini wrote:
>> Test divider reset and UIP behavior.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   tests/rtc-test.c | 82
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 81 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/rtc-test.c b/tests/rtc-test.c
>> index 798cf5e..d7a96cb 100644
>> --- a/tests/rtc-test.c
>> +++ b/tests/rtc-test.c
>> @@ -325,6 +325,30 @@ static void set_datetime_bcd(int h, int min, int
>> s, int d, int m, int y)
>>       cmos_write(RTC_DAY_OF_MONTH, d);
>>   }
>>  =20
>=20
> I'm not sure why this function is in tests/ ...

Not sure I understand?

>> +static void set_datetime_dec(int h, int min, int s, int d, int m, int=
 y)
>> +{
>=20
> Following is set_time_regs()
>=20
>> +    cmos_write(RTC_HOURS, h);
>> +    cmos_write(RTC_MINUTES, min);
>> +    cmos_write(RTC_SECONDS, s);
>=20
> Maybe we can use here:
>=20
> if (mode & REG_B_DM /* dec */) {
>=20
>> +    cmos_write(RTC_YEAR, y % 100);
>> +    cmos_write(RTC_CENTURY, y / 100);
>=20
> } else /* bcd */ {
> ...
> }
>=20
> instead of having 2 set_datetime()

Because this function does not have a "mode" argument.

Paolo
