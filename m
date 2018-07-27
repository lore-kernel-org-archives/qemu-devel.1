Received: from eggs.gnu.org ([2001:4830:134:3::10]:60937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fj5iF-0000pn-9p
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fj5iC-0003TM-6k
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:35:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54540 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fj5iB-0003S9-Os
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:35:28 -0400
Reply-To: thuth@redhat.com
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-3-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0c447787-8cac-8ae7-c191-a2c3688c73bb@redhat.com>
Date: Fri, 27 Jul 2018 18:35:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/23] libqtest: Rename functions to
 send QMP messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org, eblake@redhat.com

On 07/27/2018 05:13 PM, Markus Armbruster wrote:
> [...] Rename qmp_fd_sendv() to qmp_fd_vsend().

Why? I think it's also quite common to have the "v" at the end, e.g.
object_new_with_propv, gdb_do_syscallv, qobject_from_jsonv, etc.

 Thomas
