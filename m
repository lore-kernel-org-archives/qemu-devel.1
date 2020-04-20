Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B180C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D682A206F6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 16:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBFIsCLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D682A206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQZ5Y-00017p-28
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 12:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46712 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <igotti@gmail.com>) id 1jQZ4D-0008NJ-2u
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:14:41 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <igotti@gmail.com>) id 1jQZ4B-0006h7-UW
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:14:40 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:37120)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <igotti@gmail.com>) id 1jQZ4A-0006cd-D5
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 12:14:39 -0400
Received: by mail-lf1-x144.google.com with SMTP id t11so8441394lfe.4
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 09:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oR/YrnRiRsFvWESr+qK9WAAMqj9qHFp/PdZb2SM57jU=;
 b=IBFIsCLmm+6qEXjGbmpWo0TfO3mHA686NEELmNM3CRaI8xKgokPzJ0mfVGnBAvNzRF
 o7nhLFZNedH3rZoFhzwHU1Gi1NnHDJ7ZZ34Sd1Bd2JA6ogb9BV+MFuLsQgVqXKfXySPP
 m4/iJQO386uYFAynuc2Yhh25SmrKoFEzg09VnjGHzSXLUuj0Ts37aTENV51ahfCikuV1
 1PayJmpzhIzAw406veSs27ggHkdBRta9l2LJSPF2dlHOBK5jrekk4sOPANp6tIgxyaRX
 vSf83VH2PXG51SdHP1i38IxXXBvh2OSQX0NxLJQh8WVr0OaUhd2D7gi3mgCwXEp0krR3
 fx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oR/YrnRiRsFvWESr+qK9WAAMqj9qHFp/PdZb2SM57jU=;
 b=VmhL+ThFpiAnIqCLSuFGkkQXSEHnJoBEbA0zqQGa7Wzo48iMIZ3l3UJ3e6jEeBxmL9
 y8drcU40k+SazKDrrLNPrMzV26j9nCFaebuYSO99gxpM2vwIfBO/tWb2fYS2QtHA0QM/
 6/IKofwAzwZh9JpySdKDuSKAFXWj5iZtUrS2rLSs7veTG1qsmYDTPBsZh2E//+gVTVIb
 kciaJ20uQcaQHV/fMtXIv0qIC1/d16zFXxAYbxmsRjHVZx+gLuoinLSFNMkT4kh+kqXW
 MpgXtEyxr8VIR1vlMiG6vhdU39uFwPnxJRVDVnXk3wjDnaCA5pWlohH/I5E0OCL71ThH
 uSRA==
X-Gm-Message-State: AGi0PuaH2e6zjujLb4LwJmVY7+tIF03lXZ1jReLYQbHS1T0eLHQ5xxLz
 IrvOgLhZ+OlE8cykYxl50i2H0M5uj74PJDrjK88=
X-Google-Smtp-Source: APiQypJ+6JEBiDulaJDpitOP6gfharT6/Emw0GOeJYwu/nNWzg4/VdbVGEAFSnsUwBIo6DDOD5XgkFtabsxJIIa7bIc=
X-Received: by 2002:a19:dc05:: with SMTP id t5mr11011249lfg.73.1587399276369; 
 Mon, 20 Apr 2020 09:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEme+7FPF+inSJSXQPmuv8Up3Eam0N7fT03zqM-RvcvKsxjfVQ@mail.gmail.com>
 <CAFEAcA9Yk53oK5YstN7DpCCq344+tbyjvDA6RaWcJCrL9QSjMw@mail.gmail.com>
 <87lfmqdwkx.fsf@linaro.org>
