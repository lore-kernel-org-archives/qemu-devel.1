Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE71EC35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A3C21920
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Keugmvz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A3C21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFd3g-0005m7-ML
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 07:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFd26-0004ra-H9
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFd24-0004ja-IQ
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:43:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54706
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFd24-0004iU-Bl
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570016579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wvnKTw0sAavazyJZZW9Wk1O7xrbP0dZeyooGqDia7ho=;
 b=Keugmvz0X7VTTewsEs2n4Zfq+TKUyCO7z5CIcD+TWzeR9JuOcGkhyX/pdExGFloaATKNkQ
 lxdj1ch7RBPa//kGLqHmHFKUwwFOkRj4KipUYrhVoLjqpwBHv0GbNaciXnEp5gLmqdMjZH
 svWwjFbAYusnqHHCdy6XspFsNAMRloY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-K1DW8XNoN_aegFVGopkyPA-1; Wed, 02 Oct 2019 07:42:54 -0400
Received: by mail-wr1-f71.google.com with SMTP id n18so7358799wro.11
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 04:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=49ofHnBcWLkDR2hmOs6dZXoCirhM1X4JD/4rJI3EwDs=;
 b=hu9J3Hr2+1IVe/shU8EJLg0gZ757tvEJHHSD4NqTmxKhTTjEeLOmTAdiK7IrVNv3C2
 bxrsDiHgd+DV+G/yAqTYAi37jcZieo4h/gQ48cu4mVErg/gbIs0FmdQ/PxW4UxmjmCsY
 KGbNZgwbODiDemTSl1xnWONLY8ABXsMhF35sK6fJEmVkVN4/jWAmSMJY87cUtV1uhaEj
 vMw1PciYdFxKL2TJCA7feBrta8J03mU80amLxL3u73HCDH+XXg7U3fsuXc0Ox6d97UBp
 incOWVqRL7uSF8PV6d1LEncRWXUJz/tG8F7dy9IQvNEZqHuWSjmUsPSWx6ow+sJln1uG
 2+6g==
X-Gm-Message-State: APjAAAXZpy+ZRsUZ7l9nZ0s12PbFvxCzoCx59z4YAQzQmRRcsYV9dNyl
 GYFEPKqwC45xW7rBd9TvN78bo2PD374UaAF6rR2tJMLLIEFMnNYl0tgZySA07CEnLEGNSMz+tWl
 5VtZTLza4MIKzUxc=
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr2465595wrs.146.1570016573317; 
 Wed, 02 Oct 2019 04:42:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw0tmdzcRP+bDH2vMRrwGtPuEKFCDKWnrqBXLXlO4Iw4RIlxw541KElGEzp1vEcW0uXpRTOWQ==
X-Received: by 2002:a5d:4a43:: with SMTP id v3mr2465580wrs.146.1570016573108; 
 Wed, 02 Oct 2019 04:42:53 -0700 (PDT)
Received: from [10.201.33.15] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id h7sm15875777wrt.17.2019.10.02.04.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2019 04:42:52 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH 00/19] Declare device little or big endian
To: Tony Nguyen <tony.nguyen@bt.com>, qemu-devel@nongnu.org
References: <cover.1566829168.git.tony.nguyen@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <caa8aec8-de38-8207-a180-65acb1930a53@redhat.com>
Date: Wed, 2 Oct 2019 13:42:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <cover.1566829168.git.tony.nguyen@bt.com>
Content-Language: en-US
X-MC-Unique: K1DW8XNoN_aegFVGopkyPA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/26/19 4:21 PM, Tony Nguyen wrote:
> This series is an attempt to re-declare devices with DEVICE_NATIVE_ENDIAN=
 as
> DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN.
>=20
> This clean up was split out from an earlier series which collapsed byte s=
waps
> along the I/O path.
>=20
> On Wed, 7 Aug 2019 at 12:42, Paolo Bonzini wrote:
>> On 07/08/19 10:31, tony.nguyen@bt wrote:
>>>
>>> Device realizing code with MemorRegionOps endianness as
>>> DEVICE_NATIVE_ENDIAN is not common code.
>>>
>>> Corrected devices were identified by making the declaration of
>>> DEVICE_NATIVE_ENDIAN conditional upon NEED_CPU_H and then listing
>>> what failed to compile.
>>
>> The general approach makes sense.  However, most of these should not be
>> DEVICE_NATIVE_ENDIAN.  I can help with some of them.
>=20
> On Fri, 16 Aug 2019 at 13:02, Peter Maydell wrote:
>> OTOH it's worth noting that it's quite likely that most of
>> the implementations of these DEVICE_NATIVE_ENDIAN devices
>> picked it in an equally naive way, by just copying some other
>> device's code...
>=20
> Approach this in two steps.
>=20
> 1. Naively. For each device declared with DEVICE_NATIVE_ENDIAN, find the =
set of
> targets from the set of target/hw/*/device.o.
>=20
> If the set of targets are all little or all big endian, re-declare
> as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN respectively.
>=20
> 2. Manually. Inspect with heuristics (thanks Paolo):
> - if not used, re-declare as DEVICE_HOST_ENDIAN.
> - if max/min size=3D1, re-declare as DEVICE_HOST_ENDIAN.
> - if just a bit bucket, re-declare as DEVICE_HOST_ENDIAN
> - if PCI, re-declare as DEVICE_LITTLE_ENDIAN.
> - if for {ARM|unicore32} only, re-declare as DEVICE_LITTLE_ENDIAN.
> - if for SPARC only, re-declare as DEVICE_BIG_ENDIAN.

Maybe this list is better to split your patches.

Which are the 'not used' ones?

TYPE_TPCI200 (from IndustryPack) can go with PCI.

You can put all the PrimeCell devices together (eventually with the=20
other ARM devices):

  hw/audio/pl041.c
  hw/char/pl011.c
  hw/display/pl110.c
  hw/dma/pl080.c
  hw/dma/pl330.c
  hw/gpio/pl061.c
  hw/input/pl050.c
  hw/intc/pl190.c
  hw/sd/pl181.c
  hw/ssi/pl022.c
  hw/timer/pl031.c


