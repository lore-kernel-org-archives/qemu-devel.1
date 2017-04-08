Received: from eggs.gnu.org ([2001:4830:134:3::10]:44424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cwn2y-00068D-Lp
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cwn2v-00020I-Iv
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:52:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cwn2v-000200-CZ
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 05:52:41 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53F02C057FA5
	for <qemu-devel@nongnu.org>; Sat,  8 Apr 2017 09:52:40 +0000 (UTC)
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-6-pbonzini@redhat.com>
	<48253fa9-d5eb-f750-6dfc-e478bfd85277@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a9195765-0f0b-7aac-a403-9dc4ebd376f4@redhat.com>
Date: Sat, 8 Apr 2017 17:52:36 +0800
MIME-Version: 1.0
In-Reply-To: <48253fa9-d5eb-f750-6dfc-e478bfd85277@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/10] blockjob: separate monitor and
 blockjob APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: jcody@redhat.com



On 08/04/2017 08:03, John Snow wrote:
> Looks clean, though it may be useful to do a few more things;
> 
> - Demarcate what you think is the monitor API in this file

It's already there:

+/*
+ * API for block job drivers and the block layer.
+ */
+

where everything before is for the monitor.

> - Organize blockjob.h to match to serve as a useful reference.

Hmm, yes.

Paolo
