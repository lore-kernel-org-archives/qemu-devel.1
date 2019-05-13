Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670CCC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8064206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 12:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8064206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56669 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQAGt-000638-Rj
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 08:41:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQAEv-0004nh-IL
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQAEu-0004l4-Mf
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:39:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQAEu-0004kw-HO
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:39:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBA7C356F6
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 12:39:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AEBB2600C8;
	Mon, 13 May 2019 12:39:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 2DC4111385E4; Mon, 13 May 2019 14:39:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-4-armbru@redhat.com>
	<78da03ed-2b9f-2357-6f28-44115d8b2955@redhat.com>
Date: Mon, 13 May 2019 14:39:24 +0200
In-Reply-To: <78da03ed-2b9f-2357-6f28-44115d8b2955@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu,
	18 Apr 2019 17:26:54 +0200")
Message-ID: <87ef527clf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 13 May 2019 12:39:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/6] gdbstub: Reject invalid RLE repeat
 counts
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
>> "Debugging with GDB / Appendix E GDB Remote Serial Protocol /
>> Overview" specifies "The printable characters '#' and '$' or with a
>> numeric value greater than 126 must not be used."  gdb_read_byte()
>> only rejects values < 32.  This is wrong.  Impact depends on the caller:
>>=20
>> * gdb_handlesig() passes a char.  Incorrectly accepts '#', '$' and
>>   '\127'.
>>=20
>> * gdb_chr_receive() passes an uint8_t.  Additionally accepts
>>   characters with the most-significant bit set.
>>=20
>> Correct the validity check to match the specification.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  gdbstub.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/gdbstub.c b/gdbstub.c
>> index d54abd17cc..a6dce1b027 100644
>> --- a/gdbstub.c
>> +++ b/gdbstub.c
>> @@ -2064,7 +2064,7 @@ static void gdb_read_byte(GDBState *s, int ch)
>>              }
>>              break;
>>          case RS_GETLINE_RLE:
>> -            if (ch < ' ') {
>
> Can you add a comment referring to the ""Debugging with GDB / Appendix E
> GDB Remote Serial Protocol / Overview" here?

Like this?

        case RS_GETLINE_RLE:
            /*
             * Run-length encoding is explained in "Debugging with GDB /
             * Appendix E GDB Remote Serial Protocol / Overview".
             */
            if (ch < ' ') {


> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

>> +            if (ch < ' ' || ch =3D=3D '#' || ch =3D=3D '$' || ch > 126)=
 {
>>                  /* invalid RLE count encoding */
>>                  trace_gdbstub_err_invalid_repeat((uint8_t)ch);
>>                  s->state =3D RS_GETLINE;
>>=20

