Received: from eggs.gnu.org ([2001:4830:134:3::10]:42115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cmN9C-0007yt-BY
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cmN98-0005Ek-Bg
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:12:06 -0500
Received: from h2042504.stratoserver.net ([85.214.107.226]:43296)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <git@kirschju.re>) id 1cmN98-0005EP-5W
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 11:12:02 -0500
References: <20170308001637.9838-1-git@kirschju.re>
	<acb6dafc-ff73-9b59-22c0-aa5e8219e925@redhat.com>
	<4684e745-3cf1-49e9-0a9d-13f86f1cc8f1@kirschju.re>
	<20170310150915.1c09d264@nial.brq.redhat.com>
From: Julian Kirsch <git@kirschju.re>
Message-ID: <718f92c0-89ae-8c09-5716-c72675a11093@kirschju.re>
Date: Fri, 10 Mar 2017 17:11:58 +0100
MIME-Version: 1.0
In-Reply-To: <20170310150915.1c09d264@nial.brq.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] X86/HMP: Expose x86 model specific
 registers via human monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 10.03.2017 15:09, Igor Mammedov wrote:
> we are trying no to use cpu_index in outside interfaces and
> make it disappear from there. 
> It's possible to use qom-path instead or more natural
> CpuInstanceProperties to specify a CPU.
> 
> PS:
> Comment applies to all QMP/monitor commands/structures introduced
> in this patch.
> 

Hi Igor,

I removed cpu-idx in accordance with Dave's comment from two days ago. The
command is now called msr-get/msr-set and only affects the curent default cpu
(same behavior as, for instance, info registers).

Best,
Julian
