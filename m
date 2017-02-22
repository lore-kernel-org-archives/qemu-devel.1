Received: from eggs.gnu.org ([2001:4830:134:3::10]:60702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbwA-0004VN-BD
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cgbw7-0000My-98
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:46:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cgbw7-0000MZ-3L
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 13:46:47 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 201824DB81
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 18:46:47 +0000 (UTC)
Received: from localhost (ovpn-116-33.gru2.redhat.com [10.97.116.33])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1MIkkJC019580
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 13:46:46 -0500
Date: Wed, 22 Feb 2017 15:46:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170222184644.GD28403@thinpad.lan.raisama.net>
References: <20170116211124.29245-1-ehabkost@redhat.com>
	<20170116211124.29245-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170116211124.29245-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] target-i386: Reorganize and
 document CPUID initialization steps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Mon, Jan 16, 2017 at 07:11:21PM -0200, Eduardo Habkost wrote:
> CPU runnability checks and CPU model expansion have slightly
> different requirements. Document the steps involved in loading a
> CPU model and realizing a CPU, so their requirements and purpose
> are clearly defined.
> 
> This patch doesn't change any implementation. It just add
> comments, rename the x86_cpu_load_features() function for clarity
> (so it won't be confused with x86_cpu_load_def()), and move
> x86_cpu_filter_features() closer to it.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Applied to x86-next.

-- 
Eduardo
