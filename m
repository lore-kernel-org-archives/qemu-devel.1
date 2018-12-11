Received: from eggs.gnu.org ([2001:4830:134:3::10]:52784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWoBJ-0008Ju-BA
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gWoBF-0003J9-AF
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:59:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gWoBF-0003Ij-3O
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:58:57 -0500
References: <20181211162846.31149-1-wainersm@redhat.com>
	<b75eb4c9-17dc-9311-d569-d2a8772b2ef3@redhat.com>
	<b9be5998-8914-fce5-bcb7-8ff8780d9dcc@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e4fcb8eb-16b8-6d2d-b135-b539b7c871cf@redhat.com>
Date: Tue, 11 Dec 2018 13:58:50 -0600
MIME-Version: 1.0
In-Reply-To: <b9be5998-8914-fce5-bcb7-8ff8780d9dcc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: Fixes to the check missing
 features routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com, ccarrara@redhat.com

On 12/11/18 1:47 PM, Wainer dos Santos Moschetta wrote:

> 
> Yes, it helped a lot, thanks. And I apologize for my mistake, I'm gonna 
> send a v3 fixing it.

You may want to wait a day or so for any other comments on v2, to 
minimize the resend churn. A maintainer can fix up tags, particularly 
when they are aware it is from a newer contributor still learning how 
things work.

> 
> Another doubt that I have: is it advisable to CC everyone that reviewed 
> (with or without R-by) the previous version of my patch?

CC'ing previous reviewers is generally a reasonable idea, since they are 
then more likely to double-check that the things they pointed out in the 
first version are indeed fixed in the respin (and since without the cc, 
it's a lot easier to miss that a respin is even available on-list for 
followup review, thanks to the list traffic volume).  You might not get 
a reply from everyone cc'd, but that's not fatal to acceptance of the patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
