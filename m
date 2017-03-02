Received: from eggs.gnu.org ([2001:4830:134:3::10]:45649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cjQXK-0001P4-2S
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cjQXG-0007Qm-4y
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:12:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cjQXF-0007QH-V2
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 08:12:46 -0500
References: <41cc9d11-2e28-5b5e-4772-81a118d79111@redhat.com>
	<20170227101817.11748-1-mmarek@suse.com>
	<41e6edc0-204b-62b7-93b8-b376a40542d6@twiddle.net>
	<175599de-8f4f-8d22-d36e-6fb250ec49f4@suse.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <eba82ba0-2edb-834d-3b10-ae9b053c93c3@redhat.com>
Date: Thu, 2 Mar 2017 14:12:42 +0100
MIME-Version: 1.0
In-Reply-To: <175599de-8f4f-8d22-d36e-6fb250ec49f4@suse.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Marek <mmarek@suse.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>
Cc: Eric Bischoff <ebischoff@suse.com>, Miroslav Benes <mbenes@suse.cz>, qemu-devel@nongnu.org

>> As it happens, this reminds me that I wrote a version of this several
>> years ago but never submitted it upstream.  I'll dig it out.
> 
> So, does it make sense for me to post a v5 again not using
> s390_cpu_virt_mem_write(), or are you going to refresh your stfle
> implementation?
> 
> Thanks,
> Michal
> 

A new implementation should definitely take care of the CPU model.

-- 
Thanks,

David
