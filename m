Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53897C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 07:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AED4217D4
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 07:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HD4xmUCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AED4217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37750 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCJjZ-00071r-Bv
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 03:57:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hCJiY-0006ML-UI
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hCJiX-00085G-Ci
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:56:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:56341)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1hCJiX-0007xI-0L
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 03:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1554451007;
	bh=rk9/oY94owm8Hj+BxxWFEF+IS4kkrm29M2edbHVteaY=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=HD4xmUCB2njzW+yZ53nGqZS7dwFq47XHmFkvXnWz7MavPIdl3zCvrAgxuW08Uul2U
	ZKBAqk8cHO4q8jM+Bkd2HBt0nOyoj+h/3s3h3XdDy03AJCDFup2RdnCJwN8L0UFws4
	NQP/6DkD964JTzCZDZ/mxmaYnwDYhzzKEHjhP+5g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.131.3]) by mail.gmx.com (mrgmx002
	[212.227.17.190]) with ESMTPSA (Nemesis) id 0MdrK9-1hZDuc14ov-00PbcC;
	Fri, 05 Apr 2019 09:56:47 +0200
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
From: Helge Deller <deller@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; keydata=
	xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
	y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
	+sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
	KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
	OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
	AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
	AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
	UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
	+ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
	iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
	288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
	vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
	zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
	+0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
	UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
	T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
	gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
	BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
	91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
	kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
	lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
	ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
	KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
Date: Fri, 5 Apr 2019 09:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XjA1wyQsLSrVJvt3CzqLFvAjdDmGtfIpoCl50d6QHTUHQMqzN/b
	9LpKGVFaiQmhRo+6ffFMzOPapINGB76n4n5+tGjqT3Exd4IOUuPFg3Jh1v8dx9KiHwr9Han
	8lq6lnASi6a136kb9BfZoyAe2uU15et5SRPlKOeLjquCbn8UEqdFnYcRMEkOkvtiVyR5GzT
	h5VfaSj3EJGBvSxOY0lBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6NC8rt6KXZs=:Xn97CZaAbVi4rux5iehb7B
	eR7X5syrpK+GvwEz+HRhvdGcRTjHuW9ZzOwXCE7sIq3Qp14DAhaWiSgXRMbp4bDPmvOnsHK1I
	nlw4o/+3YmmwAQLa5ZffL1zkb9v4Lpy3dPyLDyFvFS9WSkIMNHZXeJ4fn6IpA/A9a5LyDauRW
	f+WG3deKWcZxW4rpgVY9EFtaoKc6MSwtLl414U9pMucVSfZlT51ZWZqL9petzw7Ouq2BoJUgN
	jv63bvXya3NVQDqKgucKrNVz0jpNPf/xFpN0TosvMZWNSDP49iBE3A5vjixokTsxEFQKPjOWR
	Sv/KekOlGXcmkCWY6ru0tMD04h6n2Qtt2xtIlmxNOczo4bOHkajnv+NHkAEoabwRAC/pHVi4r
	tNfqCm7bwPRQaueGaHvyid4QVH5yfuJMH9I0LNzt7rYXZuwfngNT65W/7Yf47ksDpOacYN1DF
	U6qJC4XW7iS0TakqlTYtvxxXM5SQQkGJTjiBsF7fqa3pRrhikfjb9YEcJUnoJDIXUjlnvJSA5
	BL1/h/BA/qsVX2E/UUjh3Rl4+Xj0jCh8FGVyxDVCdiOXRI1bD6UQACX4fnZpznBjGF6N/2Lkx
	61ZGr9IUGTnaLHXGc8AkGIQG7+EQRSKasCe1E8dXTfO/FWd3xbal/3wFyWTInbaq1Q398F5M1
	KyFUgglbm4G+ZU9BPEd1tPAc5MBlrI08xeDRfwCnavWwkKHdzKMGXWe4/xSK9H5FlNUvhAVO8
	XqPriwEXlW2qozfhdeiaG7UbIqPoJ1JU1IY15v8sZuFbmfsl8zyW48g6LU4GcI0vMcXsDL5D0
	wxzFS7UrUMMAafC/n5c3QMW7A5ehEfSmacxcFcyKxHD4QvDHzLSzO+HOs5to2QsbMpM/JFSL5
	NMLNXP2SO4B2nx6fwu/Eud/x6h6dYrQyj+lOdBS942hd6EtwPfaMeHFdgw0jaA
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.19
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405075646.9U1eLnpKcxhol-IG4QlfUvwQrOCjTfYcJMq2HfxNY8U@z>

Hi Peter,

On 05.04.19 03:34, Peter Maydell wrote:
> On Fri, 5 Apr 2019 at 01:59, Helge Deller <deller@gmx.de> wrote:
>> If a non-release architecture is found, and it's known that there is no
>> native TCG support for that CPU, automatically fall back to the TCI
>> implementation instead of requesting the user to run configure again
>> with the --enable-tcg-interpreter option.
>>
>> This change simplifies building qemu in automatic build environments
>> (like in my case the debian buildds) because one does not need to
>> special case on the architectures.
>
> I don't think we should do this. TCI is unmaintained, has several
> known flaws,

Just out of interest: Is there a list with those flaws somewhere?

> does not provide the level of performance that
> people expect from QEMU, and we've talked about removing it
> altogether. In particular, distros should not automatically ship
> a TCI QEMU -- it's something that a user can use if they
> explicitly opt into but which I don't think we want to surprise
> anybody with.

I won't argue against your points. They are all valid.

> If we care about a host architecture we should support it
> with a proper TCG backend. If we don't care that much we
> shouldn't support it.

Looking just at some of the debian "ports" (non-release) architectures:
alpha, hppa, ia64, m68k, powerpc, sh4, sparc64
Most likely nobody will ever care enough to write a TCG backend for those,
and it doesn't even make sense because they are so much slower than
the currently supported TCG backend architectures. So why should one want
to emulate a fast x86 machine on slow m68k for example?

The only reason when it *can* make sense is, when you need "basic"
emulation or availability of binaries for cross-dependecies in distros,
e.g. to build other packages or to be able to install other packages.
As one example, many packages depend on libvirt (frontend tools, monitorin=
g
stuff, ...) and libvirt again depends on some qemu binaries.
So, having qemu buildable (even if the result is slow) makes life easier.

I know, my point above now turns into a "distro packaging" issue.
That's why I'm questioning, why should distros (or even direct end-users)
be forced to distinguish between architectures?
Shouldn't running "./configure" find out what's available and then
 auto-configure itself to the *best* what's possible?

And, my patch still prints the warning that that's an unsupported
architecture, at the end of configure there is still the big warning
about "*this architecture may go away*", and if someone complains about
performance on such an architecture you can still happily invite him to
write the TCG backend.

Anyway, if you think Philippe's suggestion of "why not add a "hppa" case s=
electing
TCI in the switch?" is the better solution, then I'm happy to send such a =
patch
instead.

Helge

