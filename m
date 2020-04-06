Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E306C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DCAC206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3MWvAy+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DCAC206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVto-0005vq-CI
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jLVqD-00015L-D5
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jLVq5-0000bg-JV
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56234
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jLVq5-0000aN-EF
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586195232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BH2VYTUXcsfl/0dH3y012NaqwkbVBg2RcLAh0syExwQ=;
 b=O3MWvAy+gW42X5YVVgI6Yw+LxUXqcoZq0+eomXWr/jQnxmBmptqNqjl5bGOL0UlIyz1tdP
 uWFvZrLGShvqvj5iV/H9P4fLGd38eR6oNLrRIV6mjo7vIpJp7+rS85pNeFVqfIaUkhZ/9D
 T9mnwlnDvJItNxlreBGyWiGGbdtkBPo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-Jm2DKnWQP2KWd-GCmJZT7A-1; Mon, 06 Apr 2020 13:47:07 -0400
X-MC-Unique: Jm2DKnWQP2KWd-GCmJZT7A-1
Received: by mail-wr1-f70.google.com with SMTP id j12so173693wrr.18
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 10:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YKe0BgM0CmuS/l7Co2UJ4kTaHPz04qaQEvypXhdFiFE=;
 b=Pp/bQw6P8DrAumaI6dM8Oz0WsLwFp2ArTGiqHmrgxM7+Dx7gCZU+MBlmdjusT8f6Xe
 LEtp9fNZ7rSaunywQ/96Hj+z62r/muZxKH458vPlnPNOq0BoHOtt4KYWVECkMyhoptyN
 RHQy29kZRBHIpjSoZAb0bB1sgRMZxYplnV3f/5KtiSJXx5jhOgGK8pu586sDpkC3VKds
 AUYBaO4RRN+YvCogrmA461+lHWUc80dxXIETbrzJqxfrJ/DGaHmncAUZjzxLLpHNVrYa
 HQ2YNX8fJH+/LDSBUZ6wRT51jG0zheBaCMniFgSgJgwrai+18xN4i0ein7XOehVfMyzo
 1u5w==
X-Gm-Message-State: AGi0PuaHAqMS9ddO9NQLdFF9DJuXXVg7G+R8CSNxvWAGxgYukgs4DFj5
 hqPlg4vAeYzEsS9bgrlWPs9R581HD3rt6Sq1LLsA0vqV0Diq80MxIIyrYDtg50CWGB543y0gSte
 0NYLs0lW2tpYPgoU=
X-Received: by 2002:a1c:dc0a:: with SMTP id t10mr454862wmg.113.1586195226065; 
 Mon, 06 Apr 2020 10:47:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypIoO8o8nhDhFD/G0RUux58XzODZJNSsd8jGyeulTOJnh1Vom+R4utwU+q6AFWuIcbCRnJ++eg==
X-Received: by 2002:a1c:dc0a:: with SMTP id t10mr454814wmg.113.1586195225719; 
 Mon, 06 Apr 2020 10:47:05 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id o67sm398413wmo.5.2020.04.06.10.47.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2020 10:47:04 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 00/12] hw: Add missing error-propagation code
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200325191830.16553-1-f4bug@amsat.org>
 <CAAdtpL7rC1u=B-xW+ZbrRbpSMKvGx0kq_hug1J9-cxx6NgJR1Q@mail.gmail.com>
 <20200330092127.GE73285@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <22fd27d1-6d22-c91d-716f-6518a062dd21@redhat.com>
Date: Mon, 6 Apr 2020 19:47:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200330092127.GE73285@stefanha-x1.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/30/20 11:21 AM, Stefan Hajnoczi wrote:
> On Wed, Mar 25, 2020 at 08:20:49PM +0100, Philippe Mathieu-Daud=E9 wrote:
>> On Wed, Mar 25, 2020 at 8:18 PM Philippe Mathieu-Daud=E9 <f4bug@amsat.or=
g> wrote:
>>>
>>> This series is inspired of Peter fix:
>>> "hw/arm/xlnx-zynqmp.c: fix some error-handling code"
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg691636.html
>>>
>>> Add a cocci script to fix the other places.
>>>
>>> Based-on: <20200324134947.15384-1-peter.maydell@linaro.org>
>>>
>>> Philippe Mathieu-Daud=3DC3=3DA9 (12):
>>
>> Hmm is that a git-publish bug?
>=20
> Please run git-publish once more on the same branch and inspect the
> $TMPDIR/0000-cover-letter.patch email in an editor when git-publish
> prints "Stopping so you can inspect the patch emails:".
>=20
> It would be interesting to see how your name is formatted, as well as
> the MIME Content-Type and Content-Transfer-Encoding headers.

Content-Type: text/plain; charset=3D"utf-8"

Content-Transfer-Encoding: quoted-printable


Philippe Mathieu-Daud=3DC3=3DA9 (12):


>=20
> This information can be compared to the final email sent to the list
> and/or received by the mailing list.
>=20
> Stefan
>=20


