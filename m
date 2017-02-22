Received: from eggs.gnu.org ([2001:4830:134:3::10]:54568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cgX07-0003IE-D4
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:30:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cgX06-0006l9-Ez
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 08:30:35 -0500
Date: Wed, 22 Feb 2017 14:30:19 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170222143019.789cfbbf@nial.brq.redhat.com>
In-Reply-To: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
References: <1487357795-52614-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/3] generalize parsing of cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 17 Feb 2017 19:56:32 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> Some callers call CPUClass->parse_features manually to convert
> '-cpu cpufoo,featurestr' string to cpu type and featurestr
> into a set of global properties. And theni do controlled
> cpu creation with setting properties and completing it with realize.
> That's a lot of code duplication as they are practically
> reimplement the same parsing logic.
> 
> Some don't and use cpu_generic_init() instead which does
> the same parsing along with creation/realizing cpu within one
> wrapper.
> 
> And some trying to switch to controlled cpu creation,
> implement object_new()/set properties/realize steps
> but forget feature parsing logic witch lieads to 'bugs'
> commit 00909b585 (hw/arm/integratorcp: Support specifying features via -cpu)
> 
> 
> This series moves -cpu option parsing to generic machine code
> that removes a little of code duplication and makes cpus creation
> process more unified.
> 
> PS:
> As I don't have time to rewrite this part QEMU, being busy
> rewritting yet another part of QEMU,
> SERIES IS UNFINISHED AND SERVERS TO SHOW IDEA HOW IT SHOULD
> BE DONE. FEEL FREE TO PICK UP AND COMPLETE THIS PATCHES
> TO HANDLE ALL BOARDS (series does it only for virt-arm/spapr/pc)

series has been written on top my numa tree which apply it to
upstream master. So here goes rebased on top of current master variant:

https://github.com/imammedo/qemu/commits/generilize_cpu_model_parsing_rfc
