Received: from eggs.gnu.org ([2001:4830:134:3::10]:38100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWW6v-0006pZ-FL
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 19:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWW6u-0003Z0-Fv
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 19:04:29 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:35310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWW6u-0003Yg-Af
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 19:04:28 -0400
Received: by mail-it0-x243.google.com with SMTP id v193so15309251itc.2
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 16:04:28 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <149187362699.15312.3273219849572595103@loki>
References: <20170407222016.15308-1-f4bug@amsat.org>
	<20170407222016.15308-5-f4bug@amsat.org>
	<149187362699.15312.3273219849572595103@loki>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 15 Jul 2017 20:04:26 -0300
Message-ID: <CAAdtpL4VGMxQuQbJ_gRVLrVggMgo7uwc0uOo5a3sRx96LjBjUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/4] qga: improve error handling in
 transfer_memory_block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

ping?

On Mon, Apr 10, 2017 at 10:20 PM, Michael Roth
<mdroth@linux.vnet.ibm.com> wrote:
> Quoting Philippe Mathieu-Daud=C3=A9 (2017-04-07 17:20:16)
>> Suggested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>
>> ---
>>
>> Michael should I use Signed-off-by instead of the Suggested-by (since it=
 is your
>> code)?
>
> I suppose it could go either way depending on the circumstances
> (assuming you've asked for / obtained their SoB obviously), but
> speaking for myself here I don't think it's necessary.
>
>>
>>  qga/commands-posix.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>> index fc45102a1e..ca5a24b2c9 100644
>> --- a/qga/commands-posix.c
>> +++ b/qga/commands-posix.c
>> @@ -2128,6 +2128,9 @@ static void transfer_memory_block(GuestMemoryBlock=
 *mem_blk, bool sys2memblk,
>>              if (errno =3D=3D ENOENT) {
>>                  result->response =3D
>>                      GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPP=
ORTED;
>> +            } else {
>> +                result->response =3D
>> +                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
>>              }
>>              goto out1;
>>          }
>> --
>> 2.11.0
>>
>
