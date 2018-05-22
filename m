Received: from eggs.gnu.org ([2001:4830:134:3::10]:56369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fKzXi-0006BZ-GC
	for qemu-devel@nongnu.org; Tue, 22 May 2018 01:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fKzXd-0001Qp-HR
	for qemu-devel@nongnu.org; Tue, 22 May 2018 01:09:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55416 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fKzXd-0001QY-Cg
	for qemu-devel@nongnu.org; Tue, 22 May 2018 01:08:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFA8AFA466
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 05:08:56 +0000 (UTC)
Date: Tue, 22 May 2018 13:08:51 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180522050851.GA31932@xz-mi>
References: <20180522035629.30428-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180522035629.30428-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] error-report: introduce
 {error|warn}_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>

On Tue, May 22, 2018 at 11:56:27AM +0800, Peter Xu wrote:
> v2:
> - for patch 1: replace tabs, add trivial comment [Markus]
>   (I didn't add much comment otherwise I'll need to duplicate what's
>    there in error_report())
> - add patch 2
> 
> Patch 1 introduce the helpers.
> 
> Patch 2 use it to replace VT-d trace_vtd_err().
> 
> Please review.  Thanks.

Sorry I forgot to CC Eric in the series.  Adding in.

-- 
Peter Xu
