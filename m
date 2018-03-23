Received: from eggs.gnu.org ([2001:4830:134:3::10]:46237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezRYp-0004Dt-U1
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:37:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezRYl-0002l6-9s
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:37:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37948 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ezRYl-0002kp-5F
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:37:03 -0400
References: <20180323140821.28957-1-peterx@redhat.com>
	<17b3708c-3787-c08d-e960-c6df21114689@redhat.com>
	<ff6a3e78-56dd-aa7b-da36-4d0a79634079@redhat.com>
	<758e314f-10d3-d335-9f20-7ee7cf714320@redhat.com>
	<eae83d50-e36c-ba0b-0cdb-d1744c1d0620@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <319a5fdb-496d-1100-b5ce-78bbf4781cb4@redhat.com>
Date: Fri, 23 Mar 2018 13:36:28 -0500
MIME-Version: 1.0
In-Reply-To: <eae83d50-e36c-ba0b-0cdb-d1744c1d0620@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] Turn OOB off for 2.12-rc1,
 revert OOB tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>

On 03/23/2018 01:30 PM, Christian Borntraeger wrote:

>> Even that didn't work - 'make check' fails with either 1/4 or 4/4 applied in isolation, so I'm squashing them into a single patch.
> 
> Yes, "qmp: introduce QMPCapability" added an assert, that was fixed by a later on patch. So
> the original series was not bisectable. Anyway with Peters 4 patches all applied things are fine
> for me.

Weird, since I seem to recall running 'make check' on every patch in 
order in that series without seeing failures, prior to preparing the 
pull request (where I fell short was running iotests, which is what 
sparked this whole revert thread).  Anyways, even if my memory is faulty 
and the original series has a broken bisection window, it's now water 
under the bridge; the focus at this point is improving the known bugs to 
see if we can re-enable OOB prior to -rc2.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
