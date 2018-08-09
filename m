Received: from eggs.gnu.org ([2001:4830:134:3::10]:34920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnq5m-0007SR-I2
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnq5i-0002fI-L8
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:55:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnq5i-0002f7-Fs
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:55:22 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-21-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <450781e6-728b-59c4-b393-a0c2fa56a04a@redhat.com>
Date: Thu, 9 Aug 2018 13:55:19 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-21-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/56] check-qjson: Document we expect
 invalid UTF-8 to be rejected
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
> The JSON parser rejects some invalid sequences, but accepts others
> without correcting the problem.
> 
> We should either reject all invalid sequences, or minimize overlong
> sequences and replace all other invalid sequences by a suitable
> replacement character.  A common choice for replacement is U+FFFD.
> 
> I'm going to implement the former.  Update the comments in
> utf8_string() to expect this.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/check-qjson.c | 151 +++++++++++++++++++++-----------------------
>   1 file changed, 71 insertions(+), 80 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
