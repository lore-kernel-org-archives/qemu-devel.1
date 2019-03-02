Received: from eggs.gnu.org ([209.51.188.92]:46792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h08yk-0001Gw-6n
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 13:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h08la-0006d9-Hh
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 12:49:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h08la-0006cG-AS
	for qemu-devel@nongnu.org; Sat, 02 Mar 2019 12:49:42 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so1003090wmj.1
	for <qemu-devel@nongnu.org>; Sat, 02 Mar 2019 09:49:41 -0800 (PST)
References: <20190302022518.18719-1-samuel.thibault@ens-lyon.org>
	<5b0be3f1-85c1-bb1a-2692-e0f2650bcb4f@redhat.com>
	<20190302173629.3tfpiems2plii6gc@function>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <22ad88a1-e38b-25c1-bd7f-6fc0e8e29b80@redhat.com>
Date: Sat, 2 Mar 2019 18:49:39 +0100
MIME-Version: 1.0
In-Reply-To: <20190302173629.3tfpiems2plii6gc@function>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] slirp: fix big/little endian conversion in
 ident protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org, will@wbowling.info, stefanha@redhat.com, jan.kiszka@siemens.com

On 3/2/19 6:36 PM, Samuel Thibault wrote:
> Philippe Mathieu-Daudé, le sam. 02 mars 2019 18:31:56 +0100, a ecrit:
>> On 3/2/19 3:25 AM, Samuel Thibault wrote:
>>> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
>>> ---
>>
>> I got:
>>
>> Applying: slirp: fix big/little endian conversion in ident protocol
>> error: patch failed: slirp/tcp_subr.c:660
>> error: slirp/tcp_subr.c: patch does not apply
>>
>> Then noticed another slirp patch, applied first then this one succeed,
>> so you missed:
>>
>> Based-on: <1551476756-25749-1-git-send-email-will@wbowling.info>
> 
> Oh, I didn't know about that one.

BTW 'Based-on' is a hint for the reviewers and automatic testing bots,
telling "this commit is <based on> this other <series|patch>", and
without applying the base it is unlikely this patch|series applies.

It is not meant the git history, so for single commit we add it under
the first '---' separator (automatically stripped out when applied) or
for series we add it to the cover.

I guess there are no doc about that hint in HACKING neither in the wiki,
I remember the post where it was introduced:
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01288.html

Regards,

Phil.

> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Thanks!
> 
> Samuel
> 
