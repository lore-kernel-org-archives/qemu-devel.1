Received: from eggs.gnu.org ([2001:4830:134:3::10]:53759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Yhw-00085C-0l
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:27:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Yhs-0005YP-RG
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:27:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0Yhs-0005Xw-MB
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 16:27:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7D8C406F890
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 20:27:01 +0000 (UTC)
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-7-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <59d64618-ac9b-b8d8-8369-efe08799f828@redhat.com>
Date: Mon, 26 Mar 2018 15:26:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180326063901.27425-7-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 6/8] tests: add oob-test for
 qapi-schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/26/2018 01:38 AM, Peter Xu wrote:
> It simply tests the new OOB capability, and make sure the QAPISchema can
> parse it correctly.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tests/Makefile.include                  | 1 +
>   tests/qapi-schema/oob-test.err          | 1 +
>   tests/qapi-schema/oob-test.exit         | 1 +
>   tests/qapi-schema/oob-test.json         | 2 ++
>   tests/qapi-schema/oob-test.out          | 0
>   tests/qapi-schema/qapi-schema-test.json | 3 +++
>   tests/qapi-schema/qapi-schema-test.out  | 2 ++
>   tests/test-qmp-cmds.c                   | 4 ++++
>   8 files changed, 14 insertions(+)
>   create mode 100644 tests/qapi-schema/oob-test.err
>   create mode 100644 tests/qapi-schema/oob-test.exit
>   create mode 100644 tests/qapi-schema/oob-test.json
>   create mode 100644 tests/qapi-schema/oob-test.out

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
