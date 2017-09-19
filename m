Received: from eggs.gnu.org ([2001:4830:134:3::10]:59437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duDgM-0000BI-RC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1duDgJ-0007Xg-07
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:15:02 -0400
References: <1505298088-10878-1-git-send-email-thuth@redhat.com>
	<ab1516cb-9590-0833-b872-0e691e8ace49@redhat.com>
	<23cfaae7-7744-9865-6f43-9b74b2d60ec9@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <853d5df6-a7a9-9284-ebbd-6282352879ba@redhat.com>
Date: Tue, 19 Sep 2017 10:14:44 +0200
MIME-Version: 1.0
In-Reply-To: <23cfaae7-7744-9865-6f43-9b74b2d60ec9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Dead code in cpu-models.h (was: block: Clean up some
 bad code in the vvfat driver)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org

On 19.09.2017 10:06, Paolo Bonzini wrote:
> On 13/09/2017 21:08, John Snow wrote:
[...]
>> Farewell, bitrot code.
>>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>>
>> Out of curiosity, I wonder ...
>>
>> jhuston@probe (foobar) ~/s/qemu> git grep '#if 0' | wc -l
>> 320
> 
> $ git grep -c '#if 0' | sort -k2 --field-separator=: -n
> ...
> hw/net/eepro100.c:21
> target/ppc/cpu-models.h:76
> 
> whoa :)

Igor recently already removed the dead definitions from cpu-models.c :

https://git.qemu.org/?p=qemu.git;a=commitdiff;h=aef779605779579afbafff

I guess we could now remove the corresponding dead definitions from the
header, too...

Any volunteers?

 Thomas
