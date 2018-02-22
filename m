Received: from eggs.gnu.org ([2001:4830:134:3::10]:38247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoypk-0008M5-RQ
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 16:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoypj-00033T-Tt
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 16:55:20 -0500
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<151932620203.726.14470172414364772802@bdbb90650ae5>
	<CAFEAcA90bTkHb+AF2W7Jv3GMENo0Ni3rK6GnzNVtk+RF89VuCg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <12157307-d058-ba0d-affd-779a92981928@redhat.com>
Date: Thu, 22 Feb 2018 15:55:00 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA90bTkHb+AF2W7Jv3GMENo0Ni3rK6GnzNVtk+RF89VuCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/19] Add Cortex-M33 and mps2-an505 board
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 02/22/2018 01:11 PM, Peter Maydell wrote:

>> ERROR: line over 90 characters
>> #54: FILE: hw/arm/mps2-tz.c:21:
>> + * https://developer.arm.com/products/system-design/development-boards/fpga-prototyping-boards/mps2
>>

> Does anybody better with perl and more familiar with checkpatch's
> internals feel like tweaking it to suppress the over-long-line
> complaint for URLs ?

This one-liner appears to do the trick; I'll submit it formally in 
another thread:

diff --git i/scripts/checkpatch.pl w/scripts/checkpatch.pl
index 1b4b812e28f..0d3f753c665 100755
--- i/scripts/checkpatch.pl
+++ w/scripts/checkpatch.pl
@@ -1447,9 +1447,10 @@ sub process {
  # check we are in a valid source file if not then ignore this hunk
  		next if ($realfile !~ /$SrcFile/);

-#90 column limit
+#90 column limit; exempt URLs, if no other words on line
  		if ($line =~ /^\+/ &&
  		    !($line =~ /^\+\s*"[^"]*"\s*(?:\s*|,|\)\s*;)\s*$/) &&
+		    !($rawline =~ /^[^[:alnum:]]*https?:\S*$/) &&
  		    $length > 80)
  		{
  			if ($length > 90) {


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
