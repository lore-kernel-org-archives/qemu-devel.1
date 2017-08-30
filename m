Received: from eggs.gnu.org ([2001:4830:134:3::10]:33428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1dn044-0002wv-GJ
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@posteo.de>) id 1dn03z-0001HW-Il
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:17:40 -0400
Received: from mout02.posteo.de ([185.67.36.66]:39455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <th.huth@posteo.de>) id 1dn03z-0001Ep-BM
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 06:17:35 -0400
Received: from submission (posteo.de [89.146.220.130])
	by mout02.posteo.de (Postfix) with ESMTPS id 5F9F220E54
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 12:17:24 +0200 (CEST)
References: <1915302638.2814146.1504030043465.ref@mail.yahoo.com>
	<1915302638.2814146.1504030043465@mail.yahoo.com>
	<14033890-2a35-666c-2fa7-5a8727090801@tuxfamily.org>
	<1075529669.195794.1504079702032@mail.yahoo.com>
	<bc7bacd9-fec7-c193-6de0-99d1f7fd0f6f@tuxfamily.org>
	<2061420835.208824.1504085337258@mail.yahoo.com>
	<20170830121109.7fab5559@bahia>
From: Thomas Huth <th.huth@posteo.de>
Message-ID: <61cd0715-27e4-7e50-1e85-9da3b4a48bb1@posteo.de>
Date: Wed, 30 Aug 2017 12:17:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170830121109.7fab5559@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-discuss] Accessing a shared folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Mahmood <nt_mahmood@yahoo.com>
Cc: Thomas Huth <huth@tuxfamily.org>, "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On 30.08.2017 12:11, Greg Kurz wrote:
[...]
> Hi,
> 
> Both -virtfs and -fsdev/-device syntaxes work for me with the current QEMU
> master branch :) Where's your qemu-system-x86_64 binary coming from ?

There is at least one problem with -virtfs if you forget to specify
the "security_model=xxx" option:

$ x86_64-softmmu/qemu-system-x86_64 -virtfs local,id=shared,path=/tmp,mount_tag=tag
qemu-system-x86_64: util/qemu-option.c:547: opt_set: Assertion `opt->str' failed.
Aborted (core dumped)

According to the qemu-doc, the securit_model is optional, so it
should be possible to run qemu without it, too, shouldn't it?

 Thomas
