Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00830C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 09:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CD7207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 09:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Ab2J/m7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CD7207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is10r-00049i-PB
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 04:00:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1is0yJ-0001T0-OF
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 03:57:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1is0yI-0001IE-FX
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 03:57:47 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:59730)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1is0yI-0001HJ-68; Thu, 16 Jan 2020 03:57:46 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 14A7496EF0;
 Thu, 16 Jan 2020 08:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579165064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlxfazGm/0t3DAXyUNqqisM/w91tHgd4soi9obFPYlc=;
 b=Ab2J/m7UEYaWqMy0OCjJ43fzc035O86VSSYdJOnycW1DHia6jFxl4SQn2i6R2NRJeEqIh3
 QZahQQpy/IwCg4oz1HAQxKahI24v0OmnzrADvLzu2MBkVilb3ckzV3JBULXWrj5eSH1A52
 x8Ewbe57CsrH7glcKqyxHYg3zPPGu0E=
Subject: Re: [PATCH v7 10/11] vl: replace deprecated qbus_reset_all
 registration
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
 <20200115123620.250132-11-damien.hedde@greensocs.com>
 <0cc5fa09-6014-e5aa-a7e4-de0c940a7e0b@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <e3a9b650-a035-7b3e-cf96-9c3b5a0715bf@greensocs.com>
Date: Thu, 16 Jan 2020 09:57:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0cc5fa09-6014-e5aa-a7e4-de0c940a7e0b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579165064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlxfazGm/0t3DAXyUNqqisM/w91tHgd4soi9obFPYlc=;
 b=JhN/egxpCkED3ujj2eZbeYjWhWrSc3zIm/zSfTOj1YywlfVkrqfboqgP+yaVgA3kKQDtb9
 eUGfBcmkbG71LD+4eckh3+6rNc/ot3/u9by8uMGPWGfL8RqvYm4556olDR/QFPOtq6GDGw
 Xu+uO6nmi3tOfhZhdJuX7MQ+RHzSVgU=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579165064; a=rsa-sha256; cv=none;
 b=JEUpxm4jhOHKitMwLwq22ZJrCBYjj5xMe9Mv1/SHWXwbA/ljE5ZZCC+hQ3S6bW5Nf5Gv/l
 nqvpdKv3zUm+D780qXOBUBwQ4624ZcrjldGon/ZgI2J7RO6oU9d7CWEYp9ehfh4v0zgr5V
 BB9glvd6jqBPk2aScaiAgqelYFgPMMo=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/16/20 12:44 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/15/20 1:36 PM, Damien Hedde wrote:
>> Replace deprecated qbus_reset_all by resettable_cold_reset_fn for
>> the sysbus reset registration.
>>
>> Apart for the raspi machines, this does not impact the behavior
>> because:
>> + at this point resettable just calls the old reset methods of devices
>> =C2=A0=C2=A0 and buses in the same order as qdev/qbus.
>> + resettable handlers registered with qemu_register_reset are
>> =C2=A0=C2=A0 serialized; there is no interleaving.
>> + eventual explicit calls to legacy reset API (device_reset or
>> =C2=A0=C2=A0 qdev/qbus_reset) inside this reset handler will not be ma=
sked out
>> =C2=A0=C2=A0 by resettable mechanism; they do not go through resettabl=
e api.
>>
>> For the raspi machines, during the sysbus reset the sd-card is not
>> reset twice anymore but only once. This is a consequence of switching
>> both sysbus reset and changing parent to resettable; it detects the
>> second reset is not needed. This has no impact on the state after
>> reset; the sd-card reset method only reset local state and query
>> information from the block backend.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> The raspi reset change can be observed by using the following command
>> (reset will occurs, then do Ctrl-C to end qemu; no firmware is
>> given here).
>> qemu-system-aarch64 -M raspi3 \
>> =C2=A0=C2=A0=C2=A0=C2=A0 -trace resettable_phase_hold_exec \
>> =C2=A0=C2=A0=C2=A0=C2=A0 -trace qdev_update_parent_bus \
>> =C2=A0=C2=A0=C2=A0=C2=A0 -trace resettable_change_parent \
>> =C2=A0=C2=A0=C2=A0=C2=A0 -trace qdev_reset -trace qbus_reset
>>
>> Before the patch, the qdev/qbus_reset traces show when reset method ar=
e
>> called. After the patch, the resettable_phase_hold_exec show when rese=
t
>> method are called.
>>
>> The traced reset order of the raspi3 is listed below. I've added empty
>> lines and the tree structure.
>>
>> =C2=A0 +->bcm2835-peripherals reset
>> =C2=A0 |
>> =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +->sd-card reset
>> =C2=A0 |=C2=A0=C2=A0 +->sd-bus reset
>> =C2=A0 +->bcm2835_gpio reset
>> =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> dev_update_parent_bus (move =
the sd-card on the sdhci-bus)
>> =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> resettable_change_parent
>> =C2=A0 |
>> =C2=A0 +->bcm2835-dma reset
>> =C2=A0 |
>> =C2=A0 |=C2=A0=C2=A0 +->bcm2835-sdhost-bus reset
>> =C2=A0 +->bcm2835-sdhost reset
>> =C2=A0 |
>> =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +->sd-card (reset ONLY BE=
FORE BEFORE THE PATCH)
>> =C2=A0 |=C2=A0=C2=A0 +->sdhci-bus reset
>> =C2=A0 +->generic-sdhci reset
>> =C2=A0 |
>> =C2=A0 +->bcm2835-rng reset
>> =C2=A0 +->bcm2835-property reset
>> =C2=A0 +->bcm2835-fb reset
>> =C2=A0 +->bcm2835-mbox reset
>> =C2=A0 +->bcm2835-aux reset
>> =C2=A0 +->pl011 reset
>> =C2=A0 +->bcm2835-ic reset
>> =C2=A0 +->bcm2836-control reset
>> System reset
>>
>> In both case, the sd-card is reset (being on bcm2835_gpio/sd-bus) then
>> moved
>> to generic-sdhci/sdhci-bus by the bcm2835_gpio reset method.
>>
>> Before the patch, it is then reset again being part of
>> generic-sdhci/sdhci-bus.
>> After the patch, it considered again for reset but its reset method is
>> not
>> called because it is already flagged as reset.
>=20
> I find this information helpful, have you considered including it in th=
e
> description?

I wasn't sure, I'll add it since I've to respin anyway to fix patch 3.

Thanks,
Damien

