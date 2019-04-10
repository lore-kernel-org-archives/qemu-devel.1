Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D460C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:29:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E2B20850
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E2B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE5nh-0003mM-8f
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 01:29:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE5mu-0003Ue-Ef
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE5mt-0004GP-G7
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hE5mt-0004G8-7W
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:28:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 25F07CD01D;
	Wed, 10 Apr 2019 05:28:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CF6BA5D71E;
	Wed, 10 Apr 2019 05:28:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 589391138648; Wed, 10 Apr 2019 07:28:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190409174018.25798-1-armbru@redhat.com>
	<f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com>
Date: Wed, 10 Apr 2019 07:28:36 +0200
In-Reply-To: <f018f4d8-7fb2-9037-3b5a-b34f1c5d876d@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 9 Apr 2019 20:59:55
	+0200")
Message-ID: <874l764eez.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 10 Apr 2019 05:28:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0-maybe] device_tree: Fix integer
 overflowing in load_device_tree()
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
Cc: peter.maydell@linaro.org, alistair.francis@wdc.com, qemu-devel@nongnu.org,
	slp@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410052836.401QOMRTVfGG_gcVO9AUhfAXf1g6XhQSmG_3ySZo7vc@z>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 4/9/19 7:40 PM, Markus Armbruster wrote:
>> If the value of get_image_size() exceeds INT_MAX / 2 - 10000, the
>> computation of @dt_size overflows to a negative number, which then
>> gets converted to a very large size_t for g_malloc0() and
>> load_image_size().  In the (fortunately improbable) case g_malloc0()
>> succeeds and load_image_size() survives, we'd assign the negative
>> number to *sizep.  What that would do to the callers I can't say, but
>> it's unlikely to be good.
>>=20
>> Fix by rejecting images whose size would overflow.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  device_tree.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/device_tree.c b/device_tree.c
>> index 296278e12a..f8b46b3c73 100644
>> --- a/device_tree.c
>> +++ b/device_tree.c
>> @@ -84,6 +84,10 @@ void *load_device_tree(const char *filename_path, int=
 *sizep)
>>                       filename_path);
>>          goto fail;
>>      }
>> +    if (dt_size > INT_MAX / 2 - 10000) {
>
> We should avoid magic number duplication.
> That said, this patch looks safe.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

> BTW how did you figure that out?

Downstream handling of upstream commit da885fe1ee8 led me to the
function.  I spotted dt_size =3D get_image_size(filename_path).
Experience has taught me to check the left hand side's type.  Bad.  Then
I saw how dt_size gets increased.  Worse.

>> +        error_report("Device tree file '%s' is too large", filename_pat=
h);
>> +        goto fail;
>> +    }
>>=20=20
>>      /* Expand to 2x size to give enough room for manipulation.  */
>>      dt_size +=3D 10000;
>>=20

