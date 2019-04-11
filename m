Received: from eggs.gnu.org ([209.51.188.92]:59608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEffA-0007El-99
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEff9-0001i4-Bc
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:47:08 -0400
References: <20190313162812.8885-1-armbru@redhat.com>
	<8cd63797-76f6-9ba8-0113-13a4bf04e6ed@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9585a1fc-fc7c-d3f4-06be-46d1a544a0ce@vivier.eu>
Date: Thu, 11 Apr 2019 21:46:59 +0200
MIME-Version: 1.0
In-Reply-To: <8cd63797-76f6-9ba8-0113-13a4bf04e6ed@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] Clean up includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, viktor.prutyanov@phystech.edu, QEMU Trivial <qemu-trivial@nongnu.org>, kraxel@redhat.com, marcel.apfelbaum@gmail.com, alex.bennee@linaro.org

On 21/03/2019 10:21, Thomas Huth wrote:
> On 13/03/2019 17.28, Markus Armbruster wrote:
>> Clean up includes so that osdep.h is included first and headers
>> which it implies are not included manually.
>>
>> This commit was created with scripts/clean-includes, with the changes
>> to the following files manually reverted:
>>
>>     contrib/libvhost-user/libvhost-user-glib.h
>>     contrib/libvhost-user/libvhost-user.c
>>     contrib/libvhost-user/libvhost-user.h
>>     linux-user/mips64/cpu_loop.c
>>     linux-user/mips64/signal.c
>>     linux-user/sparc64/cpu_loop.c
>>     linux-user/sparc64/signal.c
>>     linux-user/x86_64/cpu_loop.c
>>     linux-user/x86_64/signal.c
>>     slirp/src/*
>>     target/s390x/gen-features.c
>>     tests/migration/s390x/a-b-bios.c
>>     tests/test-rcu-simpleq.c
>>     tests/test-rcu-tailq.c
>>     tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c
>>
>> We're in the process of spinning out slirp/.  tests/uefi-test-tools/
>> is guest software.  The remaining reverts are the same as in commit
>> b7d89466dde.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  contrib/elf2dmp/main.c   | 3 +--
>>  contrib/elf2dmp/pdb.c    | 3 +--
>>  hw/display/ati.c         | 1 +
>>  hw/display/ati_2d.c      | 1 +
>>  hw/display/ati_dbg.c     | 1 +
>>  hw/display/ati_int.h     | 1 -
>>  include/hw/cpu/cluster.h | 1 -
>>  tests/fp/platform.h      | 1 -
>>  tests/libqos/qgraph.h    | 4 ----
>>  tests/qos-test.c         | 2 +-
>>  10 files changed, 6 insertions(+), 12 deletions(-)
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


Applied to my trivial-patches branch.

Thanks,
Laurent
