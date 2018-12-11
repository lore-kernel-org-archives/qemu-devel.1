Received: from eggs.gnu.org ([2001:4830:134:3::10]:55893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWldL-0003GE-KV
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWldF-00080U-44
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:15:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:9261)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gWldC-0007wE-QN
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:15:39 -0500
References: <20181211162846.31149-1-wainersm@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b75eb4c9-17dc-9311-d569-d2a8772b2ef3@redhat.com>
Date: Tue, 11 Dec 2018 11:15:32 -0600
MIME-Version: 1.0
In-Reply-To: <20181211162846.31149-1-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: Fixes to the check missing
 features routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com, ccarrara@redhat.com

On 12/11/18 10:28 AM, Wainer dos Santos Moschetta wrote:
> The x86_cpu_class_check_missing_features() returns a list
> of unavailable features compared to the host CPU. Currently it may
> return empty strings for unnamed features as well as duplicated
> names.
> 
> For example, the qmp "query-cpu-definitions" below shows one empty
> string and repeated "mpx" entries:
> 

> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Careful. While I spotted typos in v1,...

> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
> ---
> v2:
>   * Fixed typos. [eblake]

...and you indeed addressed them, me pointing out typos does not imply 
that I reviewed the patch for correctness.  In fact, I specifically did 
NOT give my R-by: tag to v1, because I'm not (yet?) familiar enough with 
the tests/acceptance/ framework to state that I have fully reviewed the 
patch for correctness; instead, I'm comfortable relying on the reviews 
of others (and I am again intentionally not giving R-by to v2).

Also, when posting a v2, you should include the R-by actually given to 
v1 only if the patch is roughly the same as the original.  Fixing minor 
issues that a reviewer pointed out, or doing obvious rebasing to changes 
applied earlier in the series or on upstream git, but where the 
algorithm of the patch itself did not change, is okay for keeping R-b 
(so if I _had_ given R-b, and your spelling changes were the only 
difference, then keeping my R-b would make sense); but where the patch 
is fundamentally different, such as:

>  * Removed unwanted manual test case. [ccarrara, ehabkost]
>  * Not passing 'accel=kvm' on test's VM. [ehabkost]

then omitting ALL R-by tags, in order to ensure that reviewers check 
that the new patch is still correct, is a wiser course of action.  Yes, 
this is more of a rule of thumb, and there are cases where keeping or 
dropping R-b is more of an art form than an exact science; but hopefully 
this helps you understand how the tag can be useful for iterative reviews.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
