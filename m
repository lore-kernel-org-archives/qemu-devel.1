Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AB1C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695F12071A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pkfim3/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695F12071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHiV-0008T0-Jy
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49679)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJHhr-0007z3-1n
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:17:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJHho-0006rN-MQ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:17:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50562
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJHho-0006rE-Iq
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585664248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkJ1a75JrNKWgwOQWdXAnHKUN6oz/7WbPYYWyEAQ37k=;
 b=Pkfim3/B0zuHQOFXC9jr6lbqb/q0yFpCWfJEQesE5HYxAYhEnggFyRsDPvhKt8tCirZ9He
 Mjk2E209jML8S7cfXnWA9VQ/6NuqR3cCnZO6760RaenrPB6Ey5JDWLp50Fs1Q4p6ZhxRct
 STKsilIUk8D2nVnpw5wMLyjrOUVdCPw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-jB9LFW_jNEGaKbqwKhMyCA-1; Tue, 31 Mar 2020 10:17:25 -0400
X-MC-Unique: jB9LFW_jNEGaKbqwKhMyCA-1
Received: by mail-ed1-f70.google.com with SMTP id b12so18730362edy.7
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PUtk4UswzaTqGuxMz58jfsdWGq6Pi+t9KhsEDXmsQ58=;
 b=pj9QRA4+d/HISEkTEfDmM5uNhrrWFIwvdkmfc2mwfscFxHoyosyk1//mCDOEOvtWNB
 Qy7pA3HHO5M8kgiFlNV1rlmsfYFeYxMhd+mEcD3Z3u0/tYVCMaf96RIJkYXxh+0tjPHU
 AKb7p2Pnjr0I/H3ZdpcQ2MjwdHI2K5XuH5XHo0UDkxqicxF795d96bAwZaLSr5s21zux
 yuTXdKTL8ENKrybT+dPEcl/7QgwjuPGWlEQWFvyi2gDJ7QIMJ6IYKw0JPk0HrX87TGx9
 Fkyyargp6iMaglgjVdRjJVWsCUe5aZtbwT14PNqYIiDZjSssQGUlNgu+LJGkWWh9H4pK
 FdPg==
X-Gm-Message-State: ANhLgQ15gUJMKiTk99cTotm1Hf8K6VwGuZhqgkaJcLvA/OHWKxFyokvX
 Ai5gkDsf+y8NjJP7ul/l7F7XS71ktCTOuDZ35TRhtRBSzi+MUmNluC6wMRqa/RudwUw8dngYVyn
 c+qYzxdt3q4npb1E=
X-Received: by 2002:a05:6402:22c2:: with SMTP id
 dm2mr16486935edb.156.1585664244589; 
 Tue, 31 Mar 2020 07:17:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuvYHBHvcuEQb8uHJ2vw3E4A21VtOCuE8R3i9zD9EtaSAR+I6r7yTr6QJiKSSKzSf5uP9HGTw==
X-Received: by 2002:a05:6402:22c2:: with SMTP id
 dm2mr16486898edb.156.1585664244256; 
 Tue, 31 Mar 2020 07:17:24 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id k9sm2347475edl.35.2020.03.31.07.17.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 07:17:23 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v2 4/4] qga: Restrict guest-file-read count to 10
 MB to avoid crashes
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200331140638.16464-1-philmd@redhat.com>
 <20200331140638.16464-5-philmd@redhat.com>
 <20200331141539.GJ353752@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <662cca57-aaba-445a-4abc-fbb33bff9ec9@redhat.com>
Date: Tue, 31 Mar 2020 16:17:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331141539.GJ353752@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Sameeh Jubran <sjubran@redhat.com>,
 Basil Salman <basil@daynix.com>, Dietmar Maurer <dietmar@proxmox.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 4:15 PM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 31, 2020 at 04:06:38PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> On https://www.mail-archive.com/qemu-devel@nongnu.org/msg693176.html
>> Daniel Berrang=C3=A9 commented:
>>
>>    The QEMU guest agent protocol is not sensible way to access huge
>>    files inside the guest. It requires the inefficient process of
>>    reading the entire data into memory than duplicating it again in
>>    base64 format, and then copying it again in the JSON serializer /
>>    monitor code.
>>
>>    For arbitrary general purpose file access, especially for large
>>    files, use a real file transfer program or use a network block
>>    device, not the QEMU guest agent.
>>
>> To avoid bug reports as BZ#1594054, follow his suggestion to put a
>> low, hard limit on "count" in the guest agent QAPI schema, and don't
>> allow count to be larger than 10 MB.
>>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1594054
>> Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
>> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   qga/qapi-schema.json | 6 ++++--
>>   qga/commands.c       | 6 +++++-
>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> index f6fcb59f34..7758d9daf8 100644
>> --- a/qga/qapi-schema.json
>> +++ b/qga/qapi-schema.json
>> @@ -266,11 +266,13 @@
>>   ##
>>   # @guest-file-read:
>>   #
>> -# Read from an open file in the guest. Data will be base64-encoded
>> +# Read from an open file in the guest. Data will be base64-encoded.
>> +# As this command is just for limited, ad-hoc debugging, such as log
>> +# file access, the number of bytes to read is limited to 10 MB.
>>   #
>>   # @handle: filehandle returned by guest-file-open
>>   #
>> -# @count: maximum number of bytes to read (default is 4KB)
>> +# @count: maximum number of bytes to read (default is 4KB, maximum is 1=
0MB)
>>   #
>>   # Returns: @GuestFileRead on success.
>>   #
>> diff --git a/qga/commands.c b/qga/commands.c
>> index 8ee1244ebb..c130d1b0f5 100644
>> --- a/qga/commands.c
>> +++ b/qga/commands.c
>> @@ -11,6 +11,7 @@
>>    */
>>  =20
>>   #include "qemu/osdep.h"
>> +#include "qemu/units.h"
>>   #include "guest-agent-core.h"
>>   #include "qga-qapi-commands.h"
>>   #include "qapi/error.h"
>> @@ -18,11 +19,14 @@
>>   #include "qemu/base64.h"
>>   #include "qemu/cutils.h"
>>   #include "qemu/atomic.h"
>> +#include "commands-common.h"
>=20
> This needs to be in the previous patch AFAICT.

Oops, thanks :)

>=20
>=20
> Regards,
> Daniel
>=20


