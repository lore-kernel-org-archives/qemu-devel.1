Received: from eggs.gnu.org ([2001:4830:134:3::10]:45526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4fB-0002Hd-L4
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4fA-0004Iq-Sb
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:28:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57056 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj4fA-0004I9-M4
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:28:16 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <591017a8-f317-eb83-f67f-a1a81f6ece56@redhat.com>
Date: Fri, 27 Jul 2018 10:28:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/23] qobject: Replace
 qobject_from_jsonf() by qobject_from_jsonf_nofail()
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
> Commit ab45015a968 "qobject: Let qobject_from_jsonf() fail instead of
> abort" fails to accomplish its stated aim: the function can still
> abort due to its use of &error_abort.
> 
> Its rationale for letting it fail is that all remaining users cope
> fine with failure.  Well, they're just fine with aborting, too; it's
> what they do on failure.
> 
> Simply reverting the broken commit would bring back the unfortunate
> asymmetry between qobject_from_jsonf() and qobject_from_jsonv(): one
> aborts, the other returns null.  So also rename it to
> qobject_from_jsonf_nofail().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
