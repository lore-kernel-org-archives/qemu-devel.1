Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA72DC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC35273D6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC35273D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37887 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXq1Y-0004ot-1B
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 12:41:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hXpv2-0007Mh-Jc
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hXpko-0008Am-WA
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:24:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hXpko-00089Q-Or
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:24:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7D7681E03;
	Mon,  3 Jun 2019 16:23:49 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-13.rdu2.redhat.com
	[10.10.121.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A497E10021B4;
	Mon,  3 Jun 2019 16:23:17 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
	<4397594e-ccba-3f54-6359-2cb061b8fcc0@redhat.com>
	<875zpmrfhv.fsf@dusky.pond.sub.org>
	<7d5c114c-e51b-8a6b-8285-d9d4f65ced8d@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <684dc570-856d-c2e1-b34e-bbd9daa0e4cd@redhat.com>
Date: Mon, 3 Jun 2019 18:23:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7d5c114c-e51b-8a6b-8285-d9d4f65ced8d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 03 Jun 2019 16:24:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

On 06/03/19 16:24, Philippe Mathieu-Daud=C3=A9 wrote:
> On 6/3/19 2:59 PM, Markus Armbruster wrote:
>> Laszlo Ersek <lersek@redhat.com> writes:
>>
>>> Hi Markus,
>>>
>>> (sorry about the late reply, I've been away.)
>>>
>>> On 05/28/19 20:12, Markus Armbruster wrote:
>>>
>>>> EDK2 Firmware
>>>> M: Laszlo Ersek <lersek@redhat.com>
>>>> M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
>>>
>>> This header file does have a multiple inclusion guard:
>>>
>>>> /** @file
>>>>   Expose the address(es) of the ACPI RSD PTR table(s) and the SMBIOS=
 entry
>>>>   point(s) in a MB-aligned structure to the hypervisor.
>>>>
>>>>   [...]
>>>> **/
>>>>
>>>> #ifndef __BIOS_TABLES_TEST_H__
>>>> #define __BIOS_TABLES_TEST_H__
>>>>
>>>> [...]
>>>>
>>>> #endif // __BIOS_TABLES_TEST_H__
>>>
>>> It's possible that "scripts/clean-header-guards.pl" does not recogniz=
e
>>> the guard.
>>
>> Correct.  I fixed the script in my tree.
>>
>>> According to the ISO C standard, "All identifiers that begin with an
>>> underscore and either an uppercase letter or another underscore are
>>> always reserved for any use". Therefore, technically speaking, the ab=
ove
>>> inclusion guard implies undefined behavior. In practice, this particu=
lar
>>> style for header guards is extremely common in the edk2 codebase:
>>>
>>> $ git grep '^#ifndef __' -- '*.h'  | wc -l
>>> 1012
>>>
>>> And, "tests/uefi-test-tools/UefiTestToolsPkg" follows the edk2 coding
>>> style.
>>>
>>> That said, if you'd like to remove the leading "__" from the macro na=
me,
>>> I'd be fully OK with that.
>>
>> We routinely exempt files from style cleanups when we have a reason.  =
If
>> you want this one to be exempted, that's fine with me.
>>
>> If we decide not to exempt it, then I want a header guard that makes m=
y
>> (fixed) script happy.  It isn't right now:
>>
>>     $ scripts/clean-header-guards.pl -nv tests/uefi-test-tools/UefiTes=
tToolsPkg/Include/Guid/BiosTablesTest.h=20
>>     tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest=
.h guard __BIOS_TABLES_TEST_H__ needs cleanup:
>>         is a reserved identifier, doesn't end with _H, doesn't match t=
he file name
>>     [...]
>>
>> Removing the leading "__" takes care of the first complaint:
>>
>>     tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest=
.h guard BIOS_TABLES_TEST_H__ needs cleanup:
>>         doesn't end with _H, doesn't match the file name
>>
>> Removing the trailing "__" as well takes care of the second one:
>>
>>     tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest=
.h guard BIOS_TABLES_TEST_H needs cleanup:
>>         doesn't match the file name
>>
>> To get rid of the last one, we can:
>>
>> * Rename to BIOSTABLESTEST_H.  Easy.
>>
>> * Teach scripts/clean-header-guards.pl to capitalize StudlyCaps
>>   filenames to STUDLY_CAPS rather than STUDLYCAPS.  But that would bre=
ak
>>   include/libdecnumber/*.h.
>>
>> * Teach scripts/clean-header-guards to accept either STUDLYCAPS or
>>   STUDLY_CAPS.  Considering we have exactly one filename that needs
>>   this, I'd prefer not to.
>>
>> My first preference is BIOSTABLESTEST_H, second is to exempt the file.
>> Yours?
>>
>=20
> What about excluding UefiTestToolsPkg?
>=20
> $ git grep '^#ifndef __' -- \
>   '*.h' ':!tests/uefi-test-tools/UefiTestToolsPkg'
>=20

Let's go with BIOSTABLESTEST_H for now. If UefiTestToolsPkg continues to
generate a bunch of warnings in other QEMU checkers too, we can still
decide to exclude it, later. This change looks small enough to me, for no=
w.

BTW thanks for that nice git-grep syntax :) I guess I should read up on
"pathspec" in gitglossary(7) sometime...

Thanks!
Laszlo

