Received: from eggs.gnu.org ([2001:4830:134:3::10]:41984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDNBJ-0002sR-DS
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDNBA-00068U-9S
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:18:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDNAy-0005wQ-OS
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:18:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id 143-v6so2327765wmf.1
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:18:18 -0700 (PDT)
References: <20181011171254.32428-1-philmd@redhat.com>
	<CAMxuvay4Hs_Aa1km5vav75GAdxtzo0YO=xfe8H-_=-7oS1ej-w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2c64df66-6949-56f8-02a2-8a61b2c9fd98@redhat.com>
Date: Fri, 19 Oct 2018 07:18:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAMxuvay4Hs_Aa1km5vav75GAdxtzo0YO=xfe8H-_=-7oS1ej-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vl: Print error when using incorrect
 backend for debugcon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: "Bonzini, Paolo" <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org

Cc'ing qemu-trivial@

On 11/10/2018 23:48, Marc-André Lureau wrote:
> On Thu, Oct 11, 2018 at 9:13 PM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
>>
>> When using an incorrect backend for the debugcon, QEMU exits silently
>> without any error indication, which is confusing.
>> Add a message that the character backend is invalid.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
>> ---
>>  vl.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/vl.c b/vl.c
>> index 4e25c78bff..61305b5891 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -2466,6 +2466,7 @@ static int debugcon_parse(const char *devname)
>>      QemuOpts *opts;
>>
>>      if (!qemu_chr_new_mux_mon("debugcon", devname)) {
>> +        error_report("invalid character backend '%s'", devname);
>>          exit(1);
>>      }
>>      opts = qemu_opts_create(qemu_find_opts("device"), "debugcon", 1, NULL);
>> --
>> 2.17.1
>>
