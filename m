Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F9CC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 12:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DA9206D3
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 12:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWTX0HQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DA9206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ij05L-00021k-2i
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 07:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iizxN-0004Yt-P6
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:03:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iizxI-0001qU-El
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:03:33 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iizxI-0001l9-6Z
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 07:03:28 -0500
Received: by mail-wr1-x442.google.com with SMTP id w15so1135958wru.4
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2019 04:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kEkfZBbwI9UW4FGLzbID4Jbcu/JHYiQ20+8enz8Ziv4=;
 b=RWTX0HQjA48xU0ZF63Tl5/RxWZ4/X0M7SL+XZHNsMuFx5ItvuZQyCsRwSlzAYVNrx+
 KeRdoJmbecmnn7PRMzloPGykCtDyTeJ6jFQb6cRcebIfRK6Op8s/HRXHzUnMTayISVTh
 d9WhRO0b+ntuXXksCtEbMmC6j9yBCVchxnpc2CcbCuGU6pcTL8dB3TDiD4K1iWbzVPA7
 nVs1k3MZU4EUzU3SEl0CFkVCF/RVoNS2uJ5P+heFMvTn37dMq+RvQDtQfUwFaB7wgwJw
 EbXHhDgcMXJkJb7TjvFGcPwjxdD8V4hohyyRXGPO6lTbSe78LSDfMo1VQXakwuN29udD
 34MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=kEkfZBbwI9UW4FGLzbID4Jbcu/JHYiQ20+8enz8Ziv4=;
 b=HnJhw17z3iXlU5oHrqRD8LB+CtoyShikDCRkm1K0mT2UTm2OvGs7hU95MacwKg/7+P
 2klc6hVjSLKEy9k2z+kl8AqKp498NU25tKBD+3vdYjG0Y1y3kyyglSQ3ZiSjyUjtBwI4
 PvzQqDlvSX3K7B/kPsWTgOjCfkpmpaMUrSjab32eIjcvoaJX6048Am4gQElD86/6mnUO
 xwl0M3opX7PtRZdCan/6yJ+G13XyS/TFD2XKfBPu3nHwwGuNunokeRsfPlbXoiadU29S
 8JwbombyjjwhbLDLlP1LG5vGmWWaQ81IaKPMaqePqe/MKFfcwIYC7030b1lLJ08AWyKH
 y3mQ==
X-Gm-Message-State: APjAAAWiUidUNBA58ISjUyDXcn2Nfqo30jRsZb+5hj0/D3EE7mvKahMI
 OjjJF+OPO7XNOHfXi7M2lXY=
X-Google-Smtp-Source: APXvYqwGAp7NpWAK2clTSW857AVRa6CSMbIcmxlqZZ1iwpG0BAN9rzCHupJm6llM+87NG4593ngbfA==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr25443373wrq.134.1577016206771; 
 Sun, 22 Dec 2019 04:03:26 -0800 (PST)
Received: from [10.0.0.124] ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id f65sm16134375wmf.2.2019.12.22.04.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Dec 2019 04:03:26 -0800 (PST)
Subject: Re: [Qemu-devel] Maintainers, please tell us how to boot your
 machines!
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <87d0mwatbu.fsf@dusky.pond.sub.org>
 <3c7c7980-bb0a-c6f5-1f7d-56054190bb25@redhat.com>
 <87a7flf04y.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <49740883-eb5a-1f6d-8dd4-9de1982aa6b1@amsat.org>
Date: Sun, 22 Dec 2019 13:03:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87a7flf04y.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paul Burton <pburton@wavecomp.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Jia Liu <proljc@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Paul Durrant <paul.durrant@citrix.com>, Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Stafford Horne <shorne@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Michael Walle <michael@walle.cc>,
 Thomas Huth <huth@tuxfamily.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 7:42 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> How do you want to proceed with all the information provided in this
>> thread? I think a big table in the wiki collecting the answers is ideal.
>> What do you think?
> 
> Yes, please!  I haven't been able to find the time...

I gathered all the information from this thread here:
https://wiki.qemu.org/Testing/Acceptance#Machines
(with a link in https://wiki.qemu.org/Testing#System_emulation).

I also added other info I collected during 4.2 merge window.

Should we suggest a new policy that new machines must have a test?
I'll later purpose some idea to deal with machines only running non
opensource code.

I think most of the data from the acceptance tests we have could be
generated (json?) and we could concat with another manual maintained
json (or yaml to json?) to have this table easily updatable on the wiki.
Now I remember why I had forgotten about HTML, it is painful to edit.

Thanks all for sharing this information.

Regards,

Phil.

