Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F85C33CA9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:06:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C52820CC7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 02:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0CWiR4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C52820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irBap-0007lu-HA
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 21:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1irBXM-0005DQ-Hc
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1irBXL-0003vU-Ds
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 21:02:32 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:40980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1irBXL-0003ue-6R; Mon, 13 Jan 2020 21:02:31 -0500
Received: by mail-lf1-x144.google.com with SMTP id m30so8468065lfp.8;
 Mon, 13 Jan 2020 18:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wUZSPSo0jt960buXgMC7KYm3AgJo4uzvA53Zew/Py5Q=;
 b=J0CWiR4RfUBEtaiY+wnwC0FHHmZ47a8ntwx3gMaRqap2PHYZWw43nZ7+I2tAerRtM3
 6jeyoaZwoS7bsoBMuSOviZyLV/Jgja1civsWdB5w6EWruAONPpe2MZliTNTbJ/3J6pEa
 ocvpegu6AGHuLT3pMi0K9m+OFtmJ6Wu9BP6cj+o9X7EiUJpBfNBzwJqivZsfCiSIAY34
 zy7NygsFLlI9qmRFgQZSdcs/iFiKSPMLXJRMHX19jrRx4qKDeIF2prWW3p0M3dZKeQsV
 qXFEf2CTXrX7J1LdEyiykv3IDQ8a+sh02m4PCxIkhnIVj+LLDeNLeS9DwYQWI5oPQ43n
 yICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wUZSPSo0jt960buXgMC7KYm3AgJo4uzvA53Zew/Py5Q=;
 b=YjE/rHflea2DWemo9O8NJihDRUAKn7THzVJVRIKtK36BUYZM+gY0CflcBxHa8rCNST
 c1jhPbJ6syyWwMgF1pnV9/TGB6thXGTyFIPQP2yBoL+PH6YXfHTxH+ElyeRbkE2xr8RN
 TJ1M48Wy3Fr7VrKBzJO0KupM/5STUXyIeqwbtWGkfEckNL66ez7hQTNSAOup/ZIs+gKL
 HM6yszCkANlCLTr0BvnyDomx1NITfHHiunoMH+8l8Ug7PU227nCq9DTIXm9WZ1C4Fya7
 SvRde6LZw/idjHAkVYfaz8Ht0x594xTWmjDH+6lPvxj413GhZk7rRvfwaul1n1ry7zFf
 P1zw==
X-Gm-Message-State: APjAAAXLSLfTw1J6n2OgyXNiJBFqDREROrLCGjuWsl6IEmlOkHH+/761
 j5rof96jtHvkFyf8XtUqamR3iIwaQLHXAdBK8Lo=
X-Google-Smtp-Source: APXvYqyouBD1xiebvS2Zk4hXxg76VrTocGGq5YSmQpO/+jvM/ul9CzMiHyzODVOre5V8qAlauIiAdI9HwiaH0r7qC9o=
X-Received: by 2002:a19:e30b:: with SMTP id a11mr249814lfh.48.1578967349135;
 Mon, 13 Jan 2020 18:02:29 -0800 (PST)
MIME-Version: 1.0
References: <20200109152133.23649-1-philmd@redhat.com>
 <20200109152133.23649-11-philmd@redhat.com>
 <CAKmqyKNrgTbiipNK1wrwCMqk_=7cJmc4rBwO1zxjFiVV+TRSgQ@mail.gmail.com>
 <f7e3539a-4506-0df1-ee66-f3d8a6aa8fce@redhat.com>
In-Reply-To: <f7e3539a-4506-0df1-ee66-f3d8a6aa8fce@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 Jan 2020 12:02:02 +1000
Message-ID: <CAKmqyKNxNE0nCODQp37T4eKcq+0cDTCpW9SJkbby+q6Q99vg7g@mail.gmail.com>
Subject: Re: [PATCH 10/15] memory: Replace current_machine by
 qdev_get_machine()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Overall" <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jan 12, 2020 at 11:45 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 1/12/20 10:48 AM, Alistair Francis wrote:
> > On Thu, Jan 9, 2020 at 11:29 PM Philippe Mathieu-Daud=C3=A9
> > <philmd@redhat.com> wrote:
> >>
> >> As we want to remove the global current_machine,
> >> replace 'current_machine' by MACHINE(qdev_get_machine()).
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >> ---
> >>   memory.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/memory.c b/memory.c
> >> index d7b9bb6951..57e38b1f50 100644
> >> --- a/memory.c
> >> +++ b/memory.c
> >> @@ -3004,6 +3004,7 @@ static void mtree_print_flatview(gpointer key, g=
pointer value,
> >>       int n =3D view->nr;
> >>       int i;
> >>       AddressSpace *as;
> >> +    MachineState *ms;
> >>
> >>       qemu_printf("FlatView #%d\n", fvi->counter);
> >>       ++fvi->counter;
> >> @@ -3026,6 +3027,7 @@ static void mtree_print_flatview(gpointer key, g=
pointer value,
> >>           return;
> >>       }
> >>
> >> +    ms =3D MACHINE(qdev_get_machine());
> >
> > Why not set this at the top?
>
> Calling qdev_get_machine() is not free as it does some introspection
> checks. Since we can return earlier if there are no rendered FlatView, I
> placed the machinestate initialization just before it we need to access i=
t.

Works for me, maybe worth putting this in the commit?

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> > Alistair
> >
> >>       while (n--) {
> >>           mr =3D range->mr;
> >>           if (range->offset_in_region) {
> >> @@ -3057,7 +3059,7 @@ static void mtree_print_flatview(gpointer key, g=
pointer value,
> >>           if (fvi->ac) {
> >>               for (i =3D 0; i < fv_address_spaces->len; ++i) {
> >>                   as =3D g_array_index(fv_address_spaces, AddressSpace=
*, i);
> >> -                if (fvi->ac->has_memory(current_machine, as,
> >> +                if (fvi->ac->has_memory(ms, as,
> >>                                           int128_get64(range->addr.sta=
rt),
> >>                                           MR_SIZE(range->addr.size) + =
1)) {
> >>                       qemu_printf(" %s", fvi->ac->name);
> >> --
> >> 2.21.1
> >>
> >>
> >
>

