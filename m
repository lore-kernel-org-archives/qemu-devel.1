Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5918FC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 11:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE1B20675
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 11:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE1B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55034 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNc8R-0005Ce-H5
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 07:50:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNc7Z-0004nm-3F
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNc7Y-0006ms-2i
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:49:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hNc7X-0006mY-Sz
	for qemu-devel@nongnu.org; Mon, 06 May 2019 07:49:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so1539690wro.10
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 04:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=TF+ZuYNSnAl9+exbTdISnc0EMQWLLHOcY27jWaK9Law=;
	b=Ui/LFt4DSZzIELyxhdVAX2pB1Pngn8ch+w0QDZnoiwSN0C+DnvdU44fGYTaGMi3Js0
	xwUni/bd7JjblfZUbTjFd8zARa7H786UPe/THiOXFVslxViZWnV2Cmxx/HCJb11MJZY5
	HWsPOEbxuw9pSZxao2TPstJYpX/4I9OtIrEcmVxPA/e3iHdw9ddxveglv7p3gpTiP2WR
	7617Em732oKsXFMWeJD0LTrizGH22UVogSrT0CYFrNpgtm7POgklaMazFntpNBW+jphZ
	N02/xtY1QyR1gcQ/I01r9G5zfbK8fZ9ng0B9JwVYMP8cMxbzqUfy8kLfj1bhp1v0dfZq
	sEQQ==
X-Gm-Message-State: APjAAAWV/eehWkFWXmyBdhBAeAWvx7zs0flhhPQmyqlLoVcU6yyUgTVn
	wzhGVO0JffrhzBmiRlU50snnYw==
X-Google-Smtp-Source: APXvYqwsgdOjxgrGl7oSJezac22PZE5ZV4HonsButnkZlesjvYWYLh73vEaK6NdFM/GNkcHA1a34PQ==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr17488900wrn.156.1557143362872;
	Mon, 06 May 2019 04:49:22 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	z5sm25047798wre.70.2019.05.06.04.49.21
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 04:49:22 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <20190505230140.5661-1-philmd@redhat.com>
	<87sgtsrmh3.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <11e46093-4562-0f0c-e5fd-190b0edf6d29@redhat.com>
Date: Mon, 6 May 2019 13:49:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87sgtsrmh3.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] hw/sd/sdcard: Use the available enums
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
Cc: qemu-trivial@nongnu.org, Juan Quintela <quintela@redhat.com>,
	qemu-devel@nongnu.org, David Alan Gilbert <dgilbert@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/6/19 10:55 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> We already define SDCardModes/SDCardStates as enums. Declare
>> the mode/state as enums too, this make gdb debugging sessions
>> friendlier: instead of numbers, the mode/state name is displayed.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/sd/sd.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index aaab15f3868..a66b3d5b45e 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -96,8 +96,8 @@ struct SDState {
>>      BlockBackend *blk;
>>      bool spi;
>>  
>> -    uint32_t mode;    /* current card mode, one of SDCardModes */
>> -    int32_t state;    /* current card state, one of SDCardStates */
>> +    enum SDCardModes mode;
>> +    enum SDCardStates state;
>>      uint32_t vhs;
>>      bool wp_switch;
>>      unsigned long *wp_groups;
>> @@ -1640,7 +1640,7 @@ static int cmd_valid_while_locked(SDState *sd, SDRequest *req)
>>  
>>  int sd_do_command(SDState *sd, SDRequest *req,
>>                    uint8_t *response) {
>> -    int last_state;
>> +    enum SDCardStates last_state;
>>      sd_rsp_type_t rtype;
>>      int rsplen;
> 
> These guys are part of the migration state:
> 
>    static const VMStateDescription sd_vmstate = {
>        .name = "sd-card",
>        .version_id = 1,
>        .minimum_version_id = 1,
>        .pre_load = sd_vmstate_pre_load,
>        .fields = (VMStateField[]) {
>            VMSTATE_UINT32(mode, SDState),
>            VMSTATE_INT32(state, SDState),
>    [...]

Oh good point, I missed that.

> Juan, David, are VMSTATE_UINT32() and VMSTATE_INT32() safe to use with
> enums?

I'll wait Juan/Dave to enlighten us, else I can use anonymous union to
ease my debugging sessions:

-- >8 --
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
@@ -96,7 +96,10 @@ struct SDState {
     BlockBackend *blk;
     bool spi;

-    uint32_t mode;    /* current card mode, one of SDCardModes */
+    union {
+        uint32_t migratable_mode;
+        enum SDCardModes mode;
+    };
     int32_t state;    /* current card state, one of SDCardStates */
     uint32_t vhs;
     bool wp_switch;
@@ -659,7 +662,7 @@ static const VMStateDescription sd_vmstate = {
     .minimum_version_id = 1,
     .pre_load = sd_vmstate_pre_load,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(mode, SDState),
+        VMSTATE_UINT32(migratable_mode, SDState),
         VMSTATE_INT32(state, SDState),
         VMSTATE_UINT8_ARRAY(cid, SDState, 16),
         VMSTATE_UINT8_ARRAY(csd, SDState, 16),
---

Thanks for the review!

Phil.

