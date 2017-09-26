Received: from eggs.gnu.org ([2001:4830:134:3::10]:47201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dwlYL-000290-9s
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dwlYH-0005FA-Ls
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:49:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dwlYH-0005Eu-F4
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:49:13 -0400
Date: Tue, 26 Sep 2017 10:49:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170926104903.2a50bc37@nial.brq.redhat.com>
In-Reply-To: <f5df52db-c3b7-538c-a859-345b87a9b9b4@linaro.org>
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-4-david@redhat.com>
	<f5df52db-c3b7-538c-a859-345b87a9b9b4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 03/27] target/s390x: get rid of
 next_core_id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>

On Mon, 25 Sep 2017 16:14:16 -0700
Richard Henderson <richard.henderson@linaro.org> wrote:

> On 09/18/2017 08:59 AM, David Hildenbrand wrote:
> >      /* sync cs->cpu_index and env->core_id. The latter is needed for TCG. */
> > -    cs->cpu_index = env->core_id;
> > +    cs->cpu_index = cpu->env.core_id;
> > +#endif  
> 
> Any reason not to drop core_id entirely in favour of cpu_index?
> (Since cpu_index itself is generic and can't be dropped.)
I prefer core_id vs cpu_index as the later is too generic
(and we were trying to decouple target specific attributes
/coreid/cpuid/whatnot from cpu_index as much as possible
so it would be more clear what they mean and if possible
make them in-depended of QEMU internal cpu_index which is
essentially not owned by target).
