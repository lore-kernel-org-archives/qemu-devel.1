Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC120C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:24:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA822065F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3T3tmO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA822065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jskmO-0006LF-S7
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsklk-0005p9-2L; Tue, 07 Jul 2020 06:24:08 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jskli-0003Qx-Ac; Tue, 07 Jul 2020 06:24:07 -0400
Received: by mail-wm1-x341.google.com with SMTP id a6so1426487wmm.0;
 Tue, 07 Jul 2020 03:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=n49OJ6eNQ6h3yEXOrI5/t968r1z4wUSmMEgUCt+ZiEg=;
 b=N3T3tmO7x3Kt4XJa5aQLTp5wUs7uSgmaZIa7CL2uc5BpK069PGn7DVJjtRDNF36J0y
 aFNbOLMKU8q8qv79pAn2y7FkaOIluuO2U41U3VJJ1U2/vd2J9pMpSUF6zplnlbQsh4PM
 MhCY0hHpQL+8/ChN2I6pfdMZeHftJz9yVao2sTvNdKZDWb1j4LcZL2aKyMVIOYz/rm2k
 +1/SsyMb1pYi14+VqHlo24Mu890cxXD5QOUm0xTO0I83MSwRkcwjueS6wMkSbELuEL0Z
 TGNOnfCfcYhUOX3c7WC32L/htgUF3/9cP8fJpofuj3+vBVSrB8jSrZcQV6SG0RsQmU2N
 qU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n49OJ6eNQ6h3yEXOrI5/t968r1z4wUSmMEgUCt+ZiEg=;
 b=XVGb+ObxX4ywfChqYJ9dlhbmeGAwXAjk67zxssH8lEXvbB55BIbfFmpMqfQuW0+3Qk
 s5tltXDzxvAVVxQBSuDk0z4A7wSt5sbpGO9c6dvMZBeVy9NvfcBcnFF1Db00LibsH6Xl
 nwyfX/EVRjEjpVc/aiRW2YizRw1gAqoLpkdCB130qmCQPg34fjUAPZc16FcM2gR7wBOv
 f5gE9P/aHF4RyuNG1DuKHGZ7S+60lOU6eZ/4uOWvdENi4e0IxAIKLGosHXSQspLVAer0
 53/PaW9ELJztg9KLKRuAQjeURcX+m7y0PpmuH3eTajuaxclPhz+4+y2RnNvqxo3S696h
 tlJw==
X-Gm-Message-State: AOAM530nA8Ul+j1Tr33CHgWJ1uLFxAaxdpSkt/yL2yLr84pbKtvD7UFX
 fy/zXUXhs0sCrHbV6wbAB1g=
X-Google-Smtp-Source: ABdhPJyM9iCLdXB+xBNgzIn8+F/Dwys7z3lxhnajGhxwAKVTe5eC7X0eMdOYYcimP9hBUPRa2fgk6Q==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr3633749wml.95.1594117444458; 
 Tue, 07 Jul 2020 03:24:04 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id c20sm488541wrb.65.2020.07.07.03.24.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 03:24:03 -0700 (PDT)
Subject: Re: [PATCH v7 05/17] hw/sd/sdcard: Do not switch to ReceivingData if
 address is invalid
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-6-f4bug@amsat.org>
 <CAP+75-V-Uu8-Uk8jMwkgb3xJpFoef=k6p=ejaY4=+njkdb3ZeQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3b0a65bc-97a7-9f49-da3a-5c680c4b5722@amsat.org>
