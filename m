Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041B5C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57062070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJstfHNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57062070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47g8-00036r-2D
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j47dS-0000q8-Kx
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j47dR-0008JB-BM
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:30:18 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38247)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j47dR-0008Hd-4G; Tue, 18 Feb 2020 13:30:17 -0500
Received: by mail-ot1-x342.google.com with SMTP id z9so20495891oth.5;
 Tue, 18 Feb 2020 10:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=VTHuOYkRScccjYac4c/SHiXCBRs8ZpyUXnseZG9ugcI=;
 b=lJstfHNtZEpeKsA26Zqa3T/gEZc8whTjTtsUf2OBazVMQDASUjJz8ExsaBL5KCwX0F
 GNaVwUMSXQ7orDp0tBazNkFpboeVCDI2BKIFNIkxK35IVXUaXOftUeTheR51Yz7rqKh5
 tucZkIucfdhLzuN8frz2LE4I3px++xXCqY33/2Fr4g9PWlmUQJFyifn7qhaE0mx6K+wu
 S/tV24QnMcTwrQeYrAoD4oAG8gK0FS0M8FuS1hfOeHbPOTwg9BK4npC/TigGygp6qH7L
 099hs4isIKbRZ5SJuEzJzVPbDIQELt64PxZLWGuxLReU/HuRDChtMcOHF25sZJQbr5y8
 nLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=VTHuOYkRScccjYac4c/SHiXCBRs8ZpyUXnseZG9ugcI=;
 b=TizNpxZFP+t+pzTCVKpYbT2Vm3bCR9zkX4WXC58uKL3JjkxTzTU6t4SbojEuo+PI0u
 all48xiKAl+dOe8cRiFlH4qoC9R7D9snhIi70g7lVRVZvj8OaxfYgfWaheuluh7tSL6X
 cbUbhZwV6OgDnR4fgJF/LbjGo+g3U8k/b9jgM/Ou2oSNlhBEJCQTLWTBoczbjcAgmyxH
 FToBQKnPs6kcQd9WPqc29Vr6ZCNCoyssNHchnXPIf6m9mxoZuV0Zu3/m0iBlxzEGhnP4
 gpHu36WLJfcg/mJTPEolDiopIMS4utcC3L2Gx+5Rjfpp4lMtGi2t0IZ9ST5c6oSgk6o7
 nrIg==
X-Gm-Message-State: APjAAAV0L56GI9t/ELkYmsOSzeicAuB2LhEJ8QVxSpbD1gpt9g1B1sgN
 6X/P/3cUXG1r9gfD65sYs55BrhbnuMEv3n8N6tg=
X-Google-Smtp-Source: APXvYqxco0Gm+QxHeej5X/OnuQE5moVO5CB9vU/6aRyMOqAyBDqeGGTQ6DNE1WR5pRqk8QW4PhUbIArDe59XuUAJRPc=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr15961226otk.64.1582050616312; 
 Tue, 18 Feb 2020 10:30:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 18 Feb 2020 10:30:15 -0800 (PST)
In-Reply-To: <1b1e6027-b59b-939d-c0ad-791be60f18ae@redhat.com>
References: <cover.1580290069.git.fthain@telegraphics.com.au>
 <1b1e6027-b59b-939d-c0ad-791be60f18ae@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 18 Feb 2020 19:30:15 +0100
Message-ID: <CAL1e-=iCY9FaPdDHB4ms37dckQp+YKoWniA22jQ7eOq__jobpA@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] Fixes for DP8393X SONIC device emulation
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000008802059edddd95"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Finn Thain <fthain@telegraphics.com.au>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000008802059edddd95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, February 4, 2020, Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/1/29 =E4=B8=8B=E5=8D=885:27, Finn Thain wrote:
>
>> Hi All,
>>
>> There are bugs in the emulated dp8393x device that can stop packet
>> reception in a Linux/m68k guest (q800 machine).
>>
>> With a Linux/m68k v5.5 guest (q800), it's possible to remotely trigger
>> an Oops by sending ping floods.
>>
>> With a Linux/mips guest (magnum machine), the driver fails to probe
>> the dp8393x device.
>>
>> With a NetBSD/arc 5.1 guest (magnum), the bugs in the device can be
>> fatal to the guest kernel.
>>
>> Whilst debugging the device, I found that the receiver algorithm
>> differs from the one described in the National Semiconductor
>> datasheet.
>>
>> This patch series resolves these bugs.
>>
>> AFAIK, all bugs in the Linux sonic driver were fixed in Linux v5.5.
>> ---
>> Changed since v1:
>>   - Minor revisions as described beneath commit logs.
>>   - Dropped patches 4/10 and 7/10.
>>   - Added 5 new patches.
>>
>> Changed since v2:
>>   - Minor revisions as described beneath commit logs.
>>   - Dropped patch 13/13.
>>   - Added 2 new patches.
>>
>> Changed since v3:
>>   - Replaced patch 13/14 with patch suggested by Philippe Mathieu-Daud=
=C3=A9.
>>
>>
>> Finn Thain (14):
>>    dp8393x: Mask EOL bit from descriptor addresses
>>    dp8393x: Always use 32-bit accesses
>>    dp8393x: Clean up endianness hacks
>>    dp8393x: Have dp8393x_receive() return the packet size
>>    dp8393x: Update LLFA and CRDA registers from rx descriptor
>>    dp8393x: Clear RRRA command register bit only when appropriate
>>    dp8393x: Implement packet size limit and RBAE interrupt
>>    dp8393x: Don't clobber packet checksum
>>    dp8393x: Use long-word-aligned RRA pointers in 32-bit mode
>>    dp8393x: Pad frames to word or long word boundary
>>    dp8393x: Clear descriptor in_use field to release packet
>>    dp8393x: Always update RRA pointers and sequence numbers
>>    dp8393x: Don't reset Silicon Revision register
>>    dp8393x: Don't stop reception upon RBE interrupt assertion
>>
>>   hw/net/dp8393x.c | 202 +++++++++++++++++++++++++++++++----------------
>>   1 file changed, 134 insertions(+), 68 deletions(-)
>>
>
>
> Applied.
>
>
Hi, Jason,

