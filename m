Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E7BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 05:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2106920771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 05:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6sUt9gC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2106920771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy7jU-0003BH-CD
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 01:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jy7ir-0002hO-Nz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 01:55:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35932
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jy7ip-0002Wq-WE
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 01:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595397318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNBO9skmm15YEipEaKquJXRe58UQoDLUWLcRvAFEEHE=;
 b=a6sUt9gCf7ZFJnu+5NRRoSgfwhSKt2NCJTFc05e4m0tXLhAZ0jziQARuAs/b+Pwh0YOdvW
 129m5d4+e7qqMrcpm/WOtvWFIUlo8trlfTct0nCuqPws6ZD9MXQTKy9UNAkiyjJ3evmvXV
 FqAzWRSyDlJBE0OqweudiCmzYmGSSjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-0BYM2LfkPImVFhSIht8Fyg-1; Wed, 22 Jul 2020 01:55:16 -0400
X-MC-Unique: 0BYM2LfkPImVFhSIht8Fyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 835E657;
 Wed, 22 Jul 2020 05:55:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 959965BAD5;
 Wed, 22 Jul 2020 05:55:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3222910F5AF1; Wed, 22 Jul 2020 07:55:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: What is TYPE_TPM_TIS_ISA? (Not an ISA Device)
References: <8f5a171a-59db-f5d1-477c-1ddf7af45da7@redhat.com>
 <CAFEAcA8b3N+oxAAW3JEKGTtsZezXTOFdnu9Hm1MYK=yURTfVsQ@mail.gmail.com>
Date: Wed, 22 Jul 2020 07:55:08 +0200
In-Reply-To: <CAFEAcA8b3N+oxAAW3JEKGTtsZezXTOFdnu9Hm1MYK=yURTfVsQ@mail.gmail.com>
 (Peter Maydell's message of "Tue, 21 Jul 2020 17:40:27 +0100")
Message-ID: <87pn8o14cj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: David Safford <safford@us.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 21 Jul 2020 at 17:07, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> Hi Stefan,
>>
>> I'm trying to understand what is modelling the
>> TYPE_TPM_TIS_ISA device.
>>
>> It inherits from TYPE_ISA_DEVICE, so I expected
>> to see an ISA device, but then I noticed:
>>
>> 1/ it doesn't use the ISA I/O space, it directly
>> maps the device in the system memory at a fixed
>> address that is not addressable by the ISA bus:
>>
>> #define TPM_TIS_ADDR_BASE           0xFED40000
>
> Why do you think this is mapping to the system memory?
> tpm_tis_isa_realizefn() does:
>
>     memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
>                                 TPM_TIS_ADDR_BASE, &s->mmio);
>
> which puts it into the ISA memory address space.
>
> The weird thing about this is not which AS it's
> going in but the fact that the TPM_TIS_ADDR_BASE
> is way higher than an actual ISA bus can address
> (so for instance it's out of range of the size of
> the ISA memory window on the Jazz board).
>
>> 2/ it is not plugged to an ISA BUS (ISABus*)
>
> Won't it autoplug into the ISA bus if you say "-device tpm-tis",
> the same as any other ISA device ?

Yup:

    $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -chard=
ev socket,id=3Dchrtpm,path=3Dtpm/swtpm-sock -tpmdev emulator,id=3Dtpm0,char=
dev=3Dchrtpm -device tpm-tis,tpmdev=3Dtpm0
    QEMU 5.0.90 monitor - type 'help' for more information
    (qemu) info qtree
    bus: main-system-bus
      type System
      [...]
      dev: i440FX-pcihost, id ""
        [...]
        bus: pci.0
          type PCI
            [...]
          dev: PIIX3, id ""
            [...]
            bus: isa.0
              type ISA
              dev: tpm-tis, id ""
                irq =3D 5 (0x5)
                tpmdev =3D "tpm0"
                ppi =3D true
                isa irq 5
              [...]

This is with

    $ swtpm socket --tpmstate dir=3Dtpm --ctrl type=3Dunixio,path=3Dtpm/swt=
pm-soc

running in another terminal.

>> 3/ no machine plug it using isa_register_ioport()
>>    (it is not registered to the ISA memory space)
>
> There's no requirement for an ISA device to have IO ports...
>
> thanks
> -- PMM

Thread hijack!  Since I didn't have swtpm installed, I tried to take a
shortcut:

    $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -chard=
ev null,id=3Dtpm0 -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm -device tpm-t=
is,tpmdev=3Dtpm0
    qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm: tpm-em=
ulator: tpm chardev 'chrtpm' not found.
    qemu-system-x86_64: -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm: tpm-em=
ulator: Could not cleanly shutdown the TPM: No such file or directory
    QEMU 5.0.90 monitor - type 'help' for more information
    (qemu) qemu-system-x86_64: -device tpm-tis,tpmdev=3Dtpm0: Property 'tpm=
-tis.tpmdev' can't find value 'tpm0'
    $ echo $?
    1

That a null chardev doesn't work is fine.  But the error handling looks
broken: QEMU diagnoses and reports the problem, then continues.  The
final error message indicates that it continued without creating the
backend "tpm0".  That's wrong.

Different tack: could -tpmdev be made sugar for -object?  I'm asking
because other kinds of backends use -object instead of their very own
option.


