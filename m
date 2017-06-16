Received: from eggs.gnu.org ([2001:4830:134:3::10]:44584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1dLwP8-0004UD-0t
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gsomlo@gmail.com>) id 1dLwP5-0006Vs-08
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:55:34 -0400
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:33202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gsomlo@gmail.com>) id 1dLwP4-0006UU-OA
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 14:55:30 -0400
Received: by mail-qt0-x229.google.com with SMTP id u12so75316258qth.0
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 11:55:28 -0700 (PDT)
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
Date: Fri, 16 Jun 2017 14:55:13 -0400
Message-Id: <1497639316-22202-1-git-send-email-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/3] Update AppleSMC for OS X 10.12.4+ guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: agraf@suse.de, pbonzini@redhat.com, f4bug@amsat.org, eshelton@pobox.com

As of 10.12.4, OS X refuses to boot unless the AppleSMC supports a
third I/O port, which provides the current error status when read.

New since v2:
	- updated "reviewd-by" fields
	- ping ?

>New since v1:
>
>        - 1/3: don't touch the default OSK string, as it's unnecessary
>                at this time
>
>        - 2/3: don't consolidate I/O regions, leave as-is for data
>                and cmd; This patch now implements the error-code state
>                machine, AND adds an i/o region dedicaded to the error
>                status port, complete with read/write access methods.
>
>        - 3/3: set access width to 1-byte on data and cmd i/o regions.
>                Tested on OS X versions 10.[6..12].
>
>> This series consists of three patches:
>>
>>       - 1/3: indentation/whitespace cleanup for applesmc.c to the point
>>               where it now passes scripts/checkpatc.pl, and allows
>>               subsequent changes to look nice in diff-patch format :)
>>
>>       - 2/3: consolidate Port I/O into a single region, and invoke
>>               appropriate read/write methods based on the offset being
>>               accessed
>>
>>       - 3/3: implement read-only error/status port, and update
>>               data and command read/write methods to correctly
>>               maintain the state machine for keeping the status_1e
>>               value up to date.


Gabriel L. Somlo (3):
  applesmc: cosmetic whitespace and indentation cleanup
  applesmc: implement error status port
  applesmc: fix port i/o access width

 hw/misc/applesmc.c | 219 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 155 insertions(+), 64 deletions(-)

-- 
2.7.4
