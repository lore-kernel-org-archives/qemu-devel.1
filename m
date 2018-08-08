Received: from eggs.gnu.org ([2001:4830:134:3::10]:54098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnUEZ-0006jQ-Fq
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnUEU-0004oi-KA
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:35:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnUEU-0004o4-ED
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 15:34:58 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-19-e.emanuelegiuseppe@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <aa498ebd-fa78-f3f6-cc77-db2e5b7c8dad@redhat.com>
Date: Wed, 8 Aug 2018 21:34:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180806143412.27722-19-e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 18/34] tests: virtio: separate ccw tests
 from libqos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 06/08/2018 16:33, Emanuele Giuseppe Esposito wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Because qtest does not support s390 channel I/O, s390 only performs smoke tests on
> those few devices that do not have any functional tests.  Therefore, every time we
> add functional tests for a virtio device, the choice is between removing
> those tests from the s390 suite (so that s390 actually _loses_ coverage)
> or sprinkling the test with architecture checks.
> 
> This patch simply creates a ccw-specific test that only performs smoke tests on
> all virtio-ccw devices.  If channel I/O support is ever added to qtest and libqos,
> then this file can go away.  In the meanwhile, it simplifies maintenance and
> makes sure that all virtio devices are tested.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

You can add the "Acked-by" from Cornelia and the "Reviewed-by" from Thomas.

Thanks,
Laurent
