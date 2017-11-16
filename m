Received: from eggs.gnu.org ([2001:4830:134:3::10]:53120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFIUX-0004zv-Rm
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFIUS-0005kc-0A
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:37:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eFIUR-0005it-Pc
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 06:37:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 407EFFC7B3
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 11:37:50 +0000 (UTC)
References: <1510822546-14763-1-git-send-email-thuth@redhat.com>
	<20171116105422.GG16461@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dd2c3b59-18ae-8600-dae3-e937248733a6@redhat.com>
Date: Thu, 16 Nov 2017 12:37:44 +0100
MIME-Version: 1.0
In-Reply-To: <20171116105422.GG16461@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] tests/bios-tables-test: Fix
 endianess problems when passing data to iasl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 16.11.2017 11:54, Daniel P. Berrange wrote:
> On Thu, Nov 16, 2017 at 09:55:46AM +0100, Thomas Huth wrote:
>> The bios-tables-test was writing out files that we pass to iasl in
>> with the wrong endianness in the header when running on a big endian
>> host. So instead of storing mixed endian information in our structures,
>> let's keep everything in little endian and byte-swap it only when we
>> need a value in the code.
>>
>> Reported-by: Daniel P. Berrange <berrange@redhat.com>
>> Buglink: https://bugs.launchpad.net/qemu/+bug/1724570
>> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/acpi-utils.h       | 27 +++++----------------------
>>  tests/bios-tables-test.c | 42 ++++++++++++++++++++++--------------------
>>  2 files changed, 27 insertions(+), 42 deletions(-)
> 
> This fixes bios-tables-test, but has broken vmgenid-tgst
> 
> TEST: tests/vmgenid-test... (pid=8197)
>   /i386/vmgenid/vmgenid/set-guid:                                      **
> ERROR:/builddir/build/BUILD/qemu-2.10.0/tests/vmgenid-test.c:62:acpi_find_vgia: assertion failed (ACPI_ASSERT_CMP_str == "RSDT"): ("" == "RSDT")
> FAIL

Bummer. Sorry, I've should have run the whole test suite afterwards, I
only checked the bios-tables-test :-/

I'll send a v2 with a fix...

 Thomas
