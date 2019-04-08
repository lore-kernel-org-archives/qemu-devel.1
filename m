Received: from eggs.gnu.org ([209.51.188.92]:38606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hDcHC-0004Dl-IK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lidong.chen@oracle.com>) id 1hDcHB-0008Nq-EB
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:58:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lidong.chen@oracle.com>)
	id 1hDcHA-0008Kx-US
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 17:58:01 -0400
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	<d35048f6-44e7-46a0-3d70-51123896f1ef@redhat.com>
From: Lidong Chen <lidong.chen@oracle.com>
Message-ID: <e67e84dc-193a-3b28-7016-9113652e11fd@oracle.com>
Date: Mon, 8 Apr 2019 14:57:37 -0700
MIME-Version: 1.0
In-Reply-To: <d35048f6-44e7-46a0-3d70-51123896f1ef@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: darren.kenny@oracle.com, f4bug@amsat.org

Hi Philippe,

On 4/8/2019 2:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Lidong
>
> On 4/8/19 9:04 PM, Lidong Chen wrote:
>> Due to an off-by-one error, the assert statements allow an
>> out-of-bounds array access.
> ... which can't happen. Thus harmless for 4.0.
>
> I suppose this is a static analysis warning and you didn't triggered it
> while tracing.

Right, it was found by the static analysis.=C2=A0 Thank you for your revi=
ew.

Regards,

Lidong


>
> Thanks for cleaning this :)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
>> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
>> ---
>>   hw/sd/sd.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index aaab15f..818f86c 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates=
 state)
>>       if (state =3D=3D sd_inactive_state) {
>>           return "inactive";
>>       }
>> -    assert(state <=3D ARRAY_SIZE(state_name));
>> +    assert(state < ARRAY_SIZE(state_name));
>>       return state_name[state];
>>   }
>>  =20
>> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t =
rsp)
>>       if (rsp =3D=3D sd_r1b) {
>>           rsp =3D sd_r1;
>>       }
>> -    assert(rsp <=3D ARRAY_SIZE(response_name));
>> +    assert(rsp < ARRAY_SIZE(response_name));
>>       return response_name[rsp];
>>   }
>>  =20
>>
