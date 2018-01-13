Received: from eggs.gnu.org ([2001:4830:134:3::10]:45323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eaMxh-0005xk-KQ
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 09:39:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eaMxc-0007aw-Mu
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 09:39:09 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:35178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eaMxc-0007ak-IK
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 09:39:04 -0500
Received: by mail-ot0-x236.google.com with SMTP id 53so7377344otj.2
	for <qemu-devel@nongnu.org>; Sat, 13 Jan 2018 06:39:04 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <1512682213-4354-1-git-send-email-minyard@acm.org>
	<1512682213-4354-7-git-send-email-minyard@acm.org>
	<CAJ+F1CKUK_uRa9imNcOLzvNZyNaC7ciNqLppzGWVZjKGJ8ggRQ@mail.gmail.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <7d0d484e-2ff2-11cc-8119-8d8586ac04e7@acm.org>
Date: Sat, 13 Jan 2018 08:38:59 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKUK_uRa9imNcOLzvNZyNaC7ciNqLppzGWVZjKGJ8ggRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH 6/8] vl.c: disallow command line fw cfg
 without opt/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 01/12/2018 11:06 AM, Marc-André Lureau wrote:
> Hi
>
> On Thu, Dec 7, 2017 at 10:30 PM,  <minyard@acm.org> wrote:
>> From: "Michael S. Tsirkin" <mst@redhat.com>
>>
>> Allowing arbitary file names on command line is setting us up for
>> failure: future guests will look for a specific QEMU-specified name and
>> will get confused finding a user file there.
>>
> Why is this part of a IPMI series?

It's been so long I don't remember any more.  I think I suggested a 
simpler fix when
Michael posted his, and it ended up in my queue, because at one point 
the IPMI code
was messing around in fw_cfg.  But you are right, it doesn't belong here.

> There was a lengthy discussion on this patch earlier, could you
> summarize the conclusion?

I think there was no conclusion.  This patch should just be dropped.

Thanks for this and your other comments.

-corey

>
> thanks
>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> [Change "warning" to "error" in the error report.]
>> Signed-off-by: Corey Minyard <cminyard@mvista.com>
>> ---
>>   vl.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/vl.c b/vl.c
>> index 1ad1c04..fae9300 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -2400,8 +2400,9 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
>>           return -1;
>>       }
>>       if (strncmp(name, "opt/", 4) != 0) {
>> -        warn_report("externally provided fw_cfg item names "
>> -                    "should be prefixed with \"opt/\"");
>> +        error_report("error: externally provided fw_cfg item names "
>> +                     "should be prefixed with \"opt/\"");
>> +        return -1;
>>       }
>>       if (nonempty_str(str)) {
>>           size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
>> --
>> 2.7.4
>>
>>
>
>
