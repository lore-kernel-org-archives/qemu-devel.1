Received: from eggs.gnu.org ([2001:4830:134:3::10]:42921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdXqq-0001eZ-L4
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdXql-0008AO-Oy
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:48:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cdXql-0008A2-JP
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 02:48:35 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C56FC054904
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 07:48:35 +0000 (UTC)
Date: Tue, 14 Feb 2017 15:48:31 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170214074831.GE6428@lemon.lan>
References: <20170213135235.12274-1-pbonzini@redhat.com>
	<20170213135235.12274-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170213135235.12274-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/18] block: move AioContext, QEMUTimer,
 main-loop to libqemuutil
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Mon, 02/13 14:52, Paolo Bonzini wrote:
> --- /dev/null
> +++ b/util/aiocb.c
> @@ -0,0 +1,55 @@
> +/*
> + * BlockAIOCB allocation
> + *
> + * Copyright (c) 2003-2017 Fabrice Bellard and the QEMU team

Hmm, I'm not lawyer, just wondering if the QEMU team is a legal entity that can
hold copyright? :)

Fam
