Received: from eggs.gnu.org ([2001:4830:134:3::10]:47378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ecY8H-0003Wa-HT
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:59:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ecY8E-00048H-T2
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:59:05 -0500
References: <20180119094015.28266-1-david@gibson.dropbear.id.au>
	<CAFEAcA-sHoJvWjJNZLv42DHk66GtfbHgDXif5y8kb1Doxj5WbA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <82e7e302-3ced-5d4e-3087-828202c51643@redhat.com>
Date: Fri, 19 Jan 2018 15:58:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-sHoJvWjJNZLv42DHk66GtfbHgDXif5y8kb1Doxj5WbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/13] ppc-for-2.12 queue 20180119
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, surajjs@au1.ibm.com, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>

On 19.01.2018 15:11, Peter Maydell wrote:
> On 19 January 2018 at 09:40, David Gibson <david@gibson.dropbear.id.au> wrote:
>> The following changes since commit b4d6ed1c5ae519d3efb5297be3ef6625ca2a20f4:
>>
>>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-01-17' into staging (2018-01-18 15:25:17 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180119
>>
>> for you to fetch changes up to 040cb0a2badf9e265cdbb78380048cd1624dd434:
>>
>>   target/ppc/spapr_caps: Add macro to generate spapr_caps migration vmstate (2018-01-19 16:06:26 +1100)
>>
>> ----------------------------------------------------------------
>> ppc patch queue 2018-01-19
>>
>> Quite soon after my previous pull request, but it's already
>> accumulated a reasonable amount of stuff:
>>   * Significant TCG speedup by optimizing cmp generation
>>   * Fix a regression caused by recent change to set compat mode on
>>     hotplugged cpus
>>   * Cleanup of default configs
>>   * Some implementation of msgsnd/msgrcv instructions for server chips
>>
>> ----------------------------------------------------------------
> 
> 
> 'make check' logs are full of
> qemu-system-ppcemb: warning: qemu-system-ppcemb is deprecated, please
> use qemu-system-ppc instead.
> 
> You need to silence that, or it's impossible for me to find actual
> warnings in build tests.

Sorry for that!

David, could you please simply unqueue the ppcemb deprecation patch
until I found a better solution? qtest_enabled() does not seem to work
in ppc_cpu_register_types(), so I've got to find a different spot for
printing the warning...

 Thomas
