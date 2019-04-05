Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF680C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 08:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C80217D4
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 08:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C80217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38226 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCKWp-0005PN-Dg
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 04:48:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKW1-000562-Hi
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCKW0-0007fN-1n
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:48:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCKVy-0007eP-FB
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 04:47:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so6931714wra.12
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 01:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=dIE9rtaFT+3EvyqaaT8yNbpfSDsSVsPZ0ZZrnjxiIRw=;
	b=qK9KDu2SO/bKTD969syKQ8H6OUyChnTTEfv2MdDqv8UgVXqSDNpiWML8cn3fPfJuag
	5CuGlBEa5ZC37vOWRfxnrFoLxyZ49S1atzvDcSQEfWGsy8rEqdejsht3pSCS4NeDGqzC
	RcTqGmRgcLYe6kq53ofU6fiN8fz0wDzAqcopLeBy/gDOcnum2v0R7oSBAIP7USyDCsjM
	cAtEbWh/ZhMsonAgG6uhU75Hryv/DFsnh8mBZNIGYixA03B2tpnmv+rEvL6LAaKd+g71
	c8NNAvoudNjukaQ8Xc8yvSSY0IU35+jLOGN6GNektMtP70dZd+UTaxkRf+SgVU1KXR24
	18NA==
X-Gm-Message-State: APjAAAWGV+GhI8uYyclXPL9JLRFZQCdiXlW4XfkQQKa2K8VvFjlvUF6z
	MjPrDYPlwOs49/RgZBwDkOWFEg==
X-Google-Smtp-Source: APXvYqyPoo7brjeqtCvbKR/xnanCjWidzWS/Dzq9ICDCmDNekLEzkENi9zQfqERBNGO0/GK1bDZMcw==
X-Received: by 2002:a5d:5284:: with SMTP id c4mr7704921wrv.281.1554454076033; 
	Fri, 05 Apr 2019 01:47:56 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id a8sm2083397wmf.33.2019.04.05.01.47.55
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 01:47:55 -0700 (PDT)
To: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
	Michael Tokarev <mjt@tls.msk.ru>
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
Date: Fri, 5 Apr 2019 10:47:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405084754.70FJjkI-28HsOT7qZ-pWVRGcmX5bzRQODvR4HKW69f8@z>

Hi Helge,

On 4/5/19 9:56 AM, Helge Deller wrote:
> On 05.04.19 03:34, Peter Maydell wrote:
>> On Fri, 5 Apr 2019 at 01:59, Helge Deller <deller@gmx.de> wrote:
>>> If a non-release architecture is found, and it's known that there is no
>>> native TCG support for that CPU, automatically fall back to the TCI
>>> implementation instead of requesting the user to run configure again
>>> with the --enable-tcg-interpreter option.
>>>
>>> This change simplifies building qemu in automatic build environments
>>> (like in my case the debian buildds) because one does not need to
>>> special case on the architectures.
>>
>> I don't think we should do this. TCI is unmaintained, has several
>> known flaws,
> 
> Just out of interest: Is there a list with those flaws somewhere?

The last big discussion is in this thread:
https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg06528.html

>> does not provide the level of performance that
>> people expect from QEMU, and we've talked about removing it
>> altogether. In particular, distros should not automatically ship
>> a TCI QEMU -- it's something that a user can use if they
>> explicitly opt into but which I don't think we want to surprise
>> anybody with.
> 
> I won't argue against your points. They are all valid.
> 
>> If we care about a host architecture we should support it
>> with a proper TCG backend. If we don't care that much we
>> shouldn't support it.
> 
> Looking just at some of the debian "ports" (non-release) architectures:
> alpha, hppa, ia64, m68k, powerpc, sh4, sparc64
> Most likely nobody will ever care enough to write a TCG backend for those,
> and it doesn't even make sense because they are so much slower than
> the currently supported TCG backend architectures. So why should one want
> to emulate a fast x86 machine on slow m68k for example?

From experience: when a m68k compiler is only provided as a x86 binary
and you want to recompile m68k code on an embedded m68k with no network
access.

Another example appeared last year on the list, when using a binary
compiled for a more recent ISA on an outdated ISA.

> The only reason when it *can* make sense is, when you need "basic"
> emulation or availability of binaries for cross-dependecies in distros,
> e.g. to build other packages or to be able to install other packages.
> As one example, many packages depend on libvirt (frontend tools, monitoring
> stuff, ...) and libvirt again depends on some qemu binaries.
> So, having qemu buildable (even if the result is slow) makes life easier.
> 
> I know, my point above now turns into a "distro packaging" issue.
> That's why I'm questioning, why should distros (or even direct end-users)
> be forced to distinguish between architectures?
> Shouldn't running "./configure" find out what's available and then
>  auto-configure itself to the *best* what's possible?
> 
> And, my patch still prints the warning that that's an unsupported
> architecture, at the end of configure there is still the big warning
> about "*this architecture may go away*", and if someone complains about
> performance on such an architecture you can still happily invite him to
> write the TCG backend.
> 
> Anyway, if you think Philippe's suggestion of "why not add a "hppa" case selecting
> TCI in the switch?" is the better solution, then I'm happy to send such a patch
> instead.

I suggested that as a "less worth" approach, but I'm 100% with Peter on
this.
I understand your use and still think this should be handled by Debian
for his "ports" (non-release) architectures, as an explicit selected
option on the list you mentioned (alpha, hppa, ia64, m68k, powerpc, sh4,
sparc64).

