Received: from eggs.gnu.org ([2001:4830:134:3::10]:33711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evmkY-0008Pm-Lt
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evmkT-0007u0-1d
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:26:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evmkS-0007te-TK
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:26:00 -0400
References: <20180313044944.21058-1-aik@ozlabs.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <be36e0ce-0494-d023-7346-761753456b6c@redhat.com>
Date: Tue, 13 Mar 2018 11:25:59 -0500
MIME-Version: 1.0
In-Reply-To: <20180313044944.21058-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v2] slirp/debug: Print IP addresses in
 human readable form
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

On 03/12/2018 11:49 PM, Alexey Kardashevskiy wrote:
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> checkpatch.pl complains on every single changed line as it keeps
> using tabs - do I need to post 's/\t/    /g'?

No. checkpatch.pl is guidance, but even stronger is 'be consistent to 
what you are editing'; we know to ignore the checkpatch warnings on 
slirp code as that has historically used tabs.  Mixed style, where TABS 
occur in the context but your new additions use space, is also okay. 
(You CAN clean up the entire slirp files if you want, but get maintainer 
buy-in before doing so; and make the indentation cleanup separate from 
any other patch, so that a diff with whitespace ignored shows no change).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
