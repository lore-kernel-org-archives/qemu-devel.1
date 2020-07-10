Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20FDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:41:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD722076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhdNjkcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD722076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtx24-0008Gr-UL
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 13:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtx1N-0007kt-Vv
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:41:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46594
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtx1K-0008UU-M0
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594402868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYb6mfNBooVLy5t/f0U26VmaJBlBSkfcDFbHJi1Hq+4=;
 b=VhdNjkcH2sZhy3Rz3cLegXwQrPkAFD3IqpOWCQGssD+Xnn9TF0jO5AX7ul24Os74/QWpp2
 YJWOgQOp8ChmgiFEpvE7Gvo2fQq5SgHeBGewPoMJG3mVGvkAZjHjpGRqEcLTpa22KZEYZS
 tZgaICSezySyxx0bggoIl4hMxE47WjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-nNV99OyQNRqbJJZ8BNnmnw-1; Fri, 10 Jul 2020 13:41:05 -0400
X-MC-Unique: nNV99OyQNRqbJJZ8BNnmnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53A42106B242;
 Fri, 10 Jul 2020 17:41:00 +0000 (UTC)
Received: from localhost (ovpn-116-140.rdu2.redhat.com [10.10.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2C6178A46;
 Fri, 10 Jul 2020 17:40:55 +0000 (UTC)
Date: Fri, 10 Jul 2020 13:40:54 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 2/3] hw/i2c/smbus_eeprom: Add description based on
 child name
Message-ID: <20200710174054.GS780932@habkost.net>
References: <20200626102744.15053-1-f4bug@amsat.org>
 <20200626102744.15053-3-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2006261255120.94870@zero.eik.bme.hu>
 <5895e827-68e9-8204-aeba-e066d8c0d680@amsat.org>
 <20200709194822.GJ780932@habkost.net>
 <d5cab3f9-7685-a705-3414-838cf0b2c49c@amsat.org>
MIME-Version: 1.0
In-Reply-To: <d5cab3f9-7685-a705-3414-838cf0b2c49c@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 11:05:29AM +0200, Philippe Mathieu-Daudé wrote:
> +Stefan for tracing PoV
> 
> On 7/9/20 9:48 PM, Eduardo Habkost wrote:
> > On Fri, Jun 26, 2020 at 04:26:33PM +0200, Philippe Mathieu-DaudÃ© wrote:
> >> On 6/26/20 1:00 PM, BALATON Zoltan wrote:
> >>> On Fri, 26 Jun 2020, Philippe Mathieu-DaudÃ© wrote:
> >>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
> >>>> Signed-off-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>
> >>>> ---
> >>>> hw/i2c/smbus_eeprom.c | 3 +++
> >>>> 1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> >>>> index 879fd7c416..22ba7b20d4 100644
> >>>> --- a/hw/i2c/smbus_eeprom.c
> >>>> +++ b/hw/i2c/smbus_eeprom.c
> >>>> @@ -47,6 +47,7 @@ typedef struct SMBusEEPROMDevice {
> >>>> Â Â Â  uint8_t *init_data;
> >>>> Â Â Â  uint8_t offset;
> >>>> Â Â Â  bool accessed;
> >>>> +Â Â Â  char *description;
> >>>> } SMBusEEPROMDevice;
> >>>>
> >>>> static uint8_t eeprom_receive_byte(SMBusDevice *dev)
> >>>> @@ -134,7 +135,9 @@ static void smbus_eeprom_realize(DeviceState *dev,
> >>>> Error **errp)
> >>>> Â Â Â  smbus_eeprom_reset(dev);
> >>>> Â Â Â  if (eeprom->init_data == NULL) {
> >>>> Â Â Â Â Â Â Â  error_setg(errp, "init_data cannot be NULL");
> >>>> +Â Â Â Â Â Â Â  return;
> >>>> Â Â Â  }
> >>>> +Â Â Â  eeprom->description =
> >>>> object_get_canonical_path_component(OBJECT(dev));
> >>>> }
> >>>>
> >>>> static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
> >>>
> >>> What is this for? Shouldn't this description field be in some parent
> >>> object and whatever wants to print it could use the
> >>> object_get_canonical_path_component() as default value if it's not set
> >>> instead of adding more boiler plate to every object?
> >>
> >> You are right, if we want to use this field generically, it should be
> >> a static Object field. I'll defer that question to Eduardo/Markus.
> > 
> > I don't understand what's the question here.  What would be the
> > purpose of a static Object field, and why it would be better than
> > simply calling object_get_canonical_path_component() when you
> > need it?
> 
> Because when reading a 8KB EEPROM with tracing enabled we end
> up calling:
> 
> 8192 g_hash_table_iter_init()
> 8192 g_hash_table_iter_next()
> 8192 object_property_iter_init()
> 8192 object_property_iter_next()
> 8192 g_hash_table_add()
> 8192 g_strdup()
> 8192 g_free()
> 
> Which is why I added the SMBusEEPROMDeviceState::description
> field, to call it once and cache it. But Zoltan realized this
> could benefit all QOM objects, not this single one.
> 
> So the question is, is it OK to make this a cached field
> in object_get_canonical_path_component()?

That's what I was thinking of, but now I see that
object_get_canonical_path_component() is an inconvenient API
because it requires callers to g_free() the return value.

We could change object_get_canonical_path_component() to not
require callers to call g_free(), or create a new mechanism to
get the object name like you suggested (and then get rid of most
of the existing uses of object_get_canonical_path_component()).

> 
> Something like (incomplete):
> 
> -- >8 --
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -642,6 +642,7 @@ static void object_property_del_child(Object *obj,
> Object *child)
>              break;
>          }
>      }
> +    g_free(child->canonical_path_component);
>  }
> 
>  void object_unparent(Object *obj)
> @@ -1666,6 +1667,7 @@ object_property_add_child(Object *obj, const char
> *name,
>      op->resolve = object_resolve_child_property;
>      object_ref(child);
>      child->parent = obj;
> +    child->canonical_path_component =
> object_get_canonical_path_component(child);
>      return op;
>  }
> 
> @@ -1901,6 +1903,10 @@ char *object_get_canonical_path_component(const
> Object *obj)
>          return NULL;
>      }
> 
> +    if (obj->canonical_path_component) {
> +        return obj->canonical_path_component;
> +    }
> +
>      g_hash_table_iter_init(&iter, obj->parent->properties);
>      while (g_hash_table_iter_next(&iter, NULL, (gpointer *)&prop)) {
>          if (!object_property_is_child(prop)) {
> @@ -1908,7 +1914,8 @@ char *object_get_canonical_path_component(const
> Object *obj)
>          }
> 
>          if (prop->opaque == obj) {
> -            return g_strdup(prop->name);
> +            obj->canonical_path_component_cached = g_strdup(prop->name);
> +            return obj->canonical_path_component_cached;
>          }
>      }
> 
> ---
> 

-- 
Eduardo


