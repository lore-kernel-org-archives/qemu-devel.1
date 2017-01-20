Received: from eggs.gnu.org ([2001:4830:134:3::10]:39270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cUa9w-0000Fy-Cx
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:27:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cUa9v-00037C-NK
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:27:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cUa9v-00036t-GQ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:27:19 -0500
References: <20170119210449.11991-1-ehabkost@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <c143d8bd-6283-faf1-e233-cf82ceb83da0@redhat.com>
Date: Fri, 20 Jan 2017 15:27:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170119210449.11991-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] i386: Add "max" CPU model to TCG and
 KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

Am 19.01.2017 um 22:04 schrieb Eduardo Habkost:
> This is v2 of the previous series that enabled the "host" CPU
> model on TCG. Now a new "max" CPU is being added, while keeping
> "host" KVM-specific.
> 
> In addition to simply adding "max" as a copy of the existing
> "host" CPU model, additional patches change it to not use any
> host CPUID information when in TCG mode.
> 

Concept looks good to me. Should also be fairly simple to implement for
s390x. Of course, the same restriction as for the "host" model applies
to "max" then. When running under KVM, and the CPU model KVM interface
is missing, the "max" model won't be able to be expanded.

-- 

David
