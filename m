Received: from eggs.gnu.org ([2001:4830:134:3::10]:45167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cUYiz-0005ZX-Va
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cUYiw-0003ML-Uw
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:55:26 -0500
References: <1484914681-2986-1-git-send-email-thuth@redhat.com>
	<CAFEAcA-fY53-z2awJ_e9738A+MNgYiaVQEn=xJkWn3Xj60nCMw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <60d4c803-f4c0-f939-5489-735a6620368c@redhat.com>
Date: Fri, 20 Jan 2017 13:55:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-fY53-z2awJ_e9738A+MNgYiaVQEn=xJkWn3Xj60nCMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Introduce DEVICE_CATEGORY_CPU for CPU
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 20.01.2017 13:31, Peter Maydell wrote:
> On 20 January 2017 at 12:18, Thomas Huth <thuth@redhat.com> wrote:
>> Now that the hot-pluggable CPUs show up in the help text of
>> "-device ?", we should group them into an appropriate category.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/ppc/pnv_core.c       | 1 +
>>  hw/ppc/spapr_cpu_core.c | 1 +
>>  include/hw/qdev-core.h  | 1 +
>>  qdev-monitor.c          | 1 +
>>  target/i386/cpu.c       | 2 ++
>>  5 files changed, 6 insertions(+)
> 
> Can we just set the category bit in the class init functions
> for the TYPE_CPU and TYPE_CPU_CORE superclasses, rather
> than having to do it in a subclass for each architecture
> (and thus potentially forgetting to do it for other archs) ?

Good idea, that seems to work, too. I'll send a v2 ...

 Thomas
