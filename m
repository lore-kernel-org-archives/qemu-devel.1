Received: from eggs.gnu.org ([2001:4830:134:3::10]:39051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1eqp5c-000681-IY
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1eqp5Y-0003vg-MS
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:55:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:57893)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1eqp5Y-0003sn-Ee
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 18:55:16 -0500
References: <1490624810-44752-1-git-send-email-agraf@suse.de>
	<33183CC9F5247A488A2544077AF19020DA56A1AE@DGGEMA505-MBX.china.huawei.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <b5b23b57-8f66-3774-3a45-e42fd7edae96@suse.de>
Date: Wed, 28 Feb 2018 00:55:11 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA56A1AE@DGGEMA505-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Zhuangyanying <ann.zhuangyanying@huawei.com>



On 27.02.18 10:52, Gonglei (Arei) wrote:
> Hi all,
> 
> Guests could achive good performance in 'Message Passing Workloads' 
> scenarios when knowing the X86_FEATURE_MWAIT feature which is presented by qemu. 
> the reason is that after knowing that feature, 
> the guest could use mwait method, which saves VMEXIT, 
> to do idle, and achives high performace in latency-sensitive scenario.
> 
> Is there any plan for this patch? 
> 
> Or May I send a updated version based on yours? @Alex?

Oh, did I drop the ball on this one? If that's the case, sure, go ahead.


Alex
