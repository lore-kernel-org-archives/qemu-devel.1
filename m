Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A74C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019B42147A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019B42147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57351 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQAtf-0002lO-6U
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:21:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQAle-0004Sx-4j
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQAld-0004JX-38
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:13:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQAlc-0004Ir-SG
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:13:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D14E30842A8
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 13:13:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A914E424F;
	Mon, 13 May 2019 13:13:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 27F8111385E4; Mon, 13 May 2019 15:13:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
	<2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
Date: Mon, 13 May 2019 15:13:15 +0200
In-Reply-To: <2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu,
	18 Apr 2019 17:19:45 +0200")
Message-ID: <875zqe7b10.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 13 May 2019 13:13:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-bridge-helper: Fix misuse of
 isspace()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 4/18/19 4:53 PM, Markus Armbruster wrote:
>> parse_acl_file() passes char values to isspace().  Undefined behavior
>> when the value is negative.  Not a security issue, because the
>> characters come from trusted $prefix/etc/qemu/bridge.conf and the
>> files it includes.
>>=20
>> Fix by using qemu_isspace() instead.
>
> Can we use g_ascii_isspace() and remove qemu_isspace()?

Hmm, I wasn't aware of that one.

                    arg type  arg values              obeys locale?
ctype.h isFOO()     int       unsigned char, EOF [1]  yes [4]
qemu_isFOO()        int       any char [2]            yes [4]
g_ascii_isFOO()     char      any char [3]            no

[1] Undefined behavior when the argument is a negative plain or signed
char.  Well-known trap.

[2] qemu_isFOO(arg) expands into isFOO((unsigned char)arg), which works
fine for plain, signed and unsigned char arg.

[3] When plain char is signed, and the actual argument is unsigned char
and not representable as char, then behavior is implementation-defined.
No problem; the implementations we care for reinterpret as two's
complement.

[4] Obeying the locale is commonly unwanted.

Replacing isFOO() by qemu_isFOO() gets rid of trap [1] (and loses EOF,
but that rarely matters).

Replacing qemu_isFOO() by g_ascii_isFOO() gets rid of the commonly
unwanted locale dependence.  Each such replacement needs review, no
matter how common "unwanted" may be.

I suspect we'd almost always be better off with g_ascii_isFOO() instead
of qemu_isFOO().  If that's the case, then the few exceptions (if any)
could use standard isFOO(), so we can drop qemu_isFOO().

I'd rather not do that myself globally now due to the "needs review"
part.

Perhaps I should do it just for this file while I touch it anyway.  The
question to ask: should parse_acl_file() obey the locale for whitespace
recognition?

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qemu-bridge-helper.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
>> index 5396fbfbb6..0d60c07655 100644
>> --- a/qemu-bridge-helper.c
>> +++ b/qemu-bridge-helper.c
>> @@ -29,6 +29,7 @@
>>  #include <linux/if_bridge.h>
>>  #endif
>>=20=20
>> +#include "qemu-common.h"
>>  #include "qemu/queue.h"
>>=20=20
>>  #include "net/tap-linux.h"
>> @@ -75,7 +76,7 @@ static int parse_acl_file(const char *filename, ACLLis=
t *acl_list)
>>          char *ptr =3D line;
>>          char *cmd, *arg, *argend;
>>=20=20
>> -        while (isspace(*ptr)) {
>> +        while (qemu_isspace(*ptr)) {
>>              ptr++;
>>          }
>>=20=20
>> @@ -99,12 +100,12 @@ static int parse_acl_file(const char *filename, ACL=
List *acl_list)
>>=20=20
>>          *arg =3D 0;
>>          arg++;
>> -        while (isspace(*arg)) {
>> +        while (qemu_isspace(*arg)) {
>>              arg++;
>>          }
>>=20=20
>>          argend =3D arg + strlen(arg);
>> -        while (arg !=3D argend && isspace(*(argend - 1))) {
>> +        while (arg !=3D argend && qemu_isspace(*(argend - 1))) {
>>              argend--;
>>          }
>>          *argend =3D 0;
>>=20

