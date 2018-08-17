Received: from eggs.gnu.org ([2001:4830:134:3::10]:40628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqc5A-0003gg-4V
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqc55-0007ry-T0
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:34:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fqc55-0007qq-Jt
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 06:34:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so6678665wrr.4
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 03:34:11 -0700 (PDT)
References: <1534419358-10932-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92751ce7-6ecd-a819-4ffb-1701e787331e@redhat.com>
Date: Fri, 17 Aug 2018 12:34:07 +0200
MIME-Version: 1.0
In-Reply-To: <1534419358-10932-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/8] Various qtest-related patches and a
 mc146818rtc fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 16/08/2018 13:35, Thomas Huth wrote:
> The basic idea for this patch series are the two patches that improve
> the device-inrospection test: We now check that the qom-tree and the
> qtree do not change during introspection, and the we also turn on the
> device introspection test with all machines when running in SPEED=slow
> mode. The other patches are a bug fix for the mc146818rtc device which
> has been discovered with the improved device-introspection test, two
> patches to shut up annoying messages during "make check", a patch to
> speed up the tests that iterate over all machine types and an update
> to the MAINTAINERS file.
> 
> v2:
>  - Added Reviewed-bys from v1
>  - Use g_test_message() instead of g_debug()
>  - Improved the patch descriptions a little bit
>  - Added patch to skip old versioned machine types in quick mode
>  - Added Paolo's update to MAINTAINERS
> 
> Paolo Bonzini (1):
>   MAINTAINERS: add maintainers for qtest
> 
> Thomas Huth (7):
>   tests/migration-test: Silence the kvm_hv message by default
>   net: Silence 'has no peer' messages in testing mode
>   hw/timer/mc146818rtc: White space clean-up
>   hw/timer/mc146818rtc: Fix introspection problem
>   tests: Skip old versioned machine types in quick testing mode
>   tests/device-introspection: Check that the qom-tree and qtree do not
>     change
>   tests/device-introspect: Test with all machines, not only with "none"
> 
>  MAINTAINERS                    | 10 ++++++++
>  hw/ppc/prep.c                  |  3 +++
>  hw/timer/mc146818rtc.c         | 20 ++++++---------
>  tests/cpu-plug-test.c          |  6 ++---
>  tests/device-introspect-test.c | 55 ++++++++++++++++++++++++++++++++++++------
>  tests/libqtest.c               | 52 +++++++++++++++++++++++++++++++++++++--
>  tests/libqtest.h               |  4 ++-
>  tests/migration-test.c         | 20 ++++++++-------
>  tests/qom-test.c               |  2 +-
>  tests/test-hmp.c               |  2 +-
>  vl.c                           |  3 +--
>  11 files changed, 138 insertions(+), 39 deletions(-)
> 

Queued, thanks.

Paolo
