Received: from eggs.gnu.org ([2001:4830:134:3::10]:33215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffNL2-0003Lm-V4
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffNKz-0006Yf-QC
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:36:12 -0400
References: <20180716174146.19845-1-krinkin.m.u@gmail.com>
	<20180716184752.GA30657@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ea51a39-bddd-81b7-318d-fac8bfb56a93@redhat.com>
Date: Tue, 17 Jul 2018 12:36:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180716184752.GA30657@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] opts: fix NULL pointer derefernce in
 get_opt_value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Mike Krinkin <krinkin.m.u@gmail.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-trivial@nongnu.org

On 16/07/2018 20:47, Daniel P. Berrange wrote:
> On Mon, Jul 16, 2018 at 06:41:46PM +0100, Mike Krinkin wrote:
>> The value argument can be NULL, for example, in hw/i386/multiboot.c
>> in the load_multiboot function get_opt_value is explicitly called
>> with NULL as the second argument.
>>
>> The problem was introduced in commit 950c4e6c94b1 ("opts: don't
>> silently truncate long option values"). This change fixes the
>> problem by adding a check whether the value is NULL or not.
>>
>> Signed-off-by: Mike Krinkin <krinkin.m.u@gmail.com>
>> ---
>>  util/qemu-option.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> This problem is fixed in this:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg01490.html
> 
> but it is still waiting for i386 maintainers to respond....

Generally Kevin has looked at multiboot patches, but I'll merge these
ones because he's on vacation.  Thanks,

Paolo
