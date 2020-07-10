Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D968FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FEDD207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sLUoVR4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEDD207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtoz5-0000L4-OX
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtoyO-0008CR-8Z; Fri, 10 Jul 2020 05:05:36 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtoyM-0001N9-H0; Fri, 10 Jul 2020 05:05:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id o8so5262069wmh.4;
 Fri, 10 Jul 2020 02:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VtRaGaqeK5Fmhd3uzinPBShZ5hWT56nBGj8UhYUZDyE=;
 b=sLUoVR4fYVF2b4ykl9INCfBdAkypMkDGyyf77waNfyxu4qiwx60ztVUmQZtPtvIEYI
 /m/SzjQqxncHN5s7Q5fFDFpdngMp/Dysxx94IE8E3CEVsplzXVl6z/cMdWbHzVYNjQuB
 VWncN9IEq5j4YyvU3stxbq/09BgRLqN1/mDh3OqVauDuIFmDMbfCjciJ2q/uf09DjS1H
 pcmP7Fvja0W25/nNXJvZYWl536id3DlMEN3yQe+IS17rfcV5jSq176pM0FkxFum1g4QG
 4DhZOwnVf1bISzECQCTU/VN+d91XT3qnHG2br7Kmsa/YXEhZiI+RDtH9iicy6RUm/3TP
 7UBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VtRaGaqeK5Fmhd3uzinPBShZ5hWT56nBGj8UhYUZDyE=;
 b=S++2VeU3BZL9HOBM+29Qc9emqGzQwrBDweyK39gRiVkrTSdXa+myuq1XKFHFBWGb4b
 0yPE/7ThQKo9vLhhzBqn1FOwPtYYir9MWd1xCVSoCC7j/8GmDTsanUJZ2MUaYN1C6Ze6
 s2VgtsWbYOSx7VZZUh89A/Sv0jK4fLkfkfu2ccRAE6Ajg3pI2GxNqKRtALLeVQ+BXRe8
 ARGRV+CfRVtdZKJfvaw2Wu3dUhEG0yN9ahRUE7f4zTy3NYPmDD1tRwytY2TtBB48amel
 WXMn4+95PQt3ispc19S6Axm6ZWc/A36OaIizGneAR/EOC3fhpVZ1/Rf74X542KLQGVU6
 lSsw==
X-Gm-Message-State: AOAM530tZLdAOeLdKN6FoAc9kNRdbm3rtQbOQOh71cAn/PJSgM0Px8DG
 l+e1UpLAnb54Z06TzON8oEw=
X-Google-Smtp-Source: ABdhPJwilUNwl7Pq7cd/WsJN1LZauk8G4qKp5a7U5II0maNHt5T0q0gIJfZz8eAThXfgGzCl52RNWg==
X-Received: by 2002:a7b:c746:: with SMTP id w6mr4393211wmk.171.1594371930981; 
 Fri, 10 Jul 2020 02:05:30 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id o21sm8365782wmh.18.2020.07.10.02.05.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 02:05:30 -0700 (PDT)
Subject: Re: [RFC PATCH 2/3] hw/i2c/smbus_eeprom: Add description based on
 child name
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200626102744.15053-1-f4bug@amsat.org>
 <20200626102744.15053-3-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2006261255120.94870@zero.eik.bme.hu>
 <5895e827-68e9-8204-aeba-e066d8c0d680@amsat.org>
 <20200709194822.GJ780932@habkost.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d5cab3f9-7685-a705-3414-838cf0b2c49c@amsat.org>
Date: Fri, 10 Jul 2020 11:05:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709194822.GJ780932@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Stefan for tracing PoV

