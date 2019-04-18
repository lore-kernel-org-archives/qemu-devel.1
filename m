Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F41C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E61D420643
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E61D420643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45399 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHBfx-0002YU-2i
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 14:22:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHBXX-00048N-LQ
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHBXW-0000LX-Oi
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:13:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hHBXW-0000L6-JD; Thu, 18 Apr 2019 14:13:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 82F497E44B;
	Thu, 18 Apr 2019 18:13:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E0EF600C2;
	Thu, 18 Apr 2019 18:13:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id D26101138648; Thu, 18 Apr 2019 20:13:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-6-armbru@redhat.com>
	<4aa820cd-bb5e-b891-bd77-42afab8de347@redhat.com>
Date: Thu, 18 Apr 2019 20:13:35 +0200
In-Reply-To: <4aa820cd-bb5e-b891-bd77-42afab8de347@redhat.com> (Thomas Huth's
	message of "Thu, 18 Apr 2019 18:28:05 +0200")
Message-ID: <87ftqfkwq8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 18 Apr 2019 18:13:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 5/6] pc-bios/s390-ccw: Clean up harmless
 misuse of isdigit()
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418181335.qU53oJyBO0DM4ueoIXGpB9noU49jdmTXDNcveUFAmn0@z>

Thomas Huth <thuth@redhat.com> writes:

> On 18/04/2019 16.53, Markus Armbruster wrote:
>> atoui() and get_index() pass char values to isdigit().  With a
>> standard isdigit(), we'd get undefined behavior when the value is
>> negative.  But we're using isdigit() from pc-bios/s390-ccw/libc.h
>> here, which behaves nicely.  Clean up anyway, just to avoid setting a
>> bad example.
>> 
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: qemu-s390x@nongnu.org
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  pc-bios/s390-ccw/libc.c | 2 +-
>>  pc-bios/s390-ccw/menu.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/pc-bios/s390-ccw/libc.c b/pc-bios/s390-ccw/libc.c
>> index a786566c4c..3187923950 100644
>> --- a/pc-bios/s390-ccw/libc.c
>> +++ b/pc-bios/s390-ccw/libc.c
>> @@ -38,7 +38,7 @@ uint64_t atoui(const char *str)
>>      }
>>  
>>      while (*str) {
>> -        if (!isdigit(*str)) {
>> +        if (!isdigit(*(unsigned char *)str)) {
>>              break;
>>          }
>>          val = val * 10 + *str - '0';
>> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
>> index 82a4ae6315..ce3815b201 100644
>> --- a/pc-bios/s390-ccw/menu.c
>> +++ b/pc-bios/s390-ccw/menu.c
>> @@ -134,7 +134,7 @@ static int get_index(void)
>>  
>>      /* Check for erroneous input */
>>      for (i = 0; i < len; i++) {
>> -        if (!isdigit(buf[i])) {
>> +        if (!isdigit((unsigned char)buf[i])) {
>>              return -1;
>>          }
>>      }
>
> FWIW, "char" is unsigned by default on s390x, so this is doing nothing.

I see.

If we decide to keep the patch, the commit message needs tweaking.
Perhaps:

    atoui() and get_index() pass char values to isdigit().  With a
    standard isdigit(), we'd get undefined behavior when the value is
    negative.  Can't happen as char is unsigned on s390x.  Even if it
    could, we're actually using isdigit() from pc-bios/s390-ccw/libc.h
    here, which works fine for negative values.  Clean up anyway, just
    to avoid setting a bad example.

