Received: from eggs.gnu.org ([2001:4830:134:3::10]:37980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj6Ea-0003Ed-IH
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj6EX-0005EO-An
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:08:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39246 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj6EX-0005De-4a
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:08:53 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-23-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8a69adaa-c842-8db7-b003-67ff82293553@redhat.com>
Date: Fri, 27 Jul 2018 12:08:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-23-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 22/23] libqtest: Replace qtest_startf()
 by qtest_initf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org

On 07/27/2018 10:13 AM, Markus Armbruster wrote:
> qtest_init() creates a new QTestState, and leaves @global_qtest alone.
> qtest_start() additionally assigns it to @global_qtest, but
> qtest_startf() additionall sets assigns NULL to @global_qtest.  This

s/additionall sets/additionally/

> makes no sense.  Replace it by qtest_initf() that works like
> qtest_init(), i.e. leaves @global_qtest alone.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
