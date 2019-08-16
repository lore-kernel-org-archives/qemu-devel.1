Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C83C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F4B62086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 12:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clEWcOMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4B62086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyawz-0003Mo-34
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 08:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyavx-0002f3-1x
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyavv-0003G7-IF
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:02:16 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyavv-0003F7-Ad
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 08:02:15 -0400
Received: by mail-oi1-x244.google.com with SMTP id v12so939215oic.12
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mTlvEQlwQxD+m3KCNTaQoPeyNkMz5awwGRbjpwvjjP4=;
 b=clEWcOMwE8ig/swEBxhVv+eYRtLzVRYzOdNAT4xBz1bX72Ll6PNcMUKCk6v0uVvLrx
 gbPx/m8UOIXYiXCZbrLpf9UIGtcyFWe7DpeZw9T7/T8Ukh1ODM3ao3EOPf2kOk0uuVjQ
 bUZeznpOmQhe1FUF+okF/+PPmA8KUpDPhIhiJ7wBKTtPULvEjTz4+xf/Fli6y5ADfXjz
 wAtUkjimkuWh5hiC4Rnby+nHeZvZAls0ZUvR8nPjlmWmUtVuBOh2dpRg3fJCFwuHmrRL
 UX+oNlk9YxiwIXoNhIrGB+3JVYzEm4z+G8k4kxE8nzAserwn7lO+4r8E+ID6L6GcAsSq
 0SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mTlvEQlwQxD+m3KCNTaQoPeyNkMz5awwGRbjpwvjjP4=;
 b=DEXei8XGjhUNJq18WoqRFp7jBZYjFxj7ihQXlrAKOPzm+6ptLE0Bd6679VSDqkkg6C
 DD7i+VI+hQhD/RiKSLNof6nO3HV03CCakNfjtKWUxSxt5gawhtEJKkGfHpCxxuyWrBvl
 WP5C8Oyg5b6e0Oi+zgiOqc6k1b42mf6+eCLe8quo/E4YqDaklQpt7dYJGgx5HR5pFV50
 LvAMMuT+ngBDJAB5owjgb2nPWhyUsCZs+fGSYuQN0M4IbRofGUjA1QUs8t+uqlLvul97
 OCAxucRiMskqSWJ1WukmbiEbcaO2YYYghEoR+9roLzTKp8uORskowaTveF8RjGGio3pm
 +UsQ==
X-Gm-Message-State: APjAAAXmwjzv+BdKh3n9CQk1XtbgPRzdrDhcb6D9iFo3FRz49D0xXVyT
 2WSdu1jvGYT19Fgw+fQvP2X1uUSG9lUHq6xXlFTWIQ==
X-Google-Smtp-Source: APXvYqzT39k/DlDCfREc8tggE6tDp2LZAzaRwF8MATMyYj9oD8OFY8BqjW5qOATbiqowbjnwyMf+8eWQlW3FZMdwwIU=
X-Received: by 2002:aca:6185:: with SMTP id v127mr4861732oib.163.1565956934256; 
 Fri, 16 Aug 2019 05:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <43bc5e07ac614d0e8e740bf6007ff77b@tpw09926dag18e.domain1.systemhost.net>
 <a7d6eede-b152-4c06-8945-9607c663b99c@redhat.com> <1565955445398.83897@bt.com>
In-Reply-To: <1565955445398.83897@bt.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Aug 2019 13:02:03 +0100
Message-ID: <CAFEAcA-nihW1nuMOL-XCR_QxUXSXji=noe4eDNPHxkib4-_a6A@mail.gmail.com>
To: tony.nguyen@bt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v7 00/42] Invert Endian bit in SPARCv9 MMU
 TTE
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 Laszlo Ersek <lersek@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>,
 Eduardo Habkost <ehabkost@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, claudio.fontana@suse.com,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 sundeep subbaraya <sundeep.lkml@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Igor Mammedov <imammedo@redhat.com>, Fam Zheng <fam@euphon.net>,
 David Hildenbrand <david@redhat.com>, Palmer Dabbelt <palmer@sifive.com>,
 Keith Busch <keith.busch@intel.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Hannes Reinecke <hare@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 Magnus Damm <magnus.damm@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Corey Minyard <minyard@acm.org>, Stefan Weil <sw@weilnetz.de>,
 Yuval Shaia <yuval.shaia@oracle.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Stafford Horne <shorne@gmail.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>,
 Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Anthony Green <green@moxielogic.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Rob Herring <robh@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Max Reitz <mreitz@redhat.com>,
 Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Jiri Slaby <jslaby@suse.cz>,
 Marek Vasut <marex@denx.de>, Jia Liu <proljc@gmail.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paul Durrant <paul.durrant@citrix.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Jean-Christophe DUBOIS <jcd@tribudubois.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 16 Aug 2019 at 12:37, <tony.nguyen@bt.com> wrote:
>
> Hi Phillippe,
>
> On 8/16/19 7:58 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >On 8/16/19 8:28 AM, tony.nguyen@bt.com wrote:
> >> For each device declared with DEVICE_NATIVE_ENDIAN, find the set of
> >> targets from the set of target/hw/*/device.o.
> >>
> >> If the set of targets are all little or all big endian, re-declare
> >> the device endianness as DEVICE_LITTLE_ENDIAN or DEVICE_BIG_ENDIAN
> >> respectively.
> >
> >If only little endian targets use a device, that doesn't mean the device
> >is designed in little endian...
> >
> >Then if a big endian target plan to use this device, it will require
> >more work and you might have introduced regressions...
> >
> >I'm not sure this is a safe move.
> >
> >> This *naive* deduction may result in genuinely native endian devices
> >> being incorrectly declared as little or big endian, but should not
> >> introduce regressions for current targets.
> >
>
> Roger. Evidently too naive. TBH, most devices I've never heard of...

OTOH it's worth noting that it's quite likely that most of
the implementations of these DEVICE_NATIVE_ENDIAN devices
picked it in an equally naive way, by just copying some other
device's code...

thanks
-- PMM

