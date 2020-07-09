Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F76C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1B0206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9hTl2BJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1B0206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtcXx-0000jH-Sw
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtcX3-0007u7-WD
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:48:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44426
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtcX1-00014e-Bq
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594324110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFfA0qcui2ENuDo7HtKumZfSJ/Tnhf0pY0BbFNAWXuo=;
 b=W9hTl2BJX0J6Y/27LIQEpOVBCFir9q7Sg3dFg+V4ICKbA2vuXPXli7pgfRXajG4iKmirTQ
 7gkT7HW0xlzHcrc6a/OOQFP494XEOIg+sAjCh6xYded2WOUi94/zSWczOO3lgT49vGVYOP
 a0G9MpRxoXoYsuxGU/R/evkfqNn5MQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-tARpYom-MX6rHLMzY2md6Q-1; Thu, 09 Jul 2020 15:48:27 -0400
X-MC-Unique: tARpYom-MX6rHLMzY2md6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D06218FF67B;
 Thu,  9 Jul 2020 19:48:24 +0000 (UTC)
Received: from localhost (ovpn-116-140.rdu2.redhat.com [10.10.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECD165DC1E;
 Thu,  9 Jul 2020 19:48:22 +0000 (UTC)
Date: Thu, 9 Jul 2020 15:48:22 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 2/3] hw/i2c/smbus_eeprom: Add description based on
 child name
Message-ID: <20200709194822.GJ780932@habkost.net>
References: <20200626102744.15053-1-f4bug@amsat.org>
 <20200626102744.15053-3-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2006261255120.94870@zero.eik.bme.hu>
 <5895e827-68e9-8204-aeba-e066d8c0d680@amsat.org>
MIME-Version: 1.0
In-Reply-To: <5895e827-68e9-8204-aeba-e066d8c0d680@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:02:51
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
 Huacai Chen <chenhc@lemote.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 04:26:33PM +0200, Philippe Mathieu-Daudé wrote:
> On 6/26/20 1:00 PM, BALATON Zoltan wrote:
> > On Fri, 26 Jun 2020, Philippe Mathieu-Daudé wrote:
> >> Suggested-by: Markus Armbruster <armbru@redhat.com>
> >> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> >> ---
> >> hw/i2c/smbus_eeprom.c | 3 +++
> >> 1 file changed, 3 insertions(+)
> >>
> >> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> >> index 879fd7c416..22ba7b20d4 100644
> >> --- a/hw/i2c/smbus_eeprom.c
> >> +++ b/hw/i2c/smbus_eeprom.c
> >> @@ -47,6 +47,7 @@ typedef struct SMBusEEPROMDevice {
> >>     uint8_t *init_data;
> >>     uint8_t offset;
> >>     bool accessed;
> >> +    char *description;
> >> } SMBusEEPROMDevice;
> >>
> >> static uint8_t eeprom_receive_byte(SMBusDevice *dev)
> >> @@ -134,7 +135,9 @@ static void smbus_eeprom_realize(DeviceState *dev,
> >> Error **errp)
> >>     smbus_eeprom_reset(dev);
> >>     if (eeprom->init_data == NULL) {
> >>         error_setg(errp, "init_data cannot be NULL");
> >> +        return;
> >>     }
> >> +    eeprom->description =
> >> object_get_canonical_path_component(OBJECT(dev));
> >> }
> >>
> >> static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
> > 
> > What is this for? Shouldn't this description field be in some parent
> > object and whatever wants to print it could use the
> > object_get_canonical_path_component() as default value if it's not set
> > instead of adding more boiler plate to every object?
> 
> You are right, if we want to use this field generically, it should be
> a static Object field. I'll defer that question to Eduardo/Markus.

I don't understand what's the question here.  What would be the
purpose of a static Object field, and why it would be better than
simply calling object_get_canonical_path_component() when you
need it?

-- 
Eduardo


