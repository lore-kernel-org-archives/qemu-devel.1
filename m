Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1233BC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCB652166E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Hw7UAQmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB652166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw29W-0003eX-0f
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 06:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58432)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hw293-00034H-0f
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hw292-00033c-1A
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:29:12 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:51732)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hw28x-00030E-7N; Fri, 09 Aug 2019 06:29:07 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 44EAE96F50;
 Fri,  9 Aug 2019 10:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1565346544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgH8+Jtmb8Flk6Bl2dKnmZkcQbQKlmxYOkiF91XUwaA=;
 b=Hw7UAQmi3c/Xh/c602SGXucij37xyGq0I9R8neKC08MMyyCzUWYy6iQmkMaY5C7v4u256G
 HOS8iryjDt6Q/42icn03tX3FmHW0LbIEKwiN1zYPKNP2/ZMVhhxW0rjiFbKcFkrR59rQEv
 CQo20cfwJXwERfaOGrcLR68zCe3ISd4=
To: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-8-damien.hedde@greensocs.com>
 <CAFEAcA-W0SaaGbUnGZ0b61ngxKY8R9xjwGXeN+=MaUi4bMDgNg@mail.gmail.com>
 <20190808154219.GK2852@work-vm>
 <CAFEAcA8L2YVMCu3Gb+eQTDfCpgVwA_WwVPrqPLV2iQ9rZ4HuTA@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <f400248f-7a3b-83e9-3355-77de359e3f43@greensocs.com>
Date: Fri, 9 Aug 2019 12:29:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8L2YVMCu3Gb+eQTDfCpgVwA_WwVPrqPLV2iQ9rZ4HuTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1565346544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgH8+Jtmb8Flk6Bl2dKnmZkcQbQKlmxYOkiF91XUwaA=;
 b=EVsGV7ketZz3CBHQJ2PdJUiirtxLhK6uVQtUQc5XVN5VSJAo63LigQqa1+DEMHDuUs/7Uy
 NwcNVzqhLSG4Nhqai2Hp3e6q7myvKs+EmklfWD1UKsJu1Zlu+wXYoJNyMLNxmSU8PSyrAD
 J/Km6RTi+yqCkvrN00cK6eEO9X2zfM0=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1565346544; a=rsa-sha256; cv=none;
 b=toQRxkOobF7nRY1Gh5DESWmF5PogFrAKijyEdi7QxAUAimMch9pm7r+CPK3H4D/5yMJop+
 3oqEzMD8hespC9DhxDjEzcsPdHnkVwbZCNIrtt87ymkQhCt0s34hdNg2u7L0n8tR+TFO/N
 eLb57aPTPKPhImHqelFH6n8QESueU9g=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v3 07/33] automatically add vmstate for
 reset support in devices
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
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/9/19 12:07 PM, Peter Maydell wrote:
> On Thu, 8 Aug 2019 at 16:42, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>>
>> * Peter Maydell (peter.maydell@linaro.org) wrote:
>>> On Mon, 29 Jul 2019 at 15:59, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>>>
>>>> This add the reset related sections for every QOM
>>>> device.
>>>
>>> A bit more detail in the commit message would help, I think --
>>> this is adding extra machinery which has to copy and modify
>>> the VMStateDescription passed in by the device in order to
>>> add the subsection that handles reset.
>>>
>>> I've added Dave Gilbert to the already long cc list since this
>>> is migration related.
>>
>> I don't like dynamically modifying all the vmsds.
> 
> Yeah, I'm not a huge fan of it either, but it does mean that
> the state gets migrated and we don't have a pile of really
> easy to miss bugs where we forgot to say "this device needs to
> migrate the reset state" and it means we don't have every
> device we ever write in the future needing to say "this device
> needs to migrate reset state"...
> 
>> Aren't you going to have to understand each devices reset behaviour
>> and make sure it does something sane? e.g. it might have a postload
>> that registers a timer or something that you wouldn't want to do if it's
>> in reset.
>>
>> The easiest way is to write a macro that you can easily add to devices
>> you've checked subsection list (like the way we have a
>> VMSTATE_USB_DEVICE).
> 
> One problem is that as soon as somebody writes a USB controller
> or PCI controller model that can be held in reset, every
> device that could sat behind it automatically now could find
> that it's migrated while it's in reset.
> 

One way to keep the feature without copy-pasting vmsd would be to add
a new vmstate_register with an additional argument to pass the base
class vmsd section and handle the whole thing there.

--
Damien

