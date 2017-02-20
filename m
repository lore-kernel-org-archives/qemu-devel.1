Received: from eggs.gnu.org ([2001:4830:134:3::10]:39212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cfpyA-0003w0-BT
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:33:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cfpy7-0002X7-8B
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:33:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cfpy7-0002Wz-2j
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:33:39 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3580DC04B956
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 15:33:39 +0000 (UTC)
Received: from [10.36.116.69] (ovpn-116-69.ams2.redhat.com [10.36.116.69])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1KFXa25021072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 10:33:38 -0500
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
	<20170220141943.8426-2-cornelia.huck@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <967f7397-9995-0d24-bf35-682da2c732ff@redhat.com>
Date: Mon, 20 Feb 2017 16:33:36 +0100
MIME-Version: 1.0
In-Reply-To: <20170220141943.8426-2-cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] elf-loader: Allow late loading of elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 20.02.2017 15:19, Cornelia Huck wrote:
> From: Farhan Ali <alifm@linux.vnet.ibm.com>
> 
> The current QEMU ROM infrastructure rejects late loading of ROMs.
> And ELFs are currently loaded as ROM, this prevents delayed loading
> of ELFs. So when loading ELF, allow the user to specify if ELF should
> be loaded as ROM or not.
> 
> If an ELF is not loaded as ROM, then they are not restored on a
> guest reboot/reset and so its upto the user to handle the reloading.

Could you maybe also explain here why you need such a delayed ELF
loading? Why can't you load the s390-netboot.img at the same time as
s390-ccw.img?

 Thomas
