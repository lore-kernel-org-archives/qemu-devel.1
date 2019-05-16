Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEADC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 20:08:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F9472070D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 20:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9472070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34730 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRMfj-0003f7-3p
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 16:08:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRMeu-0003O1-D5
	for qemu-devel@nongnu.org; Thu, 16 May 2019 16:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRMet-0003So-5g
	for qemu-devel@nongnu.org; Thu, 16 May 2019 16:07:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRMes-0003KR-UO
	for qemu-devel@nongnu.org; Thu, 16 May 2019 16:07:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so4683042wrs.11
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 13:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=E9H/DeXmvz37uJEUaxElMxrx5QNtyFjMp1VcIH3tiEY=;
	b=FKtlLAogMfytzTquBfaes+OlnF2Q05+16xx9dycwvcfpcyygujiv+sZQDhJNo50+m4
	bC5DBgV3D113Zr0by86e1Uz0znT0H31xCvwxDO4vH09URpdw0mYOKL/VuP+9/LK40Vpe
	GvGwHW6/8wKCyvr12BJo8RZcYBasoN1tm/3BCCUheTUWAbGwwnjet0J6qAepB8SoF90u
	uu9oiTQLZXFXM0jFlPaYHktpU6gYgY/qAQ8MgrFCVDqGSR+mHB/GAclrnhZAMnbqKbqp
	29ZZrArFe1FVD6JrxZPm84ydb1cdqZMBrAhM5zB7cvKvv8ZpRs1V98U56jTCrvU3ifZR
	DkXg==
X-Gm-Message-State: APjAAAVG2kSiT99hZaEa/gVYn68Sta2kbSimjxDVtKlDYWirMPy8cejK
	1C4k46fL23B8GiW6uzmF6IVLgg==
X-Google-Smtp-Source: APXvYqzsZnp8/I6u3BW77h+f+2GR6YlXOUYxGJTStyGhUsN3Nt788doLzlzNlQDg5Wv0C/DDdkTvdw==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr6068995wrt.197.1558037236081; 
	Thu, 16 May 2019 13:07:16 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	h188sm10546323wmf.48.2019.05.16.13.07.13
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 13:07:15 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87d0mwatbu.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3c7c7980-bb0a-c6f5-1f7d-56054190bb25@redhat.com>
Date: Thu, 16 May 2019 22:07:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87d0mwatbu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] Maintainers,
 please tell us how to boot your machines!
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
Cc: Paul Burton <pburton@wavecomp.com>, Chris Wulff <crwulff@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
	Jia Liu <proljc@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
	Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
	Magnus Damm <magnus.damm@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	=?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Alistair Francis <alistair@alistair23.me>,
	Fabien Chouteau <chouteau@adacore.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Paul Durrant <paul.durrant@citrix.com>,
	Peter Chubb <peter.chubb@nicta.com.au>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Richard Henderson <rth@twiddle.net>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Cornelia Huck <cohuck@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Michael Walle <michael@walle.cc>,
	Thomas Huth <huth@tuxfamily.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Markus,

On 3/12/19 6:36 PM, Markus Armbruster wrote:
> Dear board code maintainers,
> 
> This is a (rather late) follow-up to the last QEMU summit.  Minutes[*]:
> 
>  * Deprecating unmaintained features (devices, targets, backends) in QEMU
> 
>    QEMU has a mechanism to deprecate features but there remains a lot of
>    old unmaintained code.  Refactoring is hindered by untested legacy
>    code, so there is a desire to deprecate unmaintained features more
>    often.
> 
>    [...]
> 
>    We should require at least a minimal test for each board; if nobody
>    cares enough to come up with one, that board should be deprecated.
> 
>    [...]
> 
>    Also see the qemu-devel discussion about deprecating code:
>    https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.html.
> 
> That's a link to "Minutes of KVM Forum BoF on deprecating stuff".
> Quote:
> 
>  * One obvious class of candidates for removal is machines we don't know
>    how to boot, or can't boot, say because we lack required firmware
>    and/or OS.
> 
>    Of course, "can boot" should be an automated test.  As a first step
>    towards that, we should at least document how to boot each machine.
>    We're going to ask machine maintainers to do that.
> 
> Let's get going on this.
> 
> I gathered the machine types, mapped them to source files, which I fed
> to get_maintainer.pl.  Results are appended.  If you're cc'ed,
> MAINTAINERS fingers you for at least one machine type's source file.
> Please tell us for all of them how to to a "meaningful" boot test.
> 
> For now, what's "meaningful" is entirely up to you.  Booting Linux
> certainly is.
> 
> Make sure to include a complete QEMU command line.  If your QEMU command
> line requires resources beyond the QEMU source tree and what we build
> from it, please detail them, and provide download URLs as far as
> possible.
> 
> Goals for this exercise:
> 
> * Gather information we need to cover more machines in our automated
>   testing.
> 
>   Related work:
>   [PATCH v4 00/19] Acceptance Tests: target architecture support
>   Message-Id: <20190312121150.8638-1-crosa@redhat.com>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg03881.html
> 
> * Maybe identify a few machines we don't know how to boot anymore.
> 
> Thanks in advance for your help!

How do you want to proceed with all the information provided in this
thread? I think a big table in the wiki collecting the answers is ideal.
What do you think?

Regards,

Phil.

