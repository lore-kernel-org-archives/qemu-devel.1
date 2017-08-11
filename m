Received: from eggs.gnu.org ([2001:4830:134:3::10]:49310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dgEtC-0002jy-68
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dgEt9-0001FA-3G
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:42:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dgEt8-0001Ep-Sa
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 14:42:27 -0400
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-5-david@redhat.com>
	<f5d6b3dc-3b05-e93a-8b6f-60c9fd922efb@redhat.com>
	<B286F420-B2F7-407A-978A-A5D100CD0375@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <731ac367-7c81-a70a-f4c0-dff8a875f687@redhat.com>
Date: Fri, 11 Aug 2017 20:42:22 +0200
MIME-Version: 1.0
In-Reply-To: <B286F420-B2F7-407A-978A-A5D100CD0375@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 4/5] target/s390x: remove all
 CONFIG_KVM from cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com

On 11.08.2017 19:18, Richard Henderson wrote:
> It's not all kvm related, so I'd prefer the more general name.

Thomas suggested to have both, internal.h and kvm_s390x.h

All KVM stuff goes into kvm_s390x.h. I even moved the stubs to
kvm-stubs.c (that's the way e.g. x86 handles it).

End result looks pretty clean, will send it out shortly.

Thanks!

> 
> r~
> 
> On August 11, 2017 9:19:52 AM CDT, Thomas Huth <thuth@redhat.com> wrote:
> 
>     On 11.08.2017 09:46, David Hildenbrand wrote:
> 
>         Let's move everything into internal.h
> 
> 
>     Or kvm_s390x.h ? ;-)
> 
>      Thomas
> 
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.


-- 

Thanks,

David
