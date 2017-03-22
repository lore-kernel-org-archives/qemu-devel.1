Received: from eggs.gnu.org ([2001:4830:134:3::10]:54644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cqlh4-0006GK-Rd
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cqlh1-0005Bu-PY
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:13:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cqlh1-0005Bj-JK
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:13:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A83AE3DBE6
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 19:13:10 +0000 (UTC)
Date: Wed, 22 Mar 2017 16:13:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170322191305.GO2811@thinpad.lan.raisama.net>
References: <20170322160052.2820-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170322160052.2820-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] script for crash-testing -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Wed, Mar 22, 2017 at 01:00:49PM -0300, Eduardo Habkost wrote:
> This series adds scripts/device-crashtest.py, that can be used to
> crash-test -device with multiple machine/accel/device
> combinations.
> 
> The script found a few crashes on some machines/devices. A dump
> of existing cases can be seen here:
>   https://gist.github.com/ehabkost/503b0af0375f0d98d3e84017e8ca54eb
> 
> The script contains a whitelist that can also be useful as
> documentation of existing ways -device can fail or crash.
> 
> Note that the script takes a few hours to run on the default mode
> (testing all accel/machine/device combinations), but the "-r N"
> option can be used to make it only test N random samples.

Something I forgot to mention: I would like to run some subset of
these tests on "make check", but I don't know how we could choose
that subset. We could run, e.g., 100 random samples, but I am not
sure we really want to make "make check" non-deterministic.

Ideas?

-- 
Eduardo
