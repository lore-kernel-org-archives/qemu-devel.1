Received: from eggs.gnu.org ([2001:4830:134:3::10]:42317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cUaJK-00089h-Ql
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:37:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cUaJH-0007Uf-O1
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:37:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33373
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cUaJH-0007UU-IV
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 09:36:59 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0KEYY73002825
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 09:36:58 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
	by mx0b-001b2d01.pphosted.com with ESMTP id 283kj1a82j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 09:36:58 -0500
Received: from localhost
	by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 20 Jan 2017 14:36:54 -0000
Date: Fri, 20 Jan 2017 15:36:48 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170119210449.11991-1-ehabkost@redhat.com>
References: <20170119210449.11991-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170120153648.391034a7.cornelia.huck@de.ibm.com>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 19 Jan 2017 19:04:43 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> This is v2 of the previous series that enabled the "host" CPU
> model on TCG. Now a new "max" CPU is being added, while keeping
> "host" KVM-specific.

This looks like a good idea, and I think we'll do the same on s390.
