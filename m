Received: from eggs.gnu.org ([2001:4830:134:3::10]:35957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f1XWl-0007Y7-Mg
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 09:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f1XWh-0000pJ-OQ
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 09:23:39 -0400
References: <1522316251-16399-1-git-send-email-thuth@redhat.com>
	<20180329151505.36a28a74.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <76c9cfb5-504c-9490-35bc-0297b3c960a9@redhat.com>
Date: Thu, 29 Mar 2018 15:23:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180329151505.36a28a74.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: Increase virtio
 timeout to 30 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, ldoktor@redhat.com

On 29.03.2018 15:15, Cornelia Huck wrote:
> On Thu, 29 Mar 2018 11:37:31 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The current timeout is set to only three seconds - and considering that
>> vring_wait_reply() or rather get_second() is not doing any rounding,
>> the real timeout is likely rather 2 seconds in most cases. When the
>> host is really badly loaded and we run the guest in TCG mode instead
>> of KVM, it's possible that we hit this timeout by mistake. 
> 
> Let's tweak this sentence to
> 
> "When the host is really badly loaded, it's possible that we hit this
> timeout by mistake; it's even more likely if we run the guest in TCG
> mode instead of KVM."
> 
> ?

Fine for me. You could even remove that TCG vs. KVM part if you like.

 Thomas
