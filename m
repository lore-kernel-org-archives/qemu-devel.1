Received: from eggs.gnu.org ([2001:4830:134:3::10]:50874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRLgp-0004d0-JK
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRLgl-0006ZJ-O5
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:00:43 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:41523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRLgl-0006ZB-Jl
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 14:00:39 -0400
Received: by mail-qt0-x242.google.com with SMTP id y20-v6so14293950qto.8
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 11:00:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180608170231.27912-1-armbru@redhat.com>
	<20180608171209.GE18233@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b0870ff7-fb75-09a9-40cc-4d73f188a95c@amsat.org>
Date: Fri, 8 Jun 2018 15:00:35 -0300
MIME-Version: 1.0
In-Reply-To: <20180608171209.GE18233@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Purge uses of banned g_assert_FOO()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 06/08/2018 02:12 PM, Daniel P. Berrangé wrote:
> On Fri, Jun 08, 2018 at 07:02:31PM +0200, Markus Armbruster wrote:
>> We banned use of certain g_assert_FOO() functions outside tests, and
>> made checkpatch.pl flag them (commit 6e9389563e5).  We neglected to
>> purge existing uses.  Do that now.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/ide/ahci.c                 |  2 +-
>>  hw/ppc/spapr_ovec.c           | 12 ++++++------
>>  hw/usb/dev-smartcard-reader.c |  2 +-
>>  qom/object.c                  | 10 +++++-----
>>  util/qht.c                    |  2 +-
>>  5 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> 
>> diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
>> index 2131e33d27..13d0befd9c 100644
>> --- a/hw/usb/dev-smartcard-reader.c
>> +++ b/hw/usb/dev-smartcard-reader.c
>> @@ -786,7 +786,7 @@ static void ccid_write_data_block(USBCCIDState *s, uint8_t slot, uint8_t seq,
>>          DPRINTF(s, D_VERBOSE, "error %d\n", p->b.bError);
>>      }
>>      if (len) {
>> -        g_assert_nonnull(data);
>> +        assert(data);
> 
> nitpick - all the other conversions used  g_assert()

I'd rather use assert() in the whole codebase...

I understand the rational here as "there is no other call to the
glib-Testing API, so keep it simple and directly use assert()"

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> 
> Regards,
> Daniel
> 
