Received: from eggs.gnu.org ([2001:4830:134:3::10]:59985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiHQ-0004xN-BC
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eBiHM-00069Q-GT
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:21:36 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:52435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eBiHM-00068v-99
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 09:21:32 -0500
Received: by mail-wr0-f182.google.com with SMTP id j23so4563860wra.9
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 06:21:32 -0800 (PST)
References: <20170929111323.6308-1-michael@fritscher.net>
	<20170929111323.6308-13-michael@fritscher.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5462291d-5a79-d613-dddc-01822b3db5fa@redhat.com>
Date: Mon, 6 Nov 2017 15:21:27 +0100
MIME-Version: 1.0
In-Reply-To: <20170929111323.6308-13-michael@fritscher.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/18] Buildfix in 9p-util.c.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>, gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org

On 29/09/2017 13:13, Michael Fritscher wrote:
> +#ifndef _WIN32
>  #include "qemu/xattr.h"
> +#endif

This #ifndef should be in include/qemu/xattr.h itself.

Paolo
