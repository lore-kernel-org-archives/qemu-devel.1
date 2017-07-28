Received: from eggs.gnu.org ([2001:4830:134:3::10]:36838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1db4KU-0004bJ-B3
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1db4KP-0000Ho-JQ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:25:18 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-6-f4bug@amsat.org>
	<a7fdc125-9a1b-bec3-915f-e8f764816b0d@redhat.com>
	<c44770f5-df9d-2340-5dba-2f5db7acd046@redhat.com>
	<20170728135614.3f14e3ad@gondolin>
	<3abbfa87-d882-39ab-b4ab-66f3e68a2fb4@redhat.com>
	<20170728141353.3b8382be@gondolin>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a4f3a2a-cebc-e730-4a63-2616a17f5f2b@redhat.com>
Date: Fri, 28 Jul 2017 14:25:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170728141353.3b8382be@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/47] MAINTAINERS: add missing KVM entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 28/07/2017 14:13, Cornelia Huck wrote:
>>> But would it not a better idea to add an entry for all headers touched
>>> by update-linux-headers, then?  
>>
>> One thing doesn't exclude the other.  That entry would also list the
>> script itself and linux-headers.  KVM, VFIO and virtio patterns can only
>> list the files they care about.  Migration could list userfaultfd,
>> possibly.  And there's also include/standard-headers/, which includes
>> PCI and input subsystem files...  It has to be perfected, but it's a
>> good idea.
> 
> Personally, I'm not really a fan. If something is changed in one of the
> headers, it implies that either it has already been changed in the
> original headers in Linux (and I will have seen it then), or that
> someone is sending a preliminary patch (and I should hope that I'm
> already cc:ed for the changes that this headers change is for then). It
> does not really hurt, but it feels wrong.

Sometime people pull changes too early, or otherwise I want to comment
on the timing of the change... I don't know, I already get too much
qemu-devel email. :)

Paolo
