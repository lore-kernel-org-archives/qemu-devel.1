Received: from eggs.gnu.org ([2001:4830:134:3::10]:54392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cehyW-0001hm-Ts
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:49:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cehyW-00020h-8d
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:49:24 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1252732340.24195236.1487334609462.JavaMail.zimbra@redhat.com>
References: <1487318764-29513-1-git-send-email-pagupta@redhat.com>
	<w51poihqggo.fsf@maestria.local.igalia.com>
	<1323841238.24175066.1487331028566.JavaMail.zimbra@redhat.com>
	<20170217113601.GB4941@work-vm>
	<1252732340.24195236.1487334609462.JavaMail.zimbra@redhat.com>
Date: Fri, 17 Feb 2017 13:49:12 +0100
Message-ID: <w51k28pq8xj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block,
 migration: Use qemu_madvise inplace of madvise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Fri 17 Feb 2017 01:30:09 PM CET, Pankaj Gupta wrote:
> I think 'posix_madvise' was added for systems which didnot have
> 'madvise' [...] For the systems which don't have madvise call
> 'posix_madvise' is called which as per discussion is not right thing
> for 'DONTNEED' option. It will not give desired results.
>
> Either we have to find right alternative or else it is already broken
> for systems which don't support madvise.

Do you have an example of a call that is currently broken in the QEMU
code?

Berto
