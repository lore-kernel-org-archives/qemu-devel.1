Received: from eggs.gnu.org ([209.51.188.92]:42197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1gpWJ8-0003XB-2a
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1gpWIv-00045E-W8
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:44:20 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:59964
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1gpWIv-00043e-Dl
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:44:13 -0500
References: <20190130192403.13754-1-jcmvbkbc@gmail.com>
	<ff956174-0839-0034-b659-a1e6e5096493@greensocs.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <5469e5c2-b6f4-1435-055d-61a1ddc9633e@adacore.com>
Date: Fri, 1 Feb 2019 11:44:07 +0100
MIME-Version: 1.0
In-Reply-To: <ff956174-0839-0034-b659-a1e6e5096493@greensocs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] gdbstub: allow killing QEMU via vKill
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>



Le 1/31/19 =C3=A0 5:15 PM, Luc Michel a =C3=A9crit=C2=A0:
> On 1/30/19 8:24 PM, Max Filippov wrote:
>> With multiprocess extensions gdb uses 'vKill' packet instead of 'k' to
>> kill the inferior. Handle 'vKill' the same way 'k' was handled in the
>> presence of single process.
>>
>> Fixes: 7cf48f6752e5 ("gdbstub: add multiprocess support to
>> (f|s)ThreadInfo and ThreadExtraInfo")
>>
>> Cc: Luc Michel <luc.michel@greensocs.com>
>> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> Reviewed-by: Luc Michel <luc.michel@greensocs.com>

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
Tested-By: KONRAD Frederic <frederic.konrad@adacore.com>

Thanks!
Fred

>=20
>> ---
>> Changes v1->v2:
>> - terminate QEMU in the vKill packet handler regardless of whatever th=
e
>>    PID is or how many processes are attached [Luc Michel]
>>
>>   gdbstub.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/gdbstub.c b/gdbstub.c
>> index bfc7afb50968..96ffcd9d9d1d 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -1383,6 +1383,10 @@ static int gdb_handle_packet(GDBState *s, const=
 char *line_buf)
>>  =20
>>               put_packet(s, buf);
>>               break;
>> +        } else if (strncmp(p, "Kill;", 5) =3D=3D 0) {
>> +            /* Kill the target */
>> +            error_report("QEMU: Terminated via GDBstub");
>> +            exit(0);
>>           } else {
>>               goto unknown_command;
>>           }
>>
>=20
