Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19361C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 09:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEF6E20665
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 09:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF6E20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht7Qm-0008IP-3L
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 05:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37968)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dinechin@redhat.com>) id 1ht7Pr-0007RB-Ht
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 05:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1ht7Pq-0004n4-0d
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 05:30:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1ht7Pp-0004lP-NN
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 05:30:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so63857048wmj.5
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 02:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=rSBf+hMp7mNZH0X3uZW/tGO01XaR2AGWxL6Qb+qfGB4=;
 b=glxcyzvXJcmMMTTbyIheIE+bpYvTWxAzAlqutJM5NqNqLNSJO9JMX4xR9FkwC99Oe3
 IsmiQjOv+x4XhHKXS9uuR9VlvV0I/TK9JRYa4i13Mxc3F20XkCS6pGodzGXLTu4Sw6UH
 TPqDEt4snZhuQ8jBzdogNX8RMF6Tpqf+eMQoG0neDOH6uiO+nH66zJZccHVV6QOUMrhT
 ZQfjysPFZwTVJk0S0Il4j0A5GqX/fMFaJ3Nirg22fQGTnbyZd8clJjBep0OANCA2Qr5t
 +iVm6bry39+L2F1JwcV2KBEICANAHm6Htw1lhTB4k1J6yPxVSPWD4LoGa5zfh3ooK4/x
 eYIg==
X-Gm-Message-State: APjAAAV72CZg2/lTstqkKBMoIYr7ukuiDXOvYgM+R0MCYO9chIx9gxQe
 TBupqwrRlNPLJMwtEXaAa5p1/Q==
X-Google-Smtp-Source: APXvYqxodtK412GWsoA84KlQ6lj4JHVTLeNyydHpfODc1V0W6jCjLXpuMSk9V/HjnxdLRqTuZ8Zv2Q==
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr35084915wml.157.1564651827890; 
 Thu, 01 Aug 2019 02:30:27 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8b6a:1220:15bb:5ab9:f15b:4915?
 ([2a01:e35:8b6a:1220:15bb:5ab9:f15b:4915])
 by smtp.gmail.com with ESMTPSA id o7sm40949827wru.58.2019.08.01.02.30.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Aug 2019 02:30:26 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Christophe de Dinechin <dinechin@redhat.com>
In-Reply-To: <e42eac74-b5f7-badd-f5e6-4423c8608a85@greensocs.com>
Date: Thu, 1 Aug 2019 11:30:24 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <27CBAC99-48ED-48A3-AAFD-97BE9966C00F@redhat.com>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-2-damien.hedde@greensocs.com>
 <20190730154209.2049f10a.cohuck@redhat.com>
 <CAFEAcA-rwBiXkDEDuT-=KQVJ2A2ob16=P0obbZBPUfZeYXy+dQ@mail.gmail.com>
 <20190730155547.7b201f5e.cohuck@redhat.com>
 <CAFEAcA_BU3DECLVv2QD_RshR0OL3=GqGwsm0YAmEAE6_SpW=HA@mail.gmail.com>
 <m1y30emrsh.fsf@redhat.com>
 <e42eac74-b5f7-badd-f5e6-4423c8608a85@greensocs.com>
To: Damien Hedde <damien.hedde@greensocs.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Hannes Reinecke <hare@suse.com>, Qemu-block <qemu-block@nongnu.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 1 Aug 2019, at 11:19, Damien Hedde <damien.hedde@greensocs.com> =
wrote:
>=20
>=20
> On 7/31/19 12:17 PM, Christophe de Dinechin wrote:
>>=20
>> Peter Maydell writes:
>>=20
>>> On Tue, 30 Jul 2019 at 14:56, Cornelia Huck <cohuck@redhat.com> =
wrote:
>>>>=20
>>>> On Tue, 30 Jul 2019 14:44:21 +0100
>>>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>>>=20
>>>>> On Tue, 30 Jul 2019 at 14:42, Cornelia Huck <cohuck@redhat.com> =
wrote:
>>>>>> I'm having a hard time figuring out what a 'cold' or a 'warm' =
reset is
>>>>>> supposed to be... can you add a definition/guideline somewhere?
>>>>>=20
>>>>> Generally "cold" reset is "power on" and "warm" is "we were =
already
>>>>> powered-on, but somebody flipped a reset line somewhere".
>>>>=20
>>>> Ok, that makes sense... my main concern is to distinguish that in a
>>>> generic way, as it is a generic interface. What about adding =
something
>>>> like:
>>>>=20
>>>> "A 'cold' reset means that the object to be reset is initially =
reset; a 'warm'
>>>> reset means that the object to be reset has already been =
initialized."
>>>>=20
>>>> Or is that again too generic?
>>>=20
>>> I think it doesn't quite capture the idea -- an object can have =
already
>>> been reset and then get a 'cold' reset: this is like having a =
powered-on
>>> machine and then power-cycling it.
>>>=20
>>> The 'warm' reset is the vaguer one, because the specific behaviour
>>> is somewhat device-dependent (many devices might not have any
>>> difference from 'cold' reset, for those that do the exact detail
>>> of what doesn't get reset on warm-reset will vary). But every
>>> device should have some kind of "as if you power-cycled it" (or
>>> for QEMU, "go back to the same state as if you just started QEMU on =
the
>>> command line"). Our current "reset" method is really cold-reset.
>>=20
>> Is there any concept of locality associated with warm reset?
>> For example, you'd expect a cold reset to happen on the whole system,
>> but I guess a warm reset could be restricted to a single bus.
>>=20
>> The documentation should give examples of how warm reset could be
>> triggered, and what it could do differently from cold reset.
>>=20
>=20
> Not sure we really have some locality difference between cold/warm
> resets. I think, most generally, locality of reset is on a per-device
> scale with different grouping level (up to the whole system). But =
buses
> are not always the way things are grouped.
>=20
> Inside a soc (and microcontrollers in general) it follows more the =
clock
> tree than the internal bus tree. For example on the the machine I =
worked
> here (xilinx-zynq-a9) and, you can control by software the reset of
> basically every single device and the bus too (but resetting the bus
> does not reset devices on it).
>=20
> On the other hand, there is some buses, like pci, which explicitly
> defines some bus reset mechanism with differences between cold and =
warm
> (some registers keep their values). (see
> https://wiki.qemu.org/Features/ResetAPI)
>=20
> Regarding cold reset, if a soc supports some power gating, you'll
> probably have non-global cold reset in the process.
>=20
> Do you mean "real world" example ?

I think that a variant of what you just wrote would be fine.
I was not aware for example that you could have non-global cold reset.


Thanks
Christophe



