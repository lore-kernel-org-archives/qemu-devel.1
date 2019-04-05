Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2073CC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD94F21738
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 09:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="hQgPf+qI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD94F21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKnY-0001RV-W0
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 05:06:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hCKlf-0008LJ-GU
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hCKkW-0004Nl-L9
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:03:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:56783)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1hCKkV-0004Ht-TN
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 05:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1554454973;
	bh=btlDYCKN2RZuNuaO18wbNPl2lC2UdagYjrkQ4Rlbdn4=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=hQgPf+qI3DFOejq8hjBaocpE5uDIQbZITGpJaENxVh9txpRMIDr3rEyuV7BA3OLOt
	RV4fW8ttyzAcryEJVqDj0zdza78eq4txXdGKH+IBDtR4yqPOIi47jPoITqW2yulkVW
	VktibmINRFMW14VTUS5cbRdcic46k9QDBUwP/Ul8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.131.3]) by mail.gmx.com (mrgmx101
	[212.227.17.168]) with ESMTPSA (Nemesis) id 0M4CB5-1gu7J815iF-00rq4g;
	Fri, 05 Apr 2019 11:02:53 +0200
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<20190405082613.GC6105@redhat.com>
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
Message-ID: <457ec791-3691-2ebb-e225-bd42a7aee627@gmx.de>
Date: Fri, 5 Apr 2019 11:02:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405082613.GC6105@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5gY+91r99ksEaR+u0j9MBwJTcitlbtjDzhF1PrgJUx1czPlr8UW
	vms6t6GuOzM2paKMc5P9nTbxN0q3e4GfP1Envh8pVnCt84wDKrDgEssTXcDu7gie8iCE+6f
	q1QdQX9F3WaoDCPmwZLiPQxJHvStWZyRBsaktAyTvHKH4rfJMKrE6tGfAthan8bx6NBd80+
	jcM1dUVieXP8gtMWho0Xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IB609uHO4lo=:qZWRVz+1xgy4VtTzQ5kbbM
	uR3PRNRBmwx5Oeo5z7X8SyBvIjposslt6ScjpM9IFEV0d685HPqfTxdxmz5IHCfD3auCLdU+4
	9EZFyVQD3Hs6WrtT8PTTNuAn0vEYi/iGtniQJpTlo8hruMl3nLLeT+4Ak15ESD791Ukk04RBU
	3cYyWKiNeZFdK0Ki2toDgUBUg/o6Do5Imtdldo0NWQJYPRYGuP315ZFBO+9Kxwej7gP2cX57j
	bjkQofLOE0iJg0qiQhNgNsFKtAuK+nPcRToknXo6uwX2ZKps8c9DOvSBm95SLzsBeF8LZddm9
	e24N8EK0ieGFY187aW6idrEWC/Luj+/+iFBuRmfO56rTTX/V1I0YIyr9Dq9A1onCJ0V/lfCWt
	BP+S/nVvaGKiq3/Qt/gGLYj9vjNGOXLskiBeDmJDVDLayp58s2uSM6o9DGJBnguKx47Iha8Zc
	MeXarBZXYARTxs2v/co/Bh/pjOlWMrWZA9UblTpza+6skJmOxK+pzx18xwVmqQGcT7rNYdR0u
	rqBN/O7u+TG/5GLlkl86Iytz4vAncoDQ9ruN5B1WYYEDklz76XBrRpDjxj/pOLWO+mOHbQV0m
	je91rO/tB/znUy2AEnjz3AItiB2qZuJlLMoZToBBxd01O+4IVm/wwJR2lGGI46+yAlivBxMU0
	kPXTdF5mxK37LazujWQpi0fjDu5Mw//nmaT7fl32BMTd8VddfUhlyqXF7OyxgSfQ/T5ZIfKzT
	XxkLA746DjW55KgTL9ywM/fnLxuZDGJ6V8R6+Sf4XhZ8w7yYLT77ffc7hYINk5AdUlVjJ5Eew
	W/TRQjxkPwNNUC1hGnDozJjaLZURNP6lIzaGaA+PgsDGfUz4X9uBcFwfrlBsBk1nlEQM46ubk
	aycKHBXLeZlQEN+L04YMhF7I9TScjAtUuUkLH43MCjXKqJB8AMhBGAbdQZRi1x
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.22
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405090252.C3xqmOIBIfq5rR8KjKVKNbxba8ndTLMtqiggFK8wjV4@z>

