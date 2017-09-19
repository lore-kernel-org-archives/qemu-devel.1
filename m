Received: from eggs.gnu.org ([2001:4830:134:3::10]:56500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duDYB-00061q-0D
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1duDY5-00032J-3a
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:06:34 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:52909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1duDY4-00031j-T4
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 04:06:29 -0400
Received: by mail-wr0-f174.google.com with SMTP id c23so2321549wrg.9
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 01:06:28 -0700 (PDT)
References: <1505298088-10878-1-git-send-email-thuth@redhat.com>
	<ab1516cb-9590-0833-b872-0e691e8ace49@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <23cfaae7-7744-9865-6f43-9b74b2d60ec9@redhat.com>
Date: Tue, 19 Sep 2017 10:06:25 +0200
MIME-Version: 1.0
In-Reply-To: <ab1516cb-9590-0833-b872-0e691e8ace49@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Clean up some bad code
 in the vvfat driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

On 13/09/2017 21:08, John Snow wrote:
> 
> 
> On 09/13/2017 06:21 AM, Thomas Huth wrote:
>> Remove the unnecessary home-grown redefinition of the assert() macro here,
>> and remove the unusable debug code at the end of the checkpoint() function.
>> The code there uses assert() with side-effects (assignment to the "mapping"
>> variable), which should be avoided. Looking more closely, it seems as it is
>> apparently also only usable for one certain directory layout (with a file
>> named USB.H in it) and thus is of no use for the rest of the world.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Farewell, bitrot code.
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
> Out of curiosity, I wonder ...
> 
> jhuston@probe (foobar) ~/s/qemu> git grep '#if 0' | wc -l
> 320


$ git grep -c '#if 0' | sort -k2 --field-separator=: -n
...
hw/net/eepro100.c:21
target/ppc/cpu-models.h:76

whoa :)
