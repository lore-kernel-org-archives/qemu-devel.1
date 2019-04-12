Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69ECC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFD92084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFD92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34564 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEuMq-0002AL-Px
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 07:29:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEuM7-0001rM-AS
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEuM6-0005v8-6A
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:28:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEuM5-0005uA-Tb
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:28:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so11445027wrn.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 04:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=oC6gUOqbj8+vvIO+XENlH40EKqrILfP0V9FiVPjGLI0=;
	b=nU4xHwNK+exF3+9bC28LGlEyk5BgtwLvlCxgkdv0u6vh0LLsmXcLUlhiM39yeC1LzK
	fNVfysGqqQOVQIds7W3q29VoMjAKzttixDzjMv3NnUGIOf+eCk1xx8+48z+vrNrFYIey
	B9aplV9vxSVEhtNEBZTLEO9dOboqNnORkhzxCvWgYMrCnd2aE+yEvH3LYAchcjBYo5TD
	SNgUbIJVSqHTGO1YWIQZ5z0lVwtch4+BdedyacSbNUnrZGOHMdtXAseSAsid9muTsnKI
	TW9sdNMx3Wn833m2ByuTb+ntfpqN+Kgjz+Elg1+X61B/PrXmIjcYpD6m9H6ys0U49TF1
	34Mw==
X-Gm-Message-State: APjAAAWLBU/lM+p4EduFQlGIPPwp06pXEiZTz2N7zA7Mg1QxG8wQ3RlM
	8wHEcUu0WRF5L9EbdUXzymBaGg==
X-Google-Smtp-Source: APXvYqxqQ3eYHLfl31AnXM73jR06h1lsKlCSpzKm0BGdSxOP94FrNt9xtfhUN5WOU9476GPYyc8jlw==
X-Received: by 2002:adf:db0c:: with SMTP id s12mr35487884wri.184.1555068503446;
	Fri, 12 Apr 2019 04:28:23 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	v17sm7273270wmc.30.2019.04.12.04.28.20
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 04:28:22 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
	<f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>
References: <87d0mwatbu.fsf@dusky.pond.sub.org>
	<CAAdtpL6VCiXLbTWyJo4cbCNLjOCPr6KrH8KTqEq1V=CTMYKubQ@mail.gmail.com>
	<6fe1a987-c3c5-3af5-74a4-fc4cd08d2380@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2056cff2-78f8-1079-8d05-e758971d73ec@redhat.com>
Date: Fri, 12 Apr 2019 13:28:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6fe1a987-c3c5-3af5-74a4-fc4cd08d2380@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
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
Cc: Paul Burton <pburton@wavecomp.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
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
	Richard Henderson <rth@twiddle.net>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Fabien Chouteau <chouteau@adacore.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Paul Durrant <paul.durrant@citrix.com>, Jan Kiszka <jan.kiszka@web.de>,
	=?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Chris Wulff <crwulff@gmail.com>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Michael Walle <michael@walle.cc>, Thomas Huth <huth@tuxfamily.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cornelia Huck <cohuck@redhat.com>, Peter Chubb <peter.chubb@nicta.com.au>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412112814.coLdXtl9ICsA3ZJxiPfzHA5ILJRBtqkPce3Nu1mBws4@z>

On 4/12/19 1:11 PM, Thomas Huth wrote:
> On 13/03/2019 02.06, Philippe Mathieu-Daudé wrote:
>> '
>> On Tue, Mar 12, 2019 at 6:44 PM Markus Armbruster <armbru@redhat.com> wrote:
> [...]
>>>     = hw/arm/nseries.c =
>>>     Andrzej Zaborowski <balrogg@gmail.com> (odd fixer:nSeries)
>>>     Peter Maydell <peter.maydell@linaro.org> (odd fixer:nSeries)
>>>     qemu-arm@nongnu.org (open list:nSeries)
>>
>> images:
>> http://stskeeps.subnetmask.net/meego-n8x0/
>>
>> $ qemu-system-arm -M n810 -kernel
>> meego-arm-n8x0-1.0.80.20100712.1431-vmlinuz-2.6.35~rc4-129.1-n8x0
>> -append "root=/dev/mmcblk0p1 console=ttyS0 printk.time=0 rootwait" -m
>> 130 -sd meego-arm-n8x0-1.0.80.20100712.1431-sda.raw -serial stdio
> 
> That does not work for me - I only get a white screen that turns to
> black after half a second, and no output (also not on the serial
> console). Does it still work for you with the latest QEMU master branch?

It is broken since a long time. I guess rememember some irc chat about
it previous to v2.9.0, then I added this line to my TODO "this command
used to work, see what's wrong here". I never bisected to figure out
since when it got bitroted.