On 05.04.19 10:26, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Apr 05, 2019 at 09:56:46AM +0200, Helge Deller wrote:
>> Hi Peter,
>>
>> On 05.04.19 03:34, Peter Maydell wrote:
>>> On Fri, 5 Apr 2019 at 01:59, Helge Deller <deller@gmx.de> wrote:
>>>> If a non-release architecture is found, and it's known that there is =
no
>>>> native TCG support for that CPU, automatically fall back to the TCI
>>>> implementation instead of requesting the user to run configure again
>>>> with the --enable-tcg-interpreter option.
>>>>
>>>> This change simplifies building qemu in automatic build environments
>>>> (like in my case the debian buildds) because one does not need to
>>>> special case on the architectures.
>>>
>>> I don't think we should do this. TCI is unmaintained, has several
>>> known flaws,
>>
>> Just out of interest: Is there a list with those flaws somewhere?
>>
>>> does not provide the level of performance that
>>> people expect from QEMU, and we've talked about removing it
>>> altogether. In particular, distros should not automatically ship
>>> a TCI QEMU -- it's something that a user can use if they
>>> explicitly opt into but which I don't think we want to surprise
>>> anybody with.
>>
>> I won't argue against your points. They are all valid.
>>
>>> If we care about a host architecture we should support it
>>> with a proper TCG backend. If we don't care that much we
>>> shouldn't support it.
>>
>> Looking just at some of the debian "ports" (non-release) architectures:
>> alpha, hppa, ia64, m68k, powerpc, sh4, sparc64
>> Most likely nobody will ever care enough to write a TCG backend for tho=
se,
>> and it doesn't even make sense because they are so much slower than
>> the currently supported TCG backend architectures. So why should one wa=
nt
>> to emulate a fast x86 machine on slow m68k for example?
>>
>> The only reason when it *can* make sense is, when you need "basic"
>> emulation or availability of binaries for cross-dependecies in distros,
>> e.g. to build other packages or to be able to install other packages.
>> As one example, many packages depend on libvirt (frontend tools, monito=
ring
>> stuff, ...) and libvirt again depends on some qemu binaries.
>> So, having qemu buildable (even if the result is slow) makes life easie=
r.
>
> If it is just a matter of satisfying dependencies, it is easy to build
> a minimal libvirt that is essentially just the client libraries and not
> the QEMU driver that would in turn allow other packages to build. Altern=
atively
> it should be possible to build the downstream apps with their libvirt de=
p
> disabled avoiding pulling in the whole virtualization chain as a build
> pre-req.

libvirt was just one example, and yes, it's possible to work around in
multiple ways.

As another example, even if I only want to build "qemu-img", I still need
to manually give the --enable-tcg-interpreter configure option.

>> I know, my point above now turns into a "distro packaging" issue.
>> That's why I'm questioning, why should distros (or even direct end-user=
s)
>> be forced to distinguish between architectures?
>> Shouldn't running "./configure" find out what's available and then
>>  auto-configure itself to the *best* what's possible?
>
> "best" depends on the POV. You want configure to enable support on
> hppa by default since you have an interest in that architecture, which
> is fine. The QEMU maintainers, however, have a POV that considers
> raising an error by default to be the "best" solution for architectures
> that are considered unsupported, requiring explicit arg to optin to use
> unsupported features.

Yes, fair point.
Sadly such special treatment by projects makes life for me
as an architecture maintainer much harder :-(

Helge

