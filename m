Received: from eggs.gnu.org ([2001:4830:134:3::10]:55926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fNydX-0003F8-Ch
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:47:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fNydT-0008Pb-HP
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:47:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fNydT-0008PR-De
	for qemu-devel@nongnu.org; Wed, 30 May 2018 06:47:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAE9DBB40D
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 10:47:18 +0000 (UTC)
Date: Wed, 30 May 2018 12:47:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180530124717.7b1af597@redhat.com>
In-Reply-To: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 00/11] enable numa configuration before
 machine_init() from QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com

Eduardo,

I've rebased series on top of current master
the only change in several patches was s/2.13/3.0/
otherwise there weren't any other conflicts.
You can find rebased version at

https://github.com/imammedo/qemu.git qmp_preconfig_v9