Date: Tue, 7 Jul 2020 12:24:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAP+75-V-Uu8-Uk8jMwkgb3xJpFoef=k6p=ejaY4=+njkdb3ZeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 10:30 AM, Philippe Mathieu-Daudé wrote:
> On Tue, Jun 30, 2020 at 3:39 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Only move the state machine to ReceivingData if there is no
>> pending error. This avoids later OOB access while processing
>> commands queued.
>>
>>   "SD Specifications Part 1 Physical Layer Simplified Spec. v3.01"
>>
>>   4.3.3 Data Read
>>
>>   Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>>   occurred and no data transfer is performed.
>>
>>   4.3.4 Data Write
>>
>>   Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
>>   occurred and no data transfer is performed.
>>
>> WP_VIOLATION errors are not modified: the error bit is set, we
>> stay in receive-data state, wait for a stop command. All further
>> data transfer is ignored. See the check on sd->card_status at the
>> beginning of sd_read_data() and sd_write_data().
>>
>> Fixes: CVE-2020-13253
>> Cc: Prasad J Pandit <pjp@fedoraproject.org>
>> Reported-by: Alexander Bulekov <alxndr@bu.edu>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1880822
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> v4: Only modify ADDRESS_ERROR, not WP_VIOLATION (pm215)
>> ---
>>  hw/sd/sd.c | 34 ++++++++++++++++++++++------------
>>  1 file changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 04451fdad2..7e0d684aca 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -1167,13 +1167,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>>      case 17:   /* CMD17:  READ_SINGLE_BLOCK */
>>          switch (sd->state) {
>>          case sd_transfer_state:
>> -            sd->state = sd_sendingdata_state;
>> -            sd->data_start = addr;
>> -            sd->data_offset = 0;
>>
>>              if (sd->data_start + sd->blk_len > sd->size) {
>>                  sd->card_status |= ADDRESS_ERROR;
>> +                return sd_r1;
>>              }
>> +
>> +            sd->state = sd_sendingdata_state;
>> +            sd->data_start = addr;
>> +            sd->data_offset = 0;
>>              return sd_r1;
>>
>>          default:
>> @@ -1184,13 +1186,15 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>>      case 18:   /* CMD18:  READ_MULTIPLE_BLOCK */
>>          switch (sd->state) {
>>          case sd_transfer_state:
>> -            sd->state = sd_sendingdata_state;
>> -            sd->data_start = addr;
>> -            sd->data_offset = 0;
>>
>>              if (sd->data_start + sd->blk_len > sd->size) {
>>                  sd->card_status |= ADDRESS_ERROR;
>> +                return sd_r1;
> 
> Unfortunately this breaks guests (Linux at least) when sd->size is not
> a power of 2,
> as Linux doesn't expect unrealistic SD card sizes.

I can use blk_truncate() to expand the image (which must be RW anyway)
to the ceil pow2 with something like:

-- >8 --
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b44999c864..052934f867 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2121,11 +2121,28 @@ static void sd_realize(DeviceState *dev, Error
**errp)
     }

     if (sd->blk) {
+        int64_t blk_size;
+
         if (blk_is_read_only(sd->blk)) {
             error_setg(errp, "Cannot use read-only drive as SD card");
             return;
         }

+        blk_size = blk_getlength(sd->blk);
+        if (blk_size > 0) {
+            int64_t blk_size_aligned = pow2ceil(blk_size);
+
+            if (blk_size != blk_size_aligned) {
+                ret = blk_truncate(sd->blk, blk_size_aligned, false,
+                                   PREALLOC_MODE_FALLOC,
+                                   BDRV_REQ_ZERO_WRITE, errp);
+                if (ret < 0) {
+                    error_prepend(errp, "Could not resize image: ");
+                    return;
+                }
+            }
+        }
+
         ret = blk_set_perm(sd->blk, BLK_PERM_CONSISTENT_READ |
BLK_PERM_WRITE,
                            BLK_PERM_ALL, errp);
         if (ret < 0) {
---

> 
>>              }
>> +
>> +            sd->state = sd_sendingdata_state;
>> +            sd->data_start = addr;
>> +            sd->data_offset = 0;
>>              return sd_r1;
>>
>>          default:
>> @@ -1230,14 +1234,17 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>>              /* Writing in SPI mode not implemented.  */
>>              if (sd->spi)
>>                  break;
>> +
>> +            if (sd->data_start + sd->blk_len > sd->size) {
>> +                sd->card_status |= ADDRESS_ERROR;
>> +                return sd_r1;
>> +            }
>> +
>>              sd->state = sd_receivingdata_state;
>>              sd->data_start = addr;
>>              sd->data_offset = 0;
>>              sd->blk_written = 0;
>>
>> -            if (sd->data_start + sd->blk_len > sd->size) {
>> -                sd->card_status |= ADDRESS_ERROR;
>> -            }
>>              if (sd_wp_addr(sd, sd->data_start)) {
>>                  sd->card_status |= WP_VIOLATION;
>>              }
>> @@ -1257,14 +1264,17 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>>              /* Writing in SPI mode not implemented.  */
>>              if (sd->spi)
>>                  break;
>> +
>> +            if (sd->data_start + sd->blk_len > sd->size) {
>> +                sd->card_status |= ADDRESS_ERROR;
>> +                return sd_r1;
>> +            }
>> +
>>              sd->state = sd_receivingdata_state;
>>              sd->data_start = addr;
>>              sd->data_offset = 0;
>>              sd->blk_written = 0;
>>
>> -            if (sd->data_start + sd->blk_len > sd->size) {
>> -                sd->card_status |= ADDRESS_ERROR;
>> -            }
>>              if (sd_wp_addr(sd, sd->data_start)) {
>>                  sd->card_status |= WP_VIOLATION;
>>              }
>> --
>> 2.21.3
>>

