Received: from eggs.gnu.org ([209.51.188.92]:53261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hEGkV-0002kQ-IN
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hEGkU-0002gu-Bb
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:10:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hEGkS-0002eL-Up
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 13:10:57 -0400
References: <20190407115839.25054-1-skrtbhtngr@gmail.com>
	<20190407115839.25054-3-skrtbhtngr@gmail.com>
	<20190410115001.56bbbelcmxwcqp7v@SPB-NB-133.local>
	<CAMzgYoMqE20=L+n+tjt8Nb10Tidxr0C6OumQ8vvQ423xJxnN=w@mail.gmail.com>
	<20190410140244.l5viavfey2ymzw6k@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed7dd764-ff54-58a3-b4b4-ed6951da6ef6@redhat.com>
Date: Wed, 10 Apr 2019 19:10:51 +0200
MIME-Version: 1.0
In-Reply-To: <20190410140244.l5viavfey2ymzw6k@SPB-NB-133.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND v2 2/2] cpus: move
 hvf_cpu_synchronize* calls to cpu_synchronize* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>, Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 10/04/19 16:02, Roman Bolshakov wrote:
> I've applied, built and tested both sequentially. Applying and running
> with patch 1/2 alone doesn't result in the behavior I mentioned. I also
> tried to apply only the first hunk that moves hvf_cpu_synchronize_state
> into cpu_synchronize_state and it also causes the issue with BIOS.
> 
> Honestly, I don't know if the tests run qemu with hvf accel. AFAIK
> kvm-unit-tests can be used to test an accel itself.

No, tests do not cover HVF.

Paolo