On 7/9/20 9:48 PM, Eduardo Habkost wrote:
> On Fri, Jun 26, 2020 at 04:26:33PM +0200, Philippe Mathieu-DaudÃ© wrote:
>> On 6/26/20 1:00 PM, BALATON Zoltan wrote:
>>> On Fri, 26 Jun 2020, Philippe Mathieu-DaudÃ© wrote:
>>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
>>>> ---
>>>> hw/i2c/smbus_eeprom.c | 3 +++
>>>> 1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
>>>> index 879fd7c416..22ba7b20d4 100644
>>>> --- a/hw/i2c/smbus_eeprom.c
>>>> +++ b/hw/i2c/smbus_eeprom.c
>>>> @@ -47,6 +47,7 @@ typedef struct SMBusEEPROMDevice {
>>>> Â Â Â  uint8_t *init_data;
>>>> Â Â Â  uint8_t offset;
>>>> Â Â Â  bool accessed;
>>>> +Â Â Â  char *description;
>>>> } SMBusEEPROMDevice;
>>>>
>>>> static uint8_t eeprom_receive_byte(SMBusDevice *dev)
>>>> @@ -134,7 +135,9 @@ static void smbus_eeprom_realize(DeviceState *dev,
>>>> Error **errp)
>>>> Â Â Â  smbus_eeprom_reset(dev);
>>>> Â Â Â  if (eeprom->init_data == NULL) {
>>>> Â Â Â Â Â Â Â  error_setg(errp, "init_data cannot be NULL");
>>>> +Â Â Â Â Â Â Â  return;
>>>> Â Â Â  }
>>>> +Â Â Â  eeprom->description =
>>>> object_get_canonical_path_component(OBJECT(dev));
>>>> }
>>>>
>>>> static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
>>>
>>> What is this for? Shouldn't this description field be in some parent
>>> object and whatever wants to print it could use the
>>> object_get_canonical_path_component() as default value if it's not set
>>> instead of adding more boiler plate to every object?
>>
>> You are right, if we want to use this field generically, it should be
>> a static Object field. I'll defer that question to Eduardo/Markus.
> 
> I don't understand what's the question here.  What would be the
> purpose of a static Object field, and why it would be better than
> simply calling object_get_canonical_path_component() when you
> need it?

Because when reading a 8KB EEPROM with tracing enabled we end
up calling:

8192 g_hash_table_iter_init()
8192 g_hash_table_iter_next()
8192 object_property_iter_init()
8192 object_property_iter_next()
8192 g_hash_table_add()
8192 g_strdup()
8192 g_free()

Which is why I added the SMBusEEPROMDeviceState::description
field, to call it once and cache it. But Zoltan realized this
could benefit all QOM objects, not this single one.

So the question is, is it OK to make this a cached field
in object_get_canonical_path_component()?

Something like (incomplete):

-- >8 --
--- a/qom/object.c
+++ b/qom/object.c
@@ -642,6 +642,7 @@ static void object_property_del_child(Object *obj,
Object *child)
             break;
         }
     }
+    g_free(child->canonical_path_component);
 }

 void object_unparent(Object *obj)
@@ -1666,6 +1667,7 @@ object_property_add_child(Object *obj, const char
*name,
     op->resolve = object_resolve_child_property;
     object_ref(child);
     child->parent = obj;
+    child->canonical_path_component =
object_get_canonical_path_component(child);
     return op;
 }

@@ -1901,6 +1903,10 @@ char *object_get_canonical_path_component(const
Object *obj)
         return NULL;
     }

+    if (obj->canonical_path_component) {
+        return obj->canonical_path_component;
+    }
+
     g_hash_table_iter_init(&iter, obj->parent->properties);
     while (g_hash_table_iter_next(&iter, NULL, (gpointer *)&prop)) {
         if (!object_property_is_child(prop)) {
@@ -1908,7 +1914,8 @@ char *object_get_canonical_path_component(const
Object *obj)
         }

         if (prop->opaque == obj) {
-            return g_strdup(prop->name);
+            obj->canonical_path_component_cached = g_strdup(prop->name);
+            return obj->canonical_path_component_cached;
         }
     }

---

