Received: from eggs.gnu.org ([2001:4830:134:3::10]:49491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIZVR-0002fk-6O
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fIZVO-0003mR-54
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:56:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46064 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fIZVO-0003lp-01
	for qemu-devel@nongnu.org; Tue, 15 May 2018 08:56:38 -0400
References: <1523991487-241006-1-git-send-email-mst@redhat.com>
	<20180515061211-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b69cbb34-5c3b-d0a2-abb6-eb17c1b6967e@redhat.com>
Date: Tue, 15 May 2018 14:56:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180515061211-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] move kvm_para.h to standard-headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Wanpeng Li <kernellwp@gmail.com>, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 15/05/2018 14:33, Michael S. Tsirkin wrote:
>> Let's just pull it into standard-headers instead, and use
>> on all platforms unconditionally.
>>
>> It turns out we only need the x86 version, so that is
>> and extra a plus - drop the rest.
>
> Ping kvm maintainers - any comments?
> Should I merge this one?

Yes, go ahead!

Paolo
