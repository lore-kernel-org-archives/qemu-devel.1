Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA3EC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 13:03:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4F724E42
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 13:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4F724E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35017 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXmcX-00034I-Q6
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 09:03:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hXmbM-0002Y1-M4
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 09:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hXmbK-0007Ci-PS
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 09:02:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hXmbJ-0006Fg-1M
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 09:02:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 237C13097052;
	Mon,  3 Jun 2019 13:01:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-223.ams2.redhat.com
	[10.36.117.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D8AE60491;
	Mon,  3 Jun 2019 12:59:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1AC5D11386A0; Mon,  3 Jun 2019 14:59:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
References: <87lfyqla7r.fsf@dusky.pond.sub.org>
	<4397594e-ccba-3f54-6359-2cb061b8fcc0@redhat.com>
Date: Mon, 03 Jun 2019 14:59:56 +0200
In-Reply-To: <4397594e-ccba-3f54-6359-2cb061b8fcc0@redhat.com> (Laszlo Ersek's
	message of "Mon, 3 Jun 2019 12:55:01 +0200")
Message-ID: <875zpmrfhv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 03 Jun 2019 13:01:43 +0000 (UTC)
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
	Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <f4bug@amsat.org>,
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
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Alistair Francis <alistair@alistair23.me>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>, Greg Kurz <groug@kaod.org>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	Eric Auger <eric.auger@redhat.com>, Paul Durrant <paul.durrant@citrix.com>,
	Stafford Horne <shorne@gmail.com>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
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

Laszlo Ersek <lersek@redhat.com> writes:

> Hi Markus,
>
> (sorry about the late reply, I've been away.)
>
> On 05/28/19 20:12, Markus Armbruster wrote:
>
>> EDK2 Firmware
>> M: Laszlo Ersek <lersek@redhat.com>
>> M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
>
> This header file does have a multiple inclusion guard:
>
>> /** @file
>>   Expose the address(es) of the ACPI RSD PTR table(s) and the SMBIOS ent=
ry
>>   point(s) in a MB-aligned structure to the hypervisor.
>>
>>   [...]
>> **/
>>
>> #ifndef __BIOS_TABLES_TEST_H__
>> #define __BIOS_TABLES_TEST_H__
>>
>> [...]
>>
>> #endif // __BIOS_TABLES_TEST_H__
>
> It's possible that "scripts/clean-header-guards.pl" does not recognize
> the guard.

Correct.  I fixed the script in my tree.

> According to the ISO C standard, "All identifiers that begin with an
> underscore and either an uppercase letter or another underscore are
> always reserved for any use". Therefore, technically speaking, the above
> inclusion guard implies undefined behavior. In practice, this particular
> style for header guards is extremely common in the edk2 codebase:
>
> $ git grep '^#ifndef __' -- '*.h'  | wc -l
> 1012
>
> And, "tests/uefi-test-tools/UefiTestToolsPkg" follows the edk2 coding
> style.
>
> That said, if you'd like to remove the leading "__" from the macro name,
> I'd be fully OK with that.

We routinely exempt files from style cleanups when we have a reason.  If
you want this one to be exempted, that's fine with me.

If we decide not to exempt it, then I want a header guard that makes my
(fixed) script happy.  It isn't right now:

    $ scripts/clean-header-guards.pl -nv tests/uefi-test-tools/UefiTestTool=
sPkg/Include/Guid/BiosTablesTest.h=20
    tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h gu=
ard __BIOS_TABLES_TEST_H__ needs cleanup:
        is a reserved identifier, doesn't end with _H, doesn't match the fi=
le name
    [...]

Removing the leading "__" takes care of the first complaint:

    tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h gu=
ard BIOS_TABLES_TEST_H__ needs cleanup:
        doesn't end with _H, doesn't match the file name

Removing the trailing "__" as well takes care of the second one:

    tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h gu=
ard BIOS_TABLES_TEST_H needs cleanup:
        doesn't match the file name

To get rid of the last one, we can:

* Rename to BIOSTABLESTEST_H.  Easy.

* Teach scripts/clean-header-guards.pl to capitalize StudlyCaps
  filenames to STUDLY_CAPS rather than STUDLYCAPS.  But that would break
  include/libdecnumber/*.h.

* Teach scripts/clean-header-guards to accept either STUDLYCAPS or
  STUDLY_CAPS.  Considering we have exactly one filename that needs
  this, I'd prefer not to.

My first preference is BIOSTABLESTEST_H, second is to exempt the file.
Yours?

