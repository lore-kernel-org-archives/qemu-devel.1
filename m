Received: from eggs.gnu.org ([2001:4830:134:3::10]:34691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fewov-0001gn-NP
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 02:17:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fewoq-0000jc-Nz
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 02:17:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fewoq-0000jM-If
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 02:17:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39CC741C31
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 06:17:12 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-6-armbru@redhat.com>
	<6e2dbaa9-8b12-581c-059a-3e1e86300202@redhat.com>
Date: Mon, 16 Jul 2018 08:17:11 +0200
In-Reply-To: <6e2dbaa9-8b12-581c-059a-3e1e86300202@redhat.com> (Thomas Huth's
	message of "Thu, 12 Jul 2018 20:17:05 +0200")
Message-ID: <871sc3k8m0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 05/20] qobject: Replace
 qobject_from_jsonf() by qobject_from_jsonf_nofail()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> On 12.07.2018 13:12, Markus Armbruster wrote:
>> Commit ab45015a968 "qobject: Let qobject_from_jsonf() fail instead of
>> abort" removed only one of two ways qobject_from_jsonf() can abort.
>> Wrong.
>
> Wrong because it calls qobject_from_jsonv() with error_abort. Maybe
> mentioned that in the patch description - since it took me a while to
> understand what you mean here.

Can do.

> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks!
