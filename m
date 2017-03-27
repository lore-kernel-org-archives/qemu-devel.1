Received: from eggs.gnu.org ([2001:4830:134:3::10]:35446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXUy-0006q2-SV
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csXUu-0005R7-VG
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:28:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csXUu-0005Qp-QC
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:28:00 -0400
References: <1490624810-44752-1-git-send-email-agraf@suse.de>
	<20170327154636.GI28530@thinpad.lan.raisama.net>
	<437e1004-b9b2-e9c0-cc89-5c926eb0b306@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed5116a9-14eb-75ac-6c51-c1d0d97a0650@redhat.com>
Date: Mon, 27 Mar 2017 18:27:55 +0200
MIME-Version: 1.0
In-Reply-To: <437e1004-b9b2-e9c0-cc89-5c926eb0b306@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: Allow monitor / mwait cpuid override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, kvm@vger.kernel.org



On 27/03/2017 18:22, Alexander Graf wrote:
>>
>> If you really want something that makes QEMU ignore what the
>> accel code is reporting, I would prefer a syntax that could be
>> used for other features too, like "-cpu ...,monitor=force".
> 
> Is there any QOM property that does this yet? I can't seem to find any
> tri-state (on/off/force) parsers and I want to make sure I don't
> reinvent the wheel.

No, but there's on/off/auto that you can copy.

Paolo
