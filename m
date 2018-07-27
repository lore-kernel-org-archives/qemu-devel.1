Received: from eggs.gnu.org ([2001:4830:134:3::10]:37438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj6CB-00027Z-RO
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj6C7-0003ft-U8
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:06:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52900 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj6C7-0003fV-NG
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:06:23 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-3-armbru@redhat.com>
	<0c447787-8cac-8ae7-c191-a2c3688c73bb@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c0ca44f0-cc97-e9f2-2ecf-67c43819f2b2@redhat.com>
Date: Fri, 27 Jul 2018 12:06:22 -0500
MIME-Version: 1.0
In-Reply-To: <0c447787-8cac-8ae7-c191-a2c3688c73bb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: thuth@redhat.com, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org

On 07/27/2018 11:35 AM, Thomas Huth wrote:
> On 07/27/2018 05:13 PM, Markus Armbruster wrote:
>> [...] Rename qmp_fd_sendv() to qmp_fd_vsend().
> 
> Why? I think it's also quite common to have the "v" at the end, e.g.
> object_new_with_propv, gdb_do_syscallv, qobject_from_jsonv, etc.

Actually, I think 'printf' vs. 'vprintf' is the model to be following, 
and patch 23/23 brings in even more consistency.  I'm in favor of this 
rename.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
