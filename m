Received: from eggs.gnu.org ([2001:4830:134:3::10]:46576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6BzB-0006Ee-50
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f6Bz7-0003Zs-Sk
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:24:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f6Bz7-0003ZW-NL
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 05:24:09 -0400
References: <20180410124913.10832-1-peterx@redhat.com>
	<20180410124913.10832-3-peterx@redhat.com>
	<20180411014532.GB28698@stefanha-x1.localdomain>
	<20180411034954.GC13887@xz-mi>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2ab39a4-2ffc-ddee-299d-007e9850cebb@redhat.com>
Date: Wed, 11 Apr 2018 11:23:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180411034954.GC13887@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-thread: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 11/04/2018 05:49, Peter Xu wrote:
> On Wed, Apr 11, 2018 at 09:45:32AM +0800, Stefan Hajnoczi wrote:
>> On Tue, Apr 10, 2018 at 08:49:13PM +0800, Peter Xu wrote:
>>> cur_mon was only used in main loop so we don't really need that to be
>>> per-thread variable.  Now it's possible that we have more than one
>>> thread to operate on it.  Let's start to let it be per-thread variable.
>> Trying to understand the reason for this patch:
>>
>> Are there any users of per-thread cur_mon?
> 
> Currently no.  But if considering future OOB-capable commands, they
> will modify cur_mon in monitor IOThread at least.

That's fine, but it shouldn't need the inheritance part.  The monitor
IOThread can set cur_mon when it starts.

In general, relying on cur_mon should be avoided.

Paolo
