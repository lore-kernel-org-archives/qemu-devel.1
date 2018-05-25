Received: from eggs.gnu.org ([2001:4830:134:3::10]:51578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fMHW9-0003X2-Ig
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:32:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fMHW6-0007bs-E8
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:32:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48370 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fMHW6-0007bl-9T
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:32:42 -0400
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ba085afc-8aad-6e70-58db-072c88311cfd@redhat.com>
Date: Fri, 25 May 2018 13:32:40 -0500
MIME-Version: 1.0
In-Reply-To: <1527266793-301361-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/20] include cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

On 05/25/2018 11:47 AM, Michael S. Tsirkin wrote:
> Right now, a local header can be included with either
> 
> #include "foo.h"
>      or
> #include "dir/foo.h"
> 
> since the later doesn't tell you where the header is
> (in source or include directory), the former is preferable.
> 
> I intend to look for ways to prevent the second way from working, but
> that will take time. For now, fix all instances for the later way I
> could find.
> 
> In a couple of places I just dropped the include instead.
> 
> Finally, arch_init huge list of includes is sorted, which will be
> helpful in future cleanups.
> 
> This was part of the include path cleanup patchset
> (https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg00739.html).
> 
> Changes from v1
>      drop patches not dealing with local headers
>      stop saying include through root works by accident -
>          it's not by accident, just not how we'd like code to look like

You mostly did that, but I still think some of the commit messages can 
be improved. See 15/20.

>      address comments by eric, philip, others

At any rate, I think we are getting closer; and splitting this into a 
less-controversial part compared to the rest of v1 makes it more likely 
that this half can go in soon.  Many of the patches are independent, but 
it's still probably easier if this goes in through one tree (Paolo's 
misc tree, perhaps?), once you've collected reviews.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
