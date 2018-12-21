Received: from eggs.gnu.org ([2001:4830:134:3::10]:49671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gaEaZ-0001zr-R8
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:47:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gaEaW-0006SW-M6
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:47:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gaEaW-0006RZ-Cq
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 01:47:12 -0500
References: <beec7ae9-f9ce-52f0-7e55-cb25d70c51f4@ozlabs.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d5247b86-4c9c-0eff-7900-66443041f63e@redhat.com>
Date: Fri, 21 Dec 2018 07:47:07 +0100
MIME-Version: 1.0
In-Reply-To: <beec7ae9-f9ce-52f0-7e55-cb25d70c51f4@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] travis failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 2018-12-21 04:06, Alexey Kardashevskiy wrote:
> Hi
> 
> I am trying https://travis-ci.org/aik/qemu/ and that thing fails every
> time I am not so sure why.
> 
> One example:
> https://travis-ci.org/aik/qemu/jobs/470796318
> 
> The errors are like this:
> 
>   GTESTER check-qtest-unicore32
>   GTESTER check-qtest-x86_64
> Could not access KVM kernel module: No such file or directory
> qemu-system-x86_64: failed to initialize KVM: No such file or directory
> qemu-system-x86_64: Back to tcg accelerator
> 
> 
> Does anyone else see those? How do we fix them? Thanks.

Some test are explicitly requesting "-M accel=kvm:tcg" and this is
causing this message if KVM is not available. We could maybe silence
them if qtest_enabled() ?

 Thomas
