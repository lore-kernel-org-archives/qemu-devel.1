Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF2C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A78F22BE8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 17:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A78F22BE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqhj7-0004yD-O6
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 13:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45815)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqhiv-0004SW-Ga
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqhit-0002iz-Cx
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:40:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqhir-0002dt-AG
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 13:40:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so51617705wrt.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 10:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s5UdlQNRFngjQD7uV15tjCwUpVV8erqhBJBgdAU/8Ts=;
 b=p7cXly6h0jMwnqeANOQHcjlCOLikL+QGkP/Fco7RT/3kqUXV1nPAS5mlQn/D5fHrw+
 EDzUXnG8yRyXKdKv0n88jkh64FVA+9oYMFyZDkCPmvKQiz16wI2BaVTId7JpCgZlS/xg
 TWAOXY2uRP2lsokZURwzH3ItRlDIeilnjqHk+nxanYY9Ht4Wg38grEM4WR5Ss9bVE7KU
 i/yAff6AYE65p5GQFj3FIgqQ94Qf7zHlKBSmSZ0EhTPu3Ik75WX9Wx5wvgZ+I5MB9kYJ
 qpV1yLW5rv2I6KuSq+Tjr4cT61+Oipc24LfWX6RMY8n8UwO+LsG+ilOh+mKrJZGVD0lg
 KhKw==
X-Gm-Message-State: APjAAAUsXb13F2s0kKk8f1txkmRyVxsd3bpPepCGRZ+5zru8uyClwgpj
 /1TeIfLfCKvUqDOVan3cfLrSUQ==
X-Google-Smtp-Source: APXvYqwIWvfbxKW1aI7OEcKMHY3826wPIeSAaNoI+1NoqGalgwdpfnJSz7c1bd3Q0wQgaRP6vDF5JA==
X-Received: by 2002:adf:efd2:: with SMTP id i18mr94300869wrp.145.1564076405313; 
 Thu, 25 Jul 2019 10:40:05 -0700 (PDT)
Received: from [192.168.1.38] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id v204sm52408968wma.20.2019.07.25.10.40.04
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 10:40:04 -0700 (PDT)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190725163710.11703-1-peter.maydell@linaro.org>
 <20190725163710.11703-2-peter.maydell@linaro.org>
 <20190725170228.GL2656@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c5a0799e-2ebe-5a79-915a-af52d471a589@redhat.com>
Date: Thu, 25 Jul 2019 19:40:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190725170228.GL2656@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH for-4.1? 1/2] stellaris_input: Fix vmstate
 description of buttons field
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 7:02 PM, Dr. David Alan Gilbert wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> gamepad_state::buttons is a pointer to an array of structs,
>> not an array of structs, so should be declared in the vmstate
>> with VMSTATE_STRUCT_VARRAY_POINTER_INT32; otherwise we
>> corrupt memory on incoming migration.
>>
>> We bump the vmstate version field as the easiest way to
>> deal with the migration break, since migration wouldn't have
>> worked reliably before anyway.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> OK, it would be great to change num_buttons to uint32_t and make that a
> UINT32 at some point;  it's hard to press negative buttons.

Since the version is incremented, now seems to be a good time.

> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>> ---
>>  hw/input/stellaris_input.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/input/stellaris_input.c b/hw/input/stellaris_input.c
>> index 20c87d86f40..3a666d61d47 100644
>> --- a/hw/input/stellaris_input.c
>> +++ b/hw/input/stellaris_input.c
>> @@ -60,12 +60,14 @@ static const VMStateDescription vmstate_stellaris_button = {
>>  
>>  static const VMStateDescription vmstate_stellaris_gamepad = {
>>      .name = "stellaris_gamepad",
>> -    .version_id = 1,
>> -    .minimum_version_id = 1,
>> +    .version_id = 2,
>> +    .minimum_version_id = 2,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_INT32(extension, gamepad_state),
>> -        VMSTATE_STRUCT_VARRAY_INT32(buttons, gamepad_state, num_buttons, 0,
>> -                              vmstate_stellaris_button, gamepad_button),
>> +        VMSTATE_STRUCT_VARRAY_POINTER_INT32(buttons, gamepad_state,
>> +                                            num_buttons,
>> +                                            vmstate_stellaris_button,
>> +                                            gamepad_button),
>>          VMSTATE_END_OF_LIST()
>>      }
>>  };
>> -- 
>> 2.20.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

