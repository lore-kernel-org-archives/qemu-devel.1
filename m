Received: from eggs.gnu.org ([2001:4830:134:3::10]:34340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1djqTb-00083k-4C
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 13:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1djqTY-0003EB-0K
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 13:26:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1djqTX-0003CY-Pw
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 13:26:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DE084A6F0
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 17:26:54 +0000 (UTC)
Date: Mon, 21 Aug 2017 13:26:51 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <200452322.256075.1503336411099.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170821141008.19383-1-famz@redhat.com>
References: <20170821141008.19383-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/4] scsi-block: Support werror/rerror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

----- Original Message -----
> From: "Fam Zheng" <famz@redhat.com>
> To: qemu-devel@nongnu.org
> Cc: "Paolo Bonzini" <pbonzini@redhat.com>
> Sent: Monday, August 21, 2017 4:10:04 PM
> Subject: [PATCH v4 0/4] scsi-block: Support werror/rerror
> 
> v4: Handle more sense keys/ascqs. [Paolo]
>     Add scsi_sense_buf_to_errno to util/scsi.c. [Paolo]
>     Shorten the comment notes on SCSI constants.
> 
> v3: Enhance and reuse iscsi sense data translation. [Paolo]
> 
> First refactor and enhance the code in iscsi for sense data translation, then
> modify error handing of scsi-block and expose the qdev properties.
> 
> Fam Zheng (4):
>   scsi: Refactor scsi sense interpreting code
>   scsi: Improve scsi_sense_to_errno
>   scsi: Introduce scsi_sense_buf_to_errno
>   scsi-block: Support rerror/werror

Looks good, thanks!

Paolo