In-Reply-To: <87lfmqdwkx.fsf@linaro.org>
From: Nikolay Igotti <igotti@gmail.com>
Date: Mon, 20 Apr 2020 19:14:24 +0300
Message-ID: <CAEme+7GLKg_dNsHizzTKDymX9HyD+Ph2iZ=WKhOw2XG+zhViXg@mail.gmail.com>
Subject: Re: [PATCH 3/3] plugins: avoid failing plugin when CPU is inited
 several times
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000fc6bdb05a3bb310b"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=igotti@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fc6bdb05a3bb310b
Content-Type: multipart/alternative; boundary="000000000000fc6bd805a3bb3109"

--000000000000fc6bd805a3bb3109
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure, attached plugin and testcase where it fails.


On Mon, Apr 20, 2020 at 6:08 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Mon, 20 Apr 2020 at 10:16, Nikolay Igotti <igotti@gmail.com> wrote:
> >>
> >> In linux-user multithreaded scenarious CPU could be inited many times
> with the same id,
> >>
> >> so avoid assertions on already present hashtable entry.
> >>
> >>
> >> Signed-off-by: Nikolay Igotti <igotti@gmail.com>
> >
> > Wouldn't it be better to make sure we remove the entry from
> > the hashtable when the old thread that was using that CPU
> > ID exits, or is that not feasible ?
>
> I'm fairly sure that is exactly what should be happening via
> qemu_plugin_vcpu_exit_hook(cpu) which should be a result of the
> object_unref(OBJECT(cpu)) in thread exit.
>
> Is there a test vase?
>
> >
> > thanks
> > -- PMM
>
>
> --
> Alex Benn=C3=A9e
>

--000000000000fc6bd805a3bb3109
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sure, attached plugin and testcase=C2=A0where it fails.<di=
v><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Mon, Apr 20, 2020 at 6:08 PM Alex Benn=C3=A9e &lt;<a href=3D=
"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_bl=
ank">peter.maydell@linaro.org</a>&gt; writes:<br>
<br>
&gt; On Mon, 20 Apr 2020 at 10:16, Nikolay Igotti &lt;<a href=3D"mailto:igo=
tti@gmail.com" target=3D"_blank">igotti@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; In linux-user multithreaded scenarious CPU could be inited many ti=
mes with the same id,<br>
&gt;&gt;<br>
&gt;&gt; so avoid assertions on already present hashtable entry.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Nikolay Igotti &lt;<a href=3D"mailto:igotti@gmail.c=
om" target=3D"_blank">igotti@gmail.com</a>&gt;<br>
&gt;<br>
&gt; Wouldn&#39;t it be better to make sure we remove the entry from<br>
&gt; the hashtable when the old thread that was using that CPU<br>
&gt; ID exits, or is that not feasible ?<br>
<br>
I&#39;m fairly sure that is exactly what should be happening via<br>
qemu_plugin_vcpu_exit_hook(cpu) which should be a result of the<br>
object_unref(OBJECT(cpu)) in thread exit.<br>
<br>
Is there a test vase?<br>
<br>
&gt;<br>
&gt; thanks<br>
&gt; -- PMM<br>
<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
</blockquote></div>

--000000000000fc6bd805a3bb3109--

--000000000000fc6bdb05a3bb310b
Content-Type: application/octet-stream; name="counter.c"
Content-Disposition: attachment; filename="counter.c"
Content-Transfer-Encoding: base64
Content-ID: <f_k98oiv5y1>
X-Attachment-Id: f_k98oiv5y1

