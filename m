Received: from eggs.gnu.org ([209.51.188.92]:59366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyuTl-00074N-0Q
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyuTk-00053r-2F
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:22:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gyuTi-0004zg-Rf
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 03:22:11 -0500
References: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
	<1550847320-25110-11-git-send-email-jasowang@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <30e7bd39-7ca1-fd1a-1864-b3a0a390f4fc@redhat.com>
Date: Wed, 27 Feb 2019 09:21:53 +0100
MIME-Version: 1.0
In-Reply-To: <1550847320-25110-11-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 10/13] tests: Add a test for qemu self
 announcements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Vlad Yasevich <vyasevic@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 22/02/2019 15.55, Jason Wang wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> We now expose qemu_announce_self through QMP and HMP.  Add a test
> with some very basic packet validation (make sure we get a RARP).
> 
> Signed-off-by: Vlad Yasevich <vyasevic@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  tests/Makefile.include     |  3 ++
>  tests/test-announce-self.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
>  create mode 100644 tests/test-announce-self.c
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b39e989..1b0874c 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -144,6 +144,7 @@ check-qtest-generic-y += tests/qmp-cmd-test$(EXESUF)
>  
>  check-qtest-generic-y += tests/device-introspect-test$(EXESUF)
>  check-qtest-generic-y += tests/cdrom-test$(EXESUF)
> +gcov-files-generic-y = migration/savevm.c

AFAIK you don't need these gcov lines anymore. See commit
26830e9325d05d537dd9a3765437908771d19475.

 Thomas
