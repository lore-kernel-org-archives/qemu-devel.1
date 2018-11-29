Received: from eggs.gnu.org ([2001:4830:134:3::10]:48227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSNBH-0004F8-0N
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSNAl-0005VE-J9
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:20:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gSNAl-0005Uo-Da
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:20:07 -0500
References: <20181129100340.13823-1-fli@suse.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4031aa35-a9f0-dd87-ad2a-0cc35546f7af@redhat.com>
Date: Thu, 29 Nov 2018 08:20:05 -0600
MIME-Version: 1.0
In-Reply-To: <20181129100340.13823-1-fli@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1? RFC v2 0/5] fix some segmentation
 faults and migration issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 11/29/18 4:03 AM, Fei Li wrote:
> These five patches almost get the Reviewed-by and are extracted from
> previous "[PATCH RFC v7 0/9] qemu_thread_create: propagate errors to
> callers to check."  The mentioned patch series have waited on one
> multifd issue for a while and still needs a further discussion.
> 
> Thus separate(send) these five almost-done patches and hope they can
> be merged for the next tag. Thanks for the review. :)

How likely are any of these crashers to affect an end user? Are any of 
them regressions over 3.0?  I'm trying to gauge if any of this is 
serious enough to warrant a -rc4, or if we are okay just documenting 
them as known corner-case bugs and deferring the fix to 4.0 and 
qemu-stable.  The fact that the series is still titled RFC is also an 
argument in favor of deferral.

> 
> v2:
> - Update the commit message for patch 1/5, and get one more
>    Reviewed-by.
> - Get one Reviewed-by for patch 3/5.
> 
> 
> Fei Li (5):
>    Fix segmentation fault when qemu_signal_init fails
>    qemu_thread_join: fix segmentation fault
>    migration: fix the multifd code when receiving less channels
>    migration: remove unused &local_err parameter in multifd_save_cleanup
>    migration: add more error handling for postcopy_ram_enable_notify

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
