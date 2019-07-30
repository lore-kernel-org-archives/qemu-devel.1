Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC916C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8817D20651
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="xikLSMD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8817D20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsSpI-0008Gp-SW
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 10:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57323)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hsSoQ-0006nl-1E
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hsSoO-0005IC-Uk
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:09:09 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:56814)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hsSoK-0005FG-1c; Tue, 30 Jul 2019 10:09:04 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 63AE496F52;
 Tue, 30 Jul 2019 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1564495741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=72PTcUrEl0VNBb2YbcwlUOaUC4ci2fKOleI/sbnYZek=;
 b=xikLSMD75ffLqRUBKoE5sn+zBED+AAYdUcI6+gh9YpDSf89kEjs3cJQR+aupdHORuvho/2
 /9mHIvHZwcKmEKkxQ3DM2OaD8GRVZ0kmgUUalLnGSzKX9AG5o2nz6NQ14NThjdXtdI5vU3
 geb7piyEmRNySR7I2Jxr56TMtydniwc=
To: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-2-damien.hedde@greensocs.com>
 <20190730154209.2049f10a.cohuck@redhat.com>
 <CAFEAcA-rwBiXkDEDuT-=KQVJ2A2ob16=P0obbZBPUfZeYXy+dQ@mail.gmail.com>
 <20190730155547.7b201f5e.cohuck@redhat.com>
 <CAFEAcA_BU3DECLVv2QD_RshR0OL3=GqGwsm0YAmEAE6_SpW=HA@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <34a216b0-0067-8627-599c-6a67622c4bd2@greensocs.com>
Date: Tue, 30 Jul 2019 16:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_BU3DECLVv2QD_RshR0OL3=GqGwsm0YAmEAE6_SpW=HA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1564495741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=72PTcUrEl0VNBb2YbcwlUOaUC4ci2fKOleI/sbnYZek=;
 b=wwrpUZDU/W6QlgICbr+k39DoadLRQuOFEuCbtttIuVPQd7LASm8PiCnxy+oJsXpYRfS0bO
 IJJpMhK6CrsR2atAduI/kJyyjaIIB/5Ck0bGAJZAm9yukZsmqPcz760z8Pm8fFNblaASF7
 z08mx2xAQc0ZedBZfYEkS7XuVaJUMT4=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1564495741; a=rsa-sha256; cv=none;
 b=rq1QyBpTZvoxvoaVYWal0IFKxkeyUyTTuSLpOl2QqNA7+4XW3NhAi69vDwov+v2wwaYkRx
 z3QgeeC2WREafpEBNle90r4invfcy/fcK9OQVB+7UBYyeEMOpTp8utW+DmzClFLVR4AD46
 u2sNo1puklUPzSCCuB3SHhRs9TZsLks=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v3 01/33] Create Resettable QOM interface
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 7/30/19 3:59 PM, Peter Maydell wrote:
> On Tue, 30 Jul 2019 at 14:56, Cornelia Huck <cohuck@redhat.com> wrote:
>>
>> On Tue, 30 Jul 2019 14:44:21 +0100
>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>>> On Tue, 30 Jul 2019 at 14:42, Cornelia Huck <cohuck@redhat.com> wrote:
>>>> I'm having a hard time figuring out what a 'cold' or a 'warm' reset is
>>>> supposed to be... can you add a definition/guideline somewhere?
>>>
>>> Generally "cold" reset is "power on" and "warm" is "we were already
>>> powered-on, but somebody flipped a reset line somewhere".
>>
>> Ok, that makes sense... my main concern is to distinguish that in a
>> generic way, as it is a generic interface. What about adding something
>> like:
>>
>> "A 'cold' reset means that the object to be reset is initially reset; a 'warm'
>> reset means that the object to be reset has already been initialized."
>>
>> Or is that again too generic?
> 
> I think it doesn't quite capture the idea -- an object can have already
> been reset and then get a 'cold' reset: this is like having a powered-on
> machine and then power-cycling it.
> 
> The 'warm' reset is the vaguer one, because the specific behaviour
> is somewhat device-dependent (many devices might not have any
> difference from 'cold' reset, for those that do the exact detail
> of what doesn't get reset on warm-reset will vary). But every
> device should have some kind of "as if you power-cycled it" (or
> for QEMU, "go back to the same state as if you just started QEMU on the
> command line"). Our current "reset" method is really cold-reset.
> 

Exactly. In the following patches, I've tried to replace existing reset
calls by cold or warm reset depending on whether:
+ it is called through the main system reset -> cold
+ it is called during normal life-time       -> warm

But I definitely can add some docs/comments to better explain that.

--
Damien

