Received: from eggs.gnu.org ([2001:4830:134:3::10]:44663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1elZQN-0003cM-S9
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1elZQK-0004kv-Hs
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:11:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1elZQK-0004kp-D8
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:11:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11A394040855
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 12:11:00 +0000 (UTC)
Date: Tue, 13 Feb 2018 13:10:59 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180213121059.p4sjrtwxlna6qqmh@sirius.home.kraxel.org>
References: <20180212222705.12718-1-bsd@redhat.com>
	<20180212222705.12718-5-bsd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212222705.12718-5-bsd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] usb-mtp: Introduce write support
 for MTP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: qemu-devel@nongnu.org

> @@ -66,7 +67,9 @@ enum mtp_code {
>      RES_STORE_READ_ONLY            = 0x200e,
>      RES_PARTIAL_DELETE             = 0x2012,
>      RES_SPEC_BY_FORMAT_UNSUPPORTED = 0x2014,
> +    RES_INVALID_OBJECTINFO         = 0x2015,
>      RES_INVALID_PARENT_OBJECT      = 0x201a,
> +    RES_STORE_FULL                 = 0x200c,

This is the wrong place or the wrong error code ...

cheers,
  Gerd
