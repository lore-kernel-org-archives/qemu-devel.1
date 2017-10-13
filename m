Received: from eggs.gnu.org ([2001:4830:134:3::10]:50999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2yQB-000865-Ii
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2yQ7-0003VZ-L4
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:46:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e2yQ7-0003VK-Ea
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:46:27 -0400
References: <20171013102812.29648-1-berrange@redhat.com>
	<1c52fcd4-e8ce-51c1-a0c7-cf882fab6662@redhat.com>
	<a591ebd3-ae7f-cde6-1cd2-d4859c17494f@redhat.com>
	<20171013113859.GG20515@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f43d6c1c-1112-bfcf-ae19-ed2a002b7873@redhat.com>
Date: Fri, 13 Oct 2017 13:46:24 +0200
MIME-Version: 1.0
In-Reply-To: <20171013113859.GG20515@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: pick the right compiler for
 OpenBSD by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 13.10.2017 13:38, Daniel P. Berrange wrote:
> On Fri, Oct 13, 2017 at 12:55:40PM +0200, Thomas Huth wrote:
>> On 13.10.2017 12:52, Thomas Huth wrote:
[...]
>> By the way, looks like OpenBSD is also switching to clang by default soon:
>>
>> https://www.phoronix.com/scan.php?page=news_item&px=OpenBSD-Default-Clang
> 
> In a few years time we could potentially revert this patch, but in the
> meantime it is clearly beneficial for anyone using OpenBSD and has no
> significant maint burden for us to carry it while there are widely
> supported OpenBSD releases which need it.

I disagree. If the next OpenBSD release uses Clang by default, we're not
building QEMU there with the *working default* C compiler anymore.
You're then rather forcing the OpenBSD users then to install an
additional (likely unliked, since GPLv3) GCC package on their systems.

So IMHO, just drop this patch and wait for the next OpenBSD release, and
the problem will be solved automatically. (and the few users who still
use an older release of OpenBSD will likely use the QEMU from their
ports system anyway)

 Thomas