I2luY2x1ZGUgPGFzc2VydC5oPgojaW5jbHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSA8c3RkaW8u
aD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDx1bmlz
dGQuaD4KCiNpbmNsdWRlIDxnbGliLmg+CgojaW5jbHVkZSA8cWVtdS1wbHVnaW4uaD4KClFFTVVf
UExVR0lOX0VYUE9SVCBpbnQgcWVtdV9wbHVnaW5fdmVyc2lvbiA9IFFFTVVfUExVR0lOX1ZFUlNJ
T047CgovLyBGaWxlcyB3aXRoIGRlc2NyaXB0b3JzIGFmdGVyIHRoaXMgb25lIGFyZSBpbnRlcmNl
cHRlZCBmb3IgaW5zdHJ1Y3Rpb24gY291bnRpbmcgbWFya3MuCiNkZWZpbmUgQ0FUQ0hfQkFTRSAw
eGNhZmViYWJlCgpzdGF0aWMgdWludDY0X3QgaW5zbl9jb3VudCA9IDA7CnN0YXRpYyBwdGhyZWFk
X3QgY291bnRpbmcgPSBmYWxzZTsKc3RhdGljIHB0aHJlYWRfdCBjb3VudGluZ19mb3IgPSAwOwpz
dGF0aWMgYm9vbCBvbl9ldmVyeV9jbG9zZSA9IGZhbHNlOwoKc3RhdGljIHZvaWQgdmNwdV9pbnNu
X2V4ZWNfYmVmb3JlKHVuc2lnbmVkIGludCBjcHVfaW5kZXgsIHZvaWQgKnVkYXRhKQp7CiAgICBp
ZiAoY291bnRpbmcgJiYgcHRocmVhZF9zZWxmKCkgPT0gY291bnRpbmdfZm9yKQogICAgICAgIGlu
c25fY291bnQrKzsKfQoKc3RhdGljIHZvaWQgdmNwdV90Yl90cmFucyhxZW11X3BsdWdpbl9pZF90
IGlkLCBzdHJ1Y3QgcWVtdV9wbHVnaW5fdGIgKnRiKQp7CiAgICBzaXplX3QgbiA9IHFlbXVfcGx1
Z2luX3RiX25faW5zbnModGIpOwogICAgc2l6ZV90IGk7CgogICAgZm9yIChpID0gMDsgaSA8IG47
IGkrKykgewogICAgICAgIHN0cnVjdCBxZW11X3BsdWdpbl9pbnNuICppbnNuID0gcWVtdV9wbHVn
aW5fdGJfZ2V0X2luc24odGIsIGkpOwoKICAgICAgICAvLyBUT0RPOiBkbyB0aGlzIGNhbGwgb25s
eSBvbiBmaXJzdCBpbnNuIGluIGJiLgogICAgICAgIHFlbXVfcGx1Z2luX3JlZ2lzdGVyX3ZjcHVf
aW5zbl9leGVjX2NiKAogICAgICAgICAgICBpbnNuLCB2Y3B1X2luc25fZXhlY19iZWZvcmUsIFFF
TVVfUExVR0lOX0NCX05PX1JFR1MsIE5VTEwpOwogICAgfQp9CgpzdGF0aWMgdm9pZCBwcmludF9p
bnNuX2NvdW50KHZvaWQpIHsKICAgIGdfYXV0b2ZyZWUgZ2NoYXIgKm91dCA9IGdfc3RyZHVwX3By
aW50ZigiZXhlY3V0ZWQgJSIgUFJJdTY0ICIgaW5zdHJ1Y3Rpb25zXG4iLCBpbnNuX2NvdW50KTsK
ICAgIHFlbXVfcGx1Z2luX291dHMob3V0KTsKfQoKc3RhdGljIHZvaWQgdmNwdV9zeXNjYWxsKHFl
bXVfcGx1Z2luX2lkX3QgaWQsIHVuc2lnbmVkIGludCB2Y3B1X2luZGV4LAogICAgICAgICAgICAg
ICAgICAgICAgICBpbnQ2NF90IG51bSwgdWludDY0X3QgYTEsIHVpbnQ2NF90IGEyLAogICAgICAg
ICAgICAgICAgICAgICAgICB1aW50NjRfdCBhMywgdWludDY0X3QgYTQsIHVpbnQ2NF90IGE1LAog
ICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBhNiwgdWludDY0X3QgYTcsIHVpbnQ2NF90
IGE4KQp7CiAgICAvLyBXZSBwdXQgb3VyIGxpc3RlbmVyIG9uIGZkIHJlYWRzIGluIHJhbmdlIFtD
QVRDSF9CQVNFLCBDQVRDSF9CQVNFICsgMV0KICAgIGlmIChudW0gPT0gMCkgeyAvLyBzeXNfcmVh
ZAogICAgICAgIHN3aXRjaCAoYTEpCiAgICAgICAgewogICAgICAgICAgICBjYXNlIENBVENIX0JB
U0UgKyAwOgogICAgICAgICAgICAgICAgY291bnRpbmcgPSB0cnVlOwogICAgICAgICAgICAgICAg
Y291bnRpbmdfZm9yID0gcHRocmVhZF9zZWxmKCk7CiAgICAgICAgICAgICAgICBpbnNuX2NvdW50
ID0gMDsKICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICBjYXNlIENBVENIX0JBU0Ug
KyAxOiB7CiAgICAgICAgICAgICAgICBjb3VudGluZyA9IGZhbHNlOwogICAgICAgICAgICAgICAg
Y291bnRpbmdfZm9yID0gMDsKICAgICAgICAgICAgICAgIGlmIChhMyA9PSA4KSB7CiAgICAgICAg
ICAgICAgICAgICAgLy8gSW4gY2FzZSBvZiB1c2VyIGVtdWxhdGlvbiBpbiBRRU1VLCBhZGRyZXNz
ZXMgYXJlIDE6MSB0cmFuc2xhdGVkLCBzbyB3ZSBjYW4gdGVsbCB0aGUgY2FsbGVyCiAgICAgICAg
ICAgICAgICAgICAgLy8gbnVtYmVyIG9mIGV4ZWN1dGVkIGluc3RydWN0aW9ucyBieSBqdXN0IHdy
aXRpbmcgaW50byB0aGUgYnVmZmVyIGFyZ3VtZW50IG9mIHJlYWQuCiAgICAgICAgICAgICAgICAg
ICAgKih1aW50NjRfdCopYTIgPSBpbnNuX2NvdW50OwogICAgICAgICAgICAgICAgfQogICAgICAg
ICAgICAgICAgcHJpbnRfaW5zbl9jb3VudCgpOwogICAgICAgICAgICAgICAgYnJlYWs7CiAgICAg
ICAgICAgIH0KICAgICAgICAgICAgZGVmYXVsdDoKICAgICAgICAgICAgICAgIGJyZWFrOwogICAg
ICAgIH0KICAgIH0KICAgIGlmIChudW0gPT0gMyAmJiBvbl9ldmVyeV9jbG9zZSkgeyAvLyBzeXNf
Y2xvc2UKICAgICAgICBwcmludF9pbnNuX2NvdW50KCk7CiAgICB9Cn0KClFFTVVfUExVR0lOX0VY
UE9SVCBpbnQgcWVtdV9wbHVnaW5faW5zdGFsbChxZW11X3BsdWdpbl9pZF90IGlkLAogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgcWVtdV9pbmZvX3QgKmlu
Zm8sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpCnsKICAgIGludCBpOwogICAgZm9yIChpID0gMDsgaSA8IGFyZ2M7IGkrKykg
ewogICAgICAgIGlmICghc3RyY21wKGFyZ3ZbaV0sICJvbl9ldmVyeV9jbG9zZSIpKSB7CiAgICAg
ICAgICAgIG9uX2V2ZXJ5X2Nsb3NlID0gdHJ1ZTsKICAgICAgICAgICAgY291bnRpbmcgPSB0cnVl
OwogICAgICAgICAgICBjb3VudGluZ19mb3IgPSBwdGhyZWFkX3NlbGYoKTsKICAgICAgICB9CiAg
ICB9CgogICAgcWVtdV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV90Yl90cmFuc19jYihpZCwgdmNwdV90
Yl90cmFucyk7CiAgICBxZW11X3BsdWdpbl9yZWdpc3Rlcl92Y3B1X3N5c2NhbGxfY2IoaWQsIHZj
cHVfc3lzY2FsbCk7CiAgICByZXR1cm4gMDsKfQo=
--000000000000fc6bdb05a3bb310b
Content-Type: application/octet-stream; name="test.c"
Content-Disposition: attachment; filename="test.c"
Content-Transfer-Encoding: base64
Content-ID: <f_k98oiv5n0>
X-Attachment-Id: f_k98oiv5n0

