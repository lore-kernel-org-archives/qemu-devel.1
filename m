Received: from eggs.gnu.org ([209.51.188.92]:39610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1hEDoW-0003cy-Gm
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1hEDoV-0000Ev-HH
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:02:56 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:45010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1hEDoT-0000Ch-N1
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:02:54 -0400
Date: Wed, 10 Apr 2019 17:02:44 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20190410140244.l5viavfey2ymzw6k@SPB-NB-133.local>
References: <20190407115839.25054-1-skrtbhtngr@gmail.com>
	<20190407115839.25054-3-skrtbhtngr@gmail.com>
	<20190410115001.56bbbelcmxwcqp7v@SPB-NB-133.local>
	<CAMzgYoMqE20=L+n+tjt8Nb10Tidxr0C6OumQ8vvQ423xJxnN=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMzgYoMqE20=L+n+tjt8Nb10Tidxr0C6OumQ8vvQ423xJxnN=w@mail.gmail.com>
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
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Apr 10, 2019 at 05:35:23PM +0530, Sukrit Bhatnagar wrote:
> On Wed, 10 Apr 2019 at 17:20, Roman Bolshakov <r.bolshakov@yadro.com> wrote:
> >
> > On Sun, Apr 07, 2019 at 05:28:39PM +0530, Sukrit Bhatnagar wrote:
> > > Keep the calls made to synchronize cpu by all hypervisors in one place
> > > inside cpu_synchronize_* functions in include/sysemu/hw_accel.h
> > >
> >
> > The commit itself looks sane but qemu starts to hang during BIOS boot
> > after I've applied it if I run it with hvf accel.
> 
> Hi Roman,
> Thanks for reviewing the patches.
> If this is happening, then I assume patches are not ready
> to be merged into qemu-stable.
> Do you have any idea why the problem is not detected
> during tests, but rather at runtime?
> I am not really sure if this patch (2/2) has anything to do with
> the problem but the previous patch (1/2) might.
> 

I've applied, built and tested both sequentially. Applying and running
with patch 1/2 alone doesn't result in the behavior I mentioned. I also
tried to apply only the first hunk that moves hvf_cpu_synchronize_state
into cpu_synchronize_state and it also causes the issue with BIOS.

Honestly, I don't know if the tests run qemu with hvf accel. AFAIK
kvm-unit-tests can be used to test an accel itself.

Thanks,
Roman
