Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3709C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6142072A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1NKxK6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6142072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioojL-0006sX-4U
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iooFR-0001EZ-Ry
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:46:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iooFP-0003QJ-Vg
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:46:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50161
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iooFO-0003P0-4E
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 07:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578401168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1PmNgUSZ1ajqphItaB21o1D5ihT2oWrYJr1I7qUnvBg=;
 b=D1NKxK6gFYgOXxzRQoknvCzTVPoNwqVk5kIClSPbyF7A+e8oUgKerPXmgsGw8emWLwrH/K
 KXUOijs8S7ZDTJNwyawL38K2QIPMjirNYAE62NUyrplSf20BPne+4nNjbV6SP+7rnuEiTb
 6gg27c1tU8NtLOOHlMV0Sc33Fw46RqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-NwqJvx4iPgmW-2sfD-AXOQ-1; Tue, 07 Jan 2020 07:46:05 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A210B10054E3;
 Tue,  7 Jan 2020 12:46:04 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FA41272A9;
 Tue,  7 Jan 2020 12:46:02 +0000 (UTC)
Subject: Re: [PATCH] iotests: fix usage -machine accel= together with -accel
 option
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
References: <20191223074329.21262-1-vsementsov@virtuozzo.com>
 <8900f0c8-19ce-2475-01c6-150394d516f0@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <77427b54-f458-cecc-de21-f2fa2d1f2fec@redhat.com>
Date: Tue, 7 Jan 2020 13:46:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8900f0c8-19ce-2475-01c6-150394d516f0@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: NwqJvx4iPgmW-2sfD-AXOQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/12/2019 09.39, Paolo Bonzini wrote:
> On 23/12/19 08:43, Vladimir Sementsov-Ogievskiy wrote:
>> diff --git a/vl.c b/vl.c
>> index 86474a55c9..9fb859969c 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -2779,7 +2779,7 @@ static void configure_accelerators(const char *progname)
>>          for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
>>              /*
>>               * Filter invalid accelerators here, to prevent obscenities
>> -             * such as "-machine accel=tcg,,thread=single".
>> +             * such as "-machine accel=tcg,thread=single".
> 
> The double comma is intentional.  Without the "if" below, the comma
> would be escaped and parsed as "-accel tcg,thread=single".
> 
>>               */
>>              if (accel_find(*tmp)) {
>>                  qemu_opts_parse_noisily(qemu_find_opts("accel"), *tmp, true);
>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>> index 90970b0549..2890785a10 100755
>> --- a/tests/qemu-iotests/check
>> +++ b/tests/qemu-iotests/check
>> @@ -587,13 +587,13 @@ export QEMU_PROG="$(type -p "$QEMU_PROG")"
>>  
>>  case "$QEMU_PROG" in
>>      *qemu-system-arm|*qemu-system-aarch64)
>> -        export QEMU_OPTIONS="-nodefaults -display none -machine virt,accel=qtest"
>> +        export QEMU_OPTIONS="-nodefaults -display none -machine virt -accel qtest"
>>          ;;
>>      *qemu-system-tricore)
>> -        export QEMU_OPTIONS="-nodefaults -display none -machine tricore_testboard,accel=qtest"
>> +        export QEMU_OPTIONS="-nodefaults -display none -machine tricore_testboard -accel qtest"
>>          ;;
>>      *)
>> -        export QEMU_OPTIONS="-nodefaults -display none -machine accel=qtest"
>> +        export QEMU_OPTIONS="-nodefaults -display none -accel qtest"
>>          ;;
>>  esac
>>  
>>
> 
> This part is good, but what is the reproducer?

Make the iotests run with either qemu-system-arm, qemu-system-aarch64 or
qemu-system-tricore, e.g.:

 QEMU_PROG=aarch64-softmmu/qemu-system-aarch64 make check-block

 HTH,
  Thomas


