Received: from eggs.gnu.org ([2001:4830:134:3::10]:54565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gHVfo-0000IQ-Kv
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gHVfg-0006uT-S9
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:11:15 -0400
Received: from mail-eopbgr730103.outbound.protection.outlook.com
	([40.107.73.103]:9280
	helo=NAM05-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gHVfd-0006dA-VP
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 11:11:06 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 30 Oct 2018 15:11:01 +0000
Message-ID: <BN6PR2201MB125120CBD6D192F75C543965C6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1540899411-16761-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540899411-16761-5-git-send-email-aleksandar.markovic@rt-rk.com>
	<f9b3eb95-7696-93b1-6b63-14b80e4d9217@redhat.com>,
	<602e0be5-4d29-e552-cb4b-4ba0c0e09218@redhat.com>
In-Reply-To: <602e0be5-4d29-e552-cb4b-4ba0c0e09218@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 4/5] target/mips: Misc R5900-related
 cosmetic changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Subject: Re: [Qemu-devel] [PATCH v2 4/5] target/mips: Misc R5900-related =
cosmetic changes

Sure, I will move these parts from patch to patch.

> On 30/10/18 13:47, Philippe Mathieu-Daud=E9 wrote:
> On 30/10/18 12:36, Aleksandar Markovic wrote:
>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>
>> Misc changes in comments and strings for R5900.
>>
>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>> ---
>>   target/mips/translate.c          | 14 +++++++-------
>>   target/mips/translate_init.inc.c | 12 ------------
>>   2 files changed, 7 insertions(+), 19 deletions(-)
>>
>> diff --git a/target/mips/translate.c b/target/mips/translate.c
>> index 155331f..259ad2b 100644
>> --- a/target/mips/translate.c
>> +++ b/target/mips/translate.c
>> @@ -2096,8 +2096,8 @@ enum {
>>    * MTSAH   rs, immediate     Move Halfword Count to Shift Amount
>> Register
>>    * PROT3W  rd, rt            Parallel Rotate 3 Words
>>    *
>> - *     The TX79-specific Multimedia Instruction encodings
>> - *     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> + *     Multimedia Instructions (MMI) encodings
>
> Oh now I see this. I this single change should be squashed into patch #2
> of this series.
>
> Also, maybe use "MultiMedia ..."
>

Sure.

>> + *     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>    *
>>    * MMI Instruction encoding table keys:
>>    *

> The part from here ...

>> @@ -24714,7 +24714,7 @@ static void decode_mmi0(CPUMIPSState *env,
>> DisasContext *ctx)
>>           generate_exception_end(ctx, EXCP_RI); /* TODO:
>> MMI_OPC_CLASS_MMI0 */
>>           break;
>>       default:
>> -        MIPS_INVAL("TX79 MMI class MMI0");
>> +        MIPS_INVAL("MMI class MMI0");
>>           generate_exception_end(ctx, EXCP_RI);
>>           break;
>>       }
>> @@ -24746,7 +24746,7 @@ static void decode_mmi1(CPUMIPSState *env,
>> DisasContext *ctx)
>>           generate_exception_end(ctx, EXCP_RI); /* TODO:
>> MMI_OPC_CLASS_MMI1 */
>>           break;
>>       default:
>> -        MIPS_INVAL("TX79 MMI class MMI1");
>> +        MIPS_INVAL("MMI class MMI1");
>>           generate_exception_end(ctx, EXCP_RI);
>>           break;
>>       }
>> @@ -24782,7 +24782,7 @@ static void decode_mmi2(CPUMIPSState *env,
>> DisasContext *ctx)
>>           generate_exception_end(ctx, EXCP_RI); /* TODO:
>> MMI_OPC_CLASS_MMI2 */
>>           break;
>>       default:
>> -        MIPS_INVAL("TX79 MMI class MMI2");
>> +        MIPS_INVAL("MMI class MMI2");
>>           generate_exception_end(ctx, EXCP_RI);
>>           break;
>>       }
>> @@ -24809,7 +24809,7 @@ static void decode_mmi3(CPUMIPSState *env,
>> DisasContext *ctx)
>>           generate_exception_end(ctx, EXCP_RI); /* TODO:
>> MMI_OPC_CLASS_MMI3 */
>>           break;
>>       default:
>> -        MIPS_INVAL("TX79 MMI class MMI3");
>> +        MIPS_INVAL("MMI class MMI3");
>>           generate_exception_end(ctx, EXCP_RI);
>>           break;
>>       }
>> @@ -24867,7 +24867,7 @@ static void decode_mmi(CPUMIPSState *env,
>> DisasContext *ctx)
>>           generate_exception_end(ctx, EXCP_RI);    /* TODO:
>> MMI_CLASS_MMI */
>>           break;
>>       default:
>> -        MIPS_INVAL("TX79 MMI class");
>> +        MIPS_INVAL("MMI class");
>>           generate_exception_end(ctx, EXCP_RI);
>>           break;
>>       }

> ... to here can also be squashed in patch #3.

Sure.
