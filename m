Received: from eggs.gnu.org ([2001:4830:134:3::10]:32813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faNHp-0007aG-B9
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faNHm-0000Tf-67
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:32:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faNHl-0000SE-Vg
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:32:10 -0400
References: <20180703085358.13941-1-armbru@redhat.com>
	<20180703085358.13941-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d57bed39-f4b8-adda-b763-ef286bba6c9d@redhat.com>
Date: Tue, 3 Jul 2018 10:31:51 -0500
MIME-Version: 1.0
In-Reply-To: <20180703085358.13941-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 03/32] docs/interop/qmp: Improve OOB
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

On 07/03/2018 03:53 AM, Markus Armbruster wrote:
> OOB documentation is spread over qmp-spec.txt sections 2.2.1
> Capabilities and 2.3 Issuing Commands.  The amount of detail is a bit
> distracting there.  Move the meat of the matter to new section 2.3.1
> Out of band execution.
> 
> Throw in a few other improvements while there:
> 
> * 2.2 Server Greeting: Drop advice to search entire capabilities
>    array; should be obvious.
> 
> * 3. QMP Examples
> 
>    - 3.1 Server Greeting: Update greeting to the one we expect for the
>      release.  Now shows capability "oob".  Update qmp-intro.txt
>      likewise.
> 
>    - 3.2 Capabilities negotiation: Show client accepting capability
>      "oob".
> 
>    - 3.7 Out-of-band execution: New.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---

> +++ b/docs/interop/qmp-intro.txt
> @@ -52,13 +52,14 @@ Escape character is '^]'.
>       "QMP": {
>           "version": {
>               "qemu": {
> -                "micro": 50,
> -                "minor": 6,
> -                "major": 1
> -            },
> -            "package": ""
> -        },
> +                "micro": 0,
> +                "minor": 0 ,

Extra space.

> +                "major": 3
> +            },
> +            "package": "v3.0.0"
> +        },
>           "capabilities": [
> +            "oob"
>           ]
>       }
>   }
R-b stands.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
