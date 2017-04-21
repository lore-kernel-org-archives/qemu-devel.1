Received: from eggs.gnu.org ([2001:4830:134:3::10]:57582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1mk9-0003YV-LY
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 00:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d1mk4-0007Yy-QZ
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 00:33:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d1mk4-0007Yq-KL
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 00:33:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67F9BAC07A
	for <qemu-devel@nongnu.org>; Sat, 22 Apr 2017 03:54:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170421122710.15373-1-famz@redhat.com>
Date: Fri, 21 Apr 2017 16:57:23 +0200
In-Reply-To: <20170421122710.15373-1-famz@redhat.com> (Fam Zheng's message of
	"Fri, 21 Apr 2017 20:26:56 +0800")
Message-ID: <87o9vpyfjg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/14] Trivial cleanups around error
 reporting
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

Fam Zheng <famz@redhat.com> writes:

> These are patches to:
>
> 1) reorder the function parameters so that Error **errp comes
> last.
>
> Error pointer in the middle of a function parameter list is very uncommon, and
> does caused mistakes, thus is not a good style. Change to the usual way.
>
> 2) apply the error_propagate_null.cocci semantics patch again.

Thanks for taking on this grunt work.  Can take it through my tree.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
