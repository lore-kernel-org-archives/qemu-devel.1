Received: from eggs.gnu.org ([2001:4830:134:3::10]:52853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cbNwW-0000fZ-E6
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 03:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cbNwT-0006fk-CB
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 03:49:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cbNwT-0006fA-6m
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 03:49:33 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170207155956.21573-1-pbonzini@redhat.com>
	<b7fc7007-1663-b41d-422a-9600e44d7b38@redhat.com>
Date: Wed, 08 Feb 2017 09:49:29 +0100
In-Reply-To: <b7fc7007-1663-b41d-422a-9600e44d7b38@redhat.com> (Eric Blake's
	message of "Tue, 7 Feb 2017 10:51:39 -0600")
Message-ID: <87zihxukx2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] link to .xz files to save some bandwidth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 02/07/2017 09:59 AM, Paolo Bonzini wrote:
>> I have converted all .gz and .bz2 files to .xz on download.qemu.org
>> and this patch would change the links in the website.  This would save
>> about 5 GB of bandwidth every day (about 20% savings).
>> 
>> xz should be available for all platforms.  Besides providing better
>> compression ratios, decompression of .xz files is about twice as fast
>> compared to bzip2.  Compression instead is about 5.5 times slower.
>
> I agree that bzip2 is pointless these days; .gz is a bit more important
> when targetting older platforms but I think that does not describe
> qemu's target audience.  Do we want to even enter the xz vs. lzma
> controversy, or are we okay with being xz-only?

Pointer to / summary of the controversy, so that folks can decide
whether they care?
