Received: from eggs.gnu.org ([2001:4830:134:3::10]:34510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cipDd-00062u-9b
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:22:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cipDc-0007x8-6O
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 16:22:01 -0500
Date: Tue, 28 Feb 2017 16:21:51 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170228212151.GF15696@localhost.localdomain>
References: <20170228163436.31357-1-jcody@redhat.com>
	<148830310063.255.10289523061179167346@0e2666bad730>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <148830310063.255.10289523061179167346@0e2666bad730>
Subject: Re: [Qemu-devel] [PULL v2 0/5] Block patches for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, peter.maydell@linaro.org

On Tue, Feb 28, 2017 at 09:31:41AM -0800, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.
> 
> Type: series
> Subject: [Qemu-devel] [PULL v2 0/5] Block patches for 2.9
> Message-id: 20170228163436.31357-1-jcody@redhat.com
>

[...]

>   GTESTER check-qtest-ppc
>   GTESTER check-qtest-s390x
> Broken pipe
> GTester: last random seed: R02S4f6b38007e72c70dc3a3e7e342ee3dc2
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> /var/tmp/patchew-tester-tmp-vnruirxx/src/tests/Makefile.include:793: recipe for target 'check-qtest-s390x' failed
> make: *** [check-qtest-s390x] Error 1
> make: *** Waiting for unfinished jobs....
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> Warning! iasl couldn't parse the expected aml
> "kvm" accelerator not found.
> "kvm" accelerator not found.
> === OUTPUT END ===
> 

I am assuming this is a patchew error, rather than an error in my pull req,
right?  The v1 pull req (which is the same but lacking s-o-b's) did not
throw any errors, and these errors seem perhaps more like test harness
errors than anything else.
