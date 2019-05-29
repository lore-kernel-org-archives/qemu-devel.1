Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3ECC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:23:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C518B217D4
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C518B217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54277 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVyYN-0001N8-3a
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 09:23:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVyXZ-00013m-TY
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVyXZ-0000Ra-1T
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:22:49 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVyXY-0000R1-SO
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:22:48 -0400
Received: by mail-wm1-f47.google.com with SMTP id y3so1681883wmm.2
	for <qemu-devel@nongnu.org>; Wed, 29 May 2019 06:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fXQ+ER05TJhTeqwUfeZGhkBIl+tGXghgRnqJpNAYrsY=;
	b=O7AJRP4jjcarlTPBvYq4ySpDjj1wa/0Hdv/dAlcOw6oKvVZrQbn3qpa0mOruDokJiM
	ZK5fM6b/MLuL/uQnVzp8QJQG30p+WzNciqDdxLnx1RCeRKR6bqD0p4n2RVI4SV1W7ZU6
	Cxf55he956eNtM2JPtFbS3cj2tsUgp1t9wWY2dw+VS7P/nQypZV+RFVWRRGDAhxpodoe
	QzSFpfUrkEi3EeC1rdx2cHizDqFqY6o7wElmXl+/JhmdV4+BFGt4uTA9AZ66I0FTk7eq
	OwA9WD3rDvyqcuUTM6+bM4xt3xqnaMRuk2841ruQC0UyajYsvlvsRS+DrRCZ4+UBvz6x
	04cQ==
X-Gm-Message-State: APjAAAWLgzfnKVAf/kinZFWK4zFULFqAgylH3B5smMmK/0kpjTA4t/ad
	r4iPPbLso5CcCwW/JFyzbHo2Ow==
X-Google-Smtp-Source: APXvYqxQ5UV5J4MSYpUyVOo94Cida0Ce6EiAWFcPFdlR8vX50mtn44oyFwv3z8fTO04gGd0mJwawBQ==
X-Received: by 2002:a1c:ef10:: with SMTP id n16mr6319264wmh.134.1559136167772; 
	Wed, 29 May 2019 06:22:47 -0700 (PDT)
Received: from [10.32.224.40] (red-hat-inc.vlan560.asr1.mad1.gblx.net.
	[159.63.51.90]) by smtp.gmail.com with ESMTPSA id
	w2sm11282040wru.16.2019.05.29.06.22.43
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 29 May 2019 06:22:46 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c172d2b3-9c1c-6194-290e-f546c07f8eff@redhat.com>
Date: Wed, 29 May 2019 15:22:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87lfyqla7r.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.47
Subject: Re: [Qemu-devel] Headers without multiple inclusion guards
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Cornelia Huck <cohuck@redhat.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/19 8:12 PM, Markus Armbruster wrote:
> We have a bunch of headers without multiple inclusion guards.  Some are
> clearly intentional, some look accidental.  Too many for me to find out
> by examining each of them, so I'm asking their maintainers.
> 
> Why do I ask?  I'd like to mark the intentional ones and fix the
> accidental ones, so they don't flunk "make check-headers" from "[RFC v4
> 0/7] Baby steps towards saner headers" just because they lack multiple
> inclusion guards.
> 
> Just in case: what's a multiple inclusion guard?  It's
> 
>     #ifndef UNIQUE_GUARD_SYMBOL_H
>     #define UNIQUE_GUARD_SYMBOL_H
>     ...
>     #endif
> 
> with nothing but comments outside the conditional, so that the header
> can safely be included more than once.
> 
> I append the alphabetical list of headers without multiple inclusion
> guards (as reported by scripts/clean-header-guards -nv), followed by the
> same list sorted into maintainer buckets.  If you're cc'ed, please find
> your bucket(s), and tell me which headers intentionally lack guards.
> 
[...]
> 
> EDK2 Firmware
> M: Laszlo Ersek <lersek@redhat.com>
> M: Philippe Mathieu-Daudé <philmd@redhat.com>
> tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h

This file has a guard in non-standard formats:

#ifndef __BIOS_TABLES_TEST_H__
#define __BIOS_TABLES_TEST_H__
...

