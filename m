Received: from eggs.gnu.org ([2001:4830:134:3::10]:49012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhcw-00057K-QY
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhct-0000CE-HB
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:29:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqhcs-0000BD-Uc
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:29:27 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-22-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1c6061d7-e9e5-9b10-c096-a70b1d5a7c8f@redhat.com>
Date: Fri, 17 Aug 2018 11:29:22 -0500
MIME-Version: 1.0
In-Reply-To: <20180817150559.16243-22-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 21/60] json: Reject invalid UTF-8
 sequences
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

On 08/17/2018 10:05 AM, Markus Armbruster wrote:
> We reject bytes that can't occur in valid UTF-8 (\xC0..\xC1,
> \xF5..\xFF in the lexer.  That's insufficient; there's plenty of
> invalid UTF-8 not containing these bytes, as demonstrated by
> check-qjson:
> 
> * Malformed sequences
> 
>    - Unexpected continuation bytes
> 
>    - Missing continuation bytes after start bytes other than
>      \xC0..\xC1, \xF5..\xFD.
> 
> * Overlong sequences with start bytes other than \xC0..\xC1,
>    \xF5..\xFD.
> 
> * Invalid code points
> 
> Fixing this in the lexer would be bothersome.  Fixing it in the parser
> is straightforward, so do that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
