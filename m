Received: from eggs.gnu.org ([2001:4830:134:3::10]:41453)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1ddZNk-0006BA-PW
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1ddZNf-00013n-Vr
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:59:00 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:60331 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1ddZNf-00013N-Lv
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 05:58:55 -0400
References: <526F8457.5040907@kamp.de> <526F8701.2030906@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <1aefefcb-5ea7-e91f-bf11-4cde9ccd0f92@kamp.de>
Date: Fri, 4 Aug 2017 11:58:52 +0200
MIME-Version: 1.0
In-Reply-To: <526F8701.2030906@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Prohibit Windows from running in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Am 29.10.2013 um 10:59 schrieb Paolo Bonzini:
> Il 29/10/2013 10:48, Peter Lieven ha scritto:
>> Hi all,
>>
>> this question might seem a bit weird, but does anyone see a good way to
>> avoid
>> that Windows is able to boot inside qemu?
>>
>> We have defined several profiles for different operation systems and I want
>> to avoid that someone chooses Linux and then installs Windows within
>> a VM. Reason is licensing.
> Patch QEMU to crash when Hyper-V extensions are enabled...

Hi all,

this is an old topic that has become important for me again recently.
Now all Linux versions should be able to detect KVM even if Hyper-V is enabled.

But how do I detect from Qemu userspace that Hyper-V is enabled?

Thanks,
Peter
