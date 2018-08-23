Received: from eggs.gnu.org ([2001:4830:134:3::10]:41530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fst3R-000391-Pj
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fst3R-0003Xc-3W
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:05:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41830 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fst3Q-0003X3-SZ
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:05:52 -0400
References: <20180823164025.12553-1-armbru@redhat.com>
	<20180823164025.12553-7-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a635a1a4-e645-46d9-f028-4fab27fe9f9a@redhat.com>
Date: Thu, 23 Aug 2018 12:05:48 -0500
MIME-Version: 1.0
In-Reply-To: <20180823164025.12553-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/58] qmp-test: Cover syntax and
 lexical errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/23/2018 11:39 AM, Markus Armbruster wrote:
> qmp-test neglects to cover QMP input that isn't valid JSON.  libqtest
> doesn't let us such input.  Add qtest_qmp_send_raw() for this purpose,

s/us/us send/

> and put it to use in qmp-test.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>   tests/libqtest.c | 17 +++++++++++++++++
>   tests/libqtest.h | 11 +++++++++++
>   tests/qmp-test.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 68 insertions(+), 1 deletion(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
