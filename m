Received: from eggs.gnu.org ([2001:4830:134:3::10]:45639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0Q1K-00085S-9l
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f0Q1J-0001RZ-E1
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 07:10:34 -0400
References: <6f10cd53d361a395aa0e85a9311ec4e9a8fc11e5.1521868451.git.mprivozn@redhat.com>
	<73a91502-7cda-c3c3-b439-78d7bae0f2e2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <631c6561-01f3-aca1-c886-369d723208ef@redhat.com>
Date: Mon, 26 Mar 2018 13:10:19 +0200
MIME-Version: 1.0
In-Reply-To: <73a91502-7cda-c3c3-b439-78d7bae0f2e2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12] qemu-pr-helper: Actually allow
 users to specify pidfile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

On 24/03/2018 12:46, Eric Blake wrote:
> On 03/24/2018 12:14 AM, Michal Privoznik wrote:
>> Due to wrong specification of arguments to getopt_long() any
>> attempt to set pidfile resulted in:
>>
>> 1) the default to be leaked
>> 2) the @pidfile variable to be set to NULL (because optarg is
>> NULL without this patch).
> 
> Broken since the introduction in commit b855f8d, in 2.11 (documentation
> has always mentioned the argument, code has never supported it).

Queued, thanks.

Paolo

>>
>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> 
> CC: qemu-stable@nongnu.org
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
