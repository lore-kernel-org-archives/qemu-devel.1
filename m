Received: from eggs.gnu.org ([208.118.235.92]:45553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gcsqg-0005WU-QJ
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 09:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gcsZs-0007RV-Ug
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 08:53:32 -0500
References: <20181221124410.11920-1-pbonzini@redhat.com>
	<82D7661F83C1A047AF7DC287873BF1E172C97D77@SHSMSX101.ccr.corp.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed344ef0-c519-1c71-c0ad-fb523a5dc516@redhat.com>
Date: Fri, 28 Dec 2018 14:53:22 +0100
MIME-Version: 1.0
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E172C97D77@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: mark the 'INTEL_PT' CPUID bit as
 unmigratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Kang, Luwei" <luwei.kang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

On 25/12/18 09:23, Kang, Luwei wrote:
>> From: Qemu-devel [mailto:qemu-devel-bounces+luwei.kang=intel.com@nongnu.org] On Behalf Of Paolo Bonzini
>> Sent: Friday, December 21, 2018 8:44 PM
>> To: qemu-devel@nongnu.org
>> Cc: ehabkost@redhat.com; qemu-stable@nongnu.org
>> Subject: [Qemu-devel] [PATCH] i386: mark the 'INTEL_PT' CPUID bit as unmigratable
>>
>> Marshaling of processor tracing MSRs is not yet implemented in QEMU, mark the feature as unmigratable.
> 
> Hi Paolo,
>     I think Intel PT has supported live migration. I don't understand what you mean.
> 
>     commit b77146e9a129bcdb60edc23639211679ae846a92
>     Author: Chao Peng <chao.p.peng@linux.intel.com>
>     Date:   Mon Mar 5 00:48:36 2018 +0800
>     i386: Add support to get/set/migrate Intel Processor Trace feature

Indeed.  I had forgotten this patch because it was committed so long
before the kernel parts (which really should not happen, but Eduardo and
I miscommunicated on it).  Can you check that it still works?

Paolo