I2luY2x1ZGUgPHN0ZGludC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHN0ZGxpYi5o
PgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CgojZGVmaW5lIENBVENI
X0JBU0UgMHhjYWZlYmFiZQoKc3RhdGljIHZvaWQgc3RhcnRfY291bnRpbmcoKSB7CiAgICBjaGFy
IGJ1ZjsKICAgIGludCBydiA9IHJlYWQoQ0FUQ0hfQkFTRSwgJmJ1ZiwgMSk7CiAgICAodm9pZCly
djsKfQoKc3RhdGljIHZvaWQgZW5kX2NvdW50aW5nKCkgewogICAgdWludDY0X3QgY291bnRlciA9
IDA7CiAgICBpbnQgcnYgPSByZWFkKENBVENIX0JBU0UgKyAxLCAmY291bnRlciwgc2l6ZW9mKGNv
dW50ZXIpKTsKICAgICh2b2lkKXJ2OwogICAgcHJpbnRmKCJXZSBnb3QgJWxsZCBmcm9tIFRDR1xu
IiwgY291bnRlcik7Cn0KCmludCBnbG9iYWwgPSAwOwoKdHlwZWRlZiBzdHJ1Y3QgewogICAgaW50
IGRlbGF5Owp9IFRocmVhZEFyZzsKCnN0YXRpYyB2b2lkKiB0aHJlYWRfZm4odm9pZCogdmFyZykg
IHsKICAgIFRocmVhZEFyZyogYXJnID0gdmFyZzsKICAgIHVzbGVlcChhcmctPmRlbGF5KTsKICAg
IGZyZWUoYXJnKTsKICAgIHJldHVybiBOVUxMOwp9CgppbnQgbWFpbihpbnQgYXJnYywgY2hhcioq
IGFyZ3YpIHsKICAgIGludCBpOwogICAgaW50IHJlcGVhdCA9IDEwMDsKI2RlZmluZSBUSFJFQURf
TlVNIDEwCiAgICBwdGhyZWFkX3QgdGhyZWFkc1tUSFJFQURfTlVNXTsKCiAgICBpZiAoYXJnYyA+
IDEpIHsKICAgICAgICByZXBlYXQgPSBhdG9pKGFyZ3ZbMV0pOwogICAgfQoKICAgIGZvciAoaSA9
IDA7IGkgPCBUSFJFQURfTlVNOyBpKyspIHsKICAgICAgICBUaHJlYWRBcmcqIGFyZyA9IGNhbGxv
YyhzaXplb2YoVGhyZWFkQXJnKSwgMSk7CiAgICAgICAgYXJnLT5kZWxheSA9IGkgKiAxMDA7CiAg
ICAgICAgcHRocmVhZF9jcmVhdGUodGhyZWFkcyArIGksIE5VTEwsIHRocmVhZF9mbiwgYXJnKTsK
ICAgIH0KCiAgICBzdGFydF9jb3VudGluZygpOwogICAgZm9yIChpID0gMDsgaSA8IHJlcGVhdDsg
aSsrKSB7CiAgICAgICAgZ2xvYmFsICs9IGk7CiAgICB9CiAgICBlbmRfY291bnRpbmcoKTsKCiAg
ICBmb3IgKGkgPSAwOyBpIDwgVEhSRUFEX05VTTsgaSsrKSB7CiAgICAgICAgcHRocmVhZF9qb2lu
KHRocmVhZHNbaV0sIE5VTEwpOwogICAgfQoKICAgIHJldHVybiAwOwp9
--000000000000fc6bdb05a3bb310b--