I generally have some reservations towards patches that did not receive any
R-bs. I think we should hear from Herve in this case, to confirm that this
change doesn't cause other problems while solving the original ones.

I hope this is not the case.

Regards,
Aleksandar




> Thanks
>
>
>

--000000000000008802059edddd95
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, February 4, 2020, Jason Wang &lt;<a href=3D"mailto:jaso=
wang@redhat.com">jasowang@redhat.com</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><br>
On 2020/1/29 =E4=B8=8B=E5=8D=885:27, Finn Thain wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi All,<br>
<br>
There are bugs in the emulated dp8393x device that can stop packet<br>
reception in a Linux/m68k guest (q800 machine).<br>
<br>
With a Linux/m68k v5.5 guest (q800), it&#39;s possible to remotely trigger<=
br>
an Oops by sending ping floods.<br>
<br>
With a Linux/mips guest (magnum machine), the driver fails to probe<br>
the dp8393x device.<br>
<br>
With a NetBSD/arc 5.1 guest (magnum), the bugs in the device can be<br>
fatal to the guest kernel.<br>
<br>
Whilst debugging the device, I found that the receiver algorithm<br>
differs from the one described in the National Semiconductor<br>
datasheet.<br>
<br>
This patch series resolves these bugs.<br>
<br>
AFAIK, all bugs in the Linux sonic driver were fixed in Linux v5.5.<br>
---<br>
Changed since v1:<br>
=C2=A0 - Minor revisions as described beneath commit logs.<br>
=C2=A0 - Dropped patches 4/10 and 7/10.<br>
=C2=A0 - Added 5 new patches.<br>
<br>
Changed since v2:<br>
=C2=A0 - Minor revisions as described beneath commit logs.<br>
=C2=A0 - Dropped patch 13/13.<br>
=C2=A0 - Added 2 new patches.<br>
<br>
Changed since v3:<br>
=C2=A0 - Replaced patch 13/14 with patch suggested by Philippe Mathieu-Daud=
=C3=A9.<br>
<br>
<br>
Finn Thain (14):<br>
=C2=A0 =C2=A0dp8393x: Mask EOL bit from descriptor addresses<br>
=C2=A0 =C2=A0dp8393x: Always use 32-bit accesses<br>
=C2=A0 =C2=A0dp8393x: Clean up endianness hacks<br>
=C2=A0 =C2=A0dp8393x: Have dp8393x_receive() return the packet size<br>
=C2=A0 =C2=A0dp8393x: Update LLFA and CRDA registers from rx descriptor<br>
=C2=A0 =C2=A0dp8393x: Clear RRRA command register bit only when appropriate=
<br>
=C2=A0 =C2=A0dp8393x: Implement packet size limit and RBAE interrupt<br>
=C2=A0 =C2=A0dp8393x: Don&#39;t clobber packet checksum<br>
=C2=A0 =C2=A0dp8393x: Use long-word-aligned RRA pointers in 32-bit mode<br>
=C2=A0 =C2=A0dp8393x: Pad frames to word or long word boundary<br>
=C2=A0 =C2=A0dp8393x: Clear descriptor in_use field to release packet<br>
=C2=A0 =C2=A0dp8393x: Always update RRA pointers and sequence numbers<br>
=C2=A0 =C2=A0dp8393x: Don&#39;t reset Silicon Revision register<br>
=C2=A0 =C2=A0dp8393x: Don&#39;t stop reception upon RBE interrupt assertion=
<br>
<br>
=C2=A0 hw/net/dp8393x.c | 202 ++++++++++++++++++++++++++++++<wbr>+---------=
-------<br>
=C2=A0 1 file changed, 134 insertions(+), 68 deletions(-)<br>
</blockquote>
<br>
<br>
Applied.<br>
<br></blockquote><div><br></div><div>Hi, Jason,</div><div><br></div><div>I =
generally have some reservations towards patches that did not receive any R=
-bs. I think we should hear from Herve in this case, to confirm that this c=
hange doesn&#39;t cause other problems while solving the original ones.</di=
v><div><br></div><div>I hope this is not the case.</div><div><br></div><div=
>Regards,</div><div>Aleksandar</div><div><br></div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
Thanks<br>
<br>
<br>
</blockquote>

--000000000000008802059edddd95--

