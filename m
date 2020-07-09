Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0E6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 20:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0117B20720
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 20:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ym14bw4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0117B20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtco6-0005zs-8o
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 16:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtcnV-0005SZ-JB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 16:05:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32130
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jtcnS-0003Dc-PB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 16:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594325129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W2q7I8gvxsFtfxkbrn9/QdgFjqTF/FcwOuih7aHaZOY=;
 b=Ym14bw4WcDrA+9I90DxgRhgEtTHixx8E3+I0ENivkn2cFCaIhuNOWvNKEuys1ODuksH4dP
 3jV56jHcfGrkPDORMrq8eetLAUkPaXi1eb+CoV20u8dScRA93uCH/DDgeVw4ZYwDc+WUZy
 HL85rZT8LsCk6mjGBnYoFYsO3JXYwN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-NaoIvGxAOFWxjpaaEOIyZg-1; Thu, 09 Jul 2020 16:05:27 -0400
X-MC-Unique: NaoIvGxAOFWxjpaaEOIyZg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AC77800D5C;
 Thu,  9 Jul 2020 20:05:25 +0000 (UTC)
Received: from localhost (ovpn-116-140.rdu2.redhat.com [10.10.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8040419D7C;
 Thu,  9 Jul 2020 20:05:24 +0000 (UTC)
Date: Thu, 9 Jul 2020 16:05:23 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 1/3] hw/i2c/smbus_eeprom: Set QOM parent
Message-ID: <20200709200523.GK780932@habkost.net>
References: <20200626102744.15053-1-f4bug@amsat.org>
 <20200626102744.15053-2-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2006261240500.94870@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2006261251480.94870@zero.eik.bme.hu>
 <f7da6118-a27a-a09d-9c8f-92cbf2eca96f@amsat.org>
 <alpine.BSF.2.22.395.2006261557050.56498@zero.eik.bme.hu>
 <4825239e-1e75-a401-2068-a8c14c38f60b@amsat.org>
MIME-Version: 1.0
In-Reply-To: <4825239e-1e75-a401-2068-a8c14c38f60b@amsat.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:25:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Alistair Francis <alistair@alistair23.me>,
 Markus Armbruster <armbru@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-ppc@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Huacai Chen <chenhc@lemote.com>, Fred Konrad <konrad@adacore.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 04:15:40PM +0200, Philippe Mathieu-Daudé wrote:
> On 6/26/20 4:03 PM, BALATON Zoltan wrote:
> > On Fri, 26 Jun 2020, Philippe Mathieu-Daudé wrote:
> >> + Eduardo / Mark / Edgard / Alistair / Fred for QOM design.
> >>
> >> On 6/26/20 12:54 PM, BALATON Zoltan wrote:
> >>> On Fri, 26 Jun 2020, BALATON Zoltan wrote:
> >>>> On Fri, 26 Jun 2020, Philippe Mathieu-Daudé wrote:
> >>>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
> >>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> >>>>> ---
> >>>>> Aspeed change pending latest ARM pull-request, so meanwhile sending
> >>>>> as RFC.
> >>>>> ---
> >>>>> include/hw/i2c/smbus_eeprom.h |  9 ++++++---
> >>>>> hw/i2c/smbus_eeprom.c         | 13 ++++++++++---
> >>>>> hw/mips/fuloong2e.c           |  2 +-
> >>>>> hw/ppc/sam460ex.c             |  2 +-
> >>>>> 4 files changed, 18 insertions(+), 8 deletions(-)
> >>>>>
> >>>>> diff --git a/include/hw/i2c/smbus_eeprom.h
> >>>>> b/include/hw/i2c/smbus_eeprom.h
> >>>>> index 68b0063ab6..037612bbbb 100644
> >>>>> --- a/include/hw/i2c/smbus_eeprom.h
> >>>>> +++ b/include/hw/i2c/smbus_eeprom.h
> >>>>> @@ -26,9 +26,12 @@
> >>>>> #include "exec/cpu-common.h"
> >>>>> #include "hw/i2c/i2c.h"
> >>>>>
> >>>>> -void smbus_eeprom_init_one(I2CBus *bus, uint8_t address, uint8_t
> >>>>> *eeprom_buf);
> >>>>> -void smbus_eeprom_init(I2CBus *bus, int nb_eeprom,
> >>>>> -                       const uint8_t *eeprom_spd, int size);
> >>>>> +void smbus_eeprom_init_one(Object *parent_obj, const char
> >>>>> *child_name,
> >>>>> +                           I2CBus *smbus, uint8_t address,
> >>>>> +                           uint8_t *eeprom_buf);
> >>>>> +void smbus_eeprom_init(Object *parent_obj, const char
> >>>>> *child_name_prefix,
> >>>>> +                       I2CBus *smbus, int nb_eeprom,
> >>>>> +                       const uint8_t *eeprom_spd, int
> >>>>> eeprom_spd_size);
> >>>>
> >>>> Keeping I2CBus *smbus and uint8_t address as first parameters before
> >>>> parent_obj and name looks better to me. These functions still operate
> >>>> on an I2Cbus so could be regarded as methods of I2CBus therefore first
> >>>> parameter should be that.
> >>>
> >>> Also isn't parent_obj is the I2Cbus itself? Why is that need to be
> >>> passed? The i2c_init_bus() also takes parent and name params so both
> >>> I2Cbus and it's parent should be available as parents of the new I2C
> >>> device here without more parameters. What am I missing here?
> >>
> >> This is where I'm confused too and what I want to resolve with this
> >> RFC series :)
> >>
> >> The SPD EEPROM is soldered on the DIMM module. The DIMM exposes the
> >> memory address/data pins and the i2c pins. We plug DIMMs on a
> >> (mother)board.
> >>
> >> I see the DIMM module being the parent. As we don't model it in QOM,
> >> I used the MemoryRegion (which is what the SPD is describing).
> >>
> >> We could represent the DIMM as a container of DRAM + SPD EEPROM, but
> >> it makes the modeling slightly more complex. The only benefit is a
> >> clearer modeling.
> >>
> >> I'm not sure why the I2C bus is expected to be the parent. Maybe an
> >> old wrong assumption?
> > 
> > I guess it's a question of what the parent should mean? Is it parent of
> > the object in which case it's the I2CBus (which is kind of logical view
> > of the object tree modelling the machine) or the parent of the thing
> > modelled in the machine (which is physical view of the machine
> > components) then it should be the RAM module. The confusion probably
> > comes from this question not answered. Also the DIMM module is not
> > modelled so when you assign SPD eeproms to memory region it could be
> > multiple SPD eeproms will be parented by a single RAM memory region
> > (possibly not covering it fully as in the mac_oldworld or sam460ex case
> > discussed in another thread). This does not seem too intuitive.
> 
> From the bus perspective, requests are sent hoping for a device to
> answer to the requested address ("Hello, do I have children? Hello?
> Anybody here?"), if nobody is here, the request timeouts.
> So there is not really a strong family relationship here.
> 
> If you unplug a DIMM, you remove both the MemoryRegion and the EEPROM.
> This is how I understand the QOM parent relationship so far (if you
> remove a parent, you also remove its children).

I'll be honest: I don't think I understand the main purpose of
QOM parent/child relationships.  My best guess is that they make
object destruction easier to manage (if you destroy a parent, you
will automatically destroy its children).

If we don't write down what QOM parent/child relationships are
supposed to mean (and what they are _not_ supposed to mean), we
will never know when it's appropriate and/or safe to move objects
to a different parent.

-- 
Eduardo


