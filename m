Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ACEC28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 14:25:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2410F2767D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 14:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2410F2767D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35840 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXntY-0007GM-5Z
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 10:25:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hXnsd-0006xC-LG
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hXnsc-000370-Eg
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:24:07 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:38039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hXnsc-00035g-8S
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 10:24:06 -0400
Received: by mail-wr1-f53.google.com with SMTP id d18so12307407wrs.5
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 07:24:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=9GmycFV+aGVBxvqvRP9eAGBUkv5PldAAHMtyPZdOGDk=;
	b=dRdZQxrteYg5o65UANQa6J/blgk4W66U1ZEra+SF0st80mu/ji3kGPSR0tX7aZyYGH
	A587BXTOpjJcQN0hVAmYXVjq/tExfBI68gS66s0+lk9MEJBz9+DUcTu4ejlJplDI+MhA
	hkq6BE66horIZ+9kRN9bH+7bd79+TwCXNaAFplhMDZcSeBmn9yNwemjg1OtdTJhgHazI
	sAjRFLwKiJoTQeawNsUWJIP7LsOumJ5bMX9Sxy0gGs/qo9+HqB8gPZ2EAT8THwlvXsvV
	6uUGqRVW+F2ckJYW8FshVEfWE4P4SIlRXQ3NU9PQepajdfu96KqHduM2M96EELGM2cVi
	i6Kg==
X-Gm-Message-State: APjAAAW9e9s90b8mRcjg0wa/Mc3DG89xtkG6gaoT5XWzCgxl5Ianjv8c
	gOC/NyBQidXI7oWhYG7feQxYDA==
X-Google-Smtp-Source: APXvYqzLOFx0wkOhhxbd6AatVAT9OEgIOVeNZyL6t+72Ub3GqJY3N9Af2EyF4zIrglFd54Kd+U/KBA==
X-Received: by 2002:a05:6000:11c5:: with SMTP id
	i5mr16154118wrx.120.1559571845044; 
	Mon, 03 Jun 2019 07:24:05 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	g185sm14236295wmf.30.2019.06.03.07.24.01
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 07:24:04 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
	<4397594e-ccba-3f54-6359-2cb061b8fcc0@redhat.com>
	<875zpmrfhv.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7d5c114c-e51b-8a6b-8285-d9d4f65ced8d@redhat.com>
Date: Mon, 3 Jun 2019 16:24:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <875zpmrfhv.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.53
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	Sagar Karandikar <sagark@eecs.berkeley.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>, James Hogan <jhogan@kernel.org>,
	Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
	David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Claudio Fontana <claudio.fontana@gmail.com>,
	Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
	Chris Wulff <crwulff@gmail.com>,
	Claudio Fontana <claudio.fontana@huawei.com>,
	Laurent Vivier <laurent@vivier.eu>,
	Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 2:59 PM, Markus Armbruster wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
>> Hi Markus,
>>
>> (sorry about the late reply, I've been away.)
>>
>> On 05/28/19 20:12, Markus Armbruster wrote:
>>
>>> EDK2 Firmware
>>> M: Laszlo Ersek <lersek@redhat.com>
>>> M: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
>>
>> This header file does have a multiple inclusion guard:
>>
>>> /** @file
>>>   Expose the address(es) of the ACPI RSD PTR table(s) and the SMBIOS entry
>>>   point(s) in a MB-aligned structure to the hypervisor.
>>>
>>>   [...]
>>> **/
>>>
>>> #ifndef __BIOS_TABLES_TEST_H__
>>> #define __BIOS_TABLES_TEST_H__
>>>
>>> [...]
>>>
>>> #endif // __BIOS_TABLES_TEST_H__
>>
>> It's possible that "scripts/clean-header-guards.pl" does not recognize
>> the guard.
> 
> Correct.  I fixed the script in my tree.
> 
>> According to the ISO C standard, "All identifiers that begin with an
>> underscore and either an uppercase letter or another underscore are
>> always reserved for any use". Therefore, technically speaking, the above
>> inclusion guard implies undefined behavior. In practice, this particular
>> style for header guards is extremely common in the edk2 codebase:
>>
>> $ git grep '^#ifndef __' -- '*.h'  | wc -l
>> 1012
>>
>> And, "tests/uefi-test-tools/UefiTestToolsPkg" follows the edk2 coding
>> style.
>>
>> That said, if you'd like to remove the leading "__" from the macro name,
>> I'd be fully OK with that.
> 
> We routinely exempt files from style cleanups when we have a reason.  If
> you want this one to be exempted, that's fine with me.
> 
> If we decide not to exempt it, then I want a header guard that makes my
> (fixed) script happy.  It isn't right now:
> 
>     $ scripts/clean-header-guards.pl -nv tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h 
>     tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h guard __BIOS_TABLES_TEST_H__ needs cleanup:
>         is a reserved identifier, doesn't end with _H, doesn't match the file name
>     [...]
> 
> Removing the leading "__" takes care of the first complaint:
> 
>     tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h guard BIOS_TABLES_TEST_H__ needs cleanup:
>         doesn't end with _H, doesn't match the file name
> 
> Removing the trailing "__" as well takes care of the second one:
> 
>     tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h guard BIOS_TABLES_TEST_H needs cleanup:
>         doesn't match the file name
> 
> To get rid of the last one, we can:
> 
> * Rename to BIOSTABLESTEST_H.  Easy.
> 
> * Teach scripts/clean-header-guards.pl to capitalize StudlyCaps
>   filenames to STUDLY_CAPS rather than STUDLYCAPS.  But that would break
>   include/libdecnumber/*.h.
> 
> * Teach scripts/clean-header-guards to accept either STUDLYCAPS or
>   STUDLY_CAPS.  Considering we have exactly one filename that needs
>   this, I'd prefer not to.
> 
> My first preference is BIOSTABLESTEST_H, second is to exempt the file.
> Yours?
> 

What about excluding UefiTestToolsPkg?

$ git grep '^#ifndef __' -- \
  '*.h' ':!tests/uefi-test-tools/UefiTestToolsPkg'

