Received: from eggs.gnu.org ([2001:4830:134:3::10]:34717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1camTs-0002JQ-N5
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1camTp-0004nf-Nr
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:49:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1camTp-0004nI-Hx
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:49:29 -0500
References: <20170204100317.32425-1-rjones@redhat.com>
	<20170204100317.32425-2-rjones@redhat.com>
	<ec715a97-ad0e-b8e9-3db7-0bd50a1b7060@redhat.com>
	<20170206162924.GF15182@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc78d81f-be34-29df-169c-3e26b3f6dc51@redhat.com>
Date: Mon, 6 Feb 2017 17:49:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170206162924.GF15182@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, den@openvz.org, rkagan@virtuozzo.com, dplotnikov@virtuozzo.com, berrange@redhat.com, stefanha@gmail.com, armbru@redhat.com



On 06/02/2017 17:29, Richard W.M. Jones wrote:
> On Mon, Feb 06, 2017 at 05:10:13PM +0100, Paolo Bonzini wrote:
>> Queued, thanks.
> 
> Could you change this comment s/!_WIN32/_WIN32/, or do you
> want me to submit another patch?
> 
>>> +#else /* !_WIN32 */
>>> +static unsigned int check_socket_activation(void)
>>> +{
>>> +    return 0;
>>> +}
>>> +#endif
>>> +
> 
> Rich.
> 

Will do, and use CONFIG_WIN32 while at it.

Paolo
