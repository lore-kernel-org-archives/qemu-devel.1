Received: from eggs.gnu.org ([2001:4830:134:3::10]:41388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnlnu-0003sn-Lx
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnlnr-0004Bc-5E
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:20:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51424 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnlnq-0004BN-PG
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:20:38 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-13-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a6dc734e-12cb-bc3d-64fa-76c4e569b438@redhat.com>
Date: Thu, 9 Aug 2018 09:20:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-13-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/56] check-qjson: Simplify utf8_string()
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

On 08/08/2018 07:02 AM, Markus Armbruster wrote:
> The previous commit made utf8_string()'s test_cases[].utf8_in
> superfluous: we can use .json_in instead.  Except for the case testing
> U+0000.  \x00 doesn't work in C strings, so it tests \\u0000 instead.
> But testing \\uXXXX is escaped_string()'s job.  It's covered there.
> Test U+0001 here, and drop .utf8_in.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/check-qjson.c | 53 ++++++++-------------------------------------
>   1 file changed, 9 insertions(+), 44 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
