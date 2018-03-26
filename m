Received: from eggs.gnu.org ([2001:4830:134:3::10]:36326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0VW0-0006m8-HV
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 13:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0VVx-0000q4-Cp
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 13:02:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0VVx-0000pb-7z
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 13:02:33 -0400
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
	<1520342370-123606-26-git-send-email-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <125dab73-beeb-afcd-f180-9239473ef4cd@redhat.com>
Date: Mon, 26 Mar 2018 12:02:24 -0500
MIME-Version: 1.0
In-Reply-To: <1520342370-123606-26-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 25/34] Fixing WHPX casing to match SDK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Justin Terry (VM)" <juterry@microsoft.com>

On 03/06/2018 07:19 AM, Paolo Bonzini wrote:
> From: "Justin Terry (VM) via Qemu-devel" <qemu-devel@nongnu.org>
> 
> Fixes an issue where the SDK that was releases had a different casing for the
> *.h and *.lib files causing a build break if linked directly from Windows Kits.
> 
> Signed-off-by: Justin Terry (VM) <juterry@microsoft.com>
> Message-Id: <1519665216-1078-2-git-send-email-juterry@microsoft.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Justin Terry (VM) via Qemu-devel <qemu-devel@nongnu.org>

Paolo, just noticing this now based on another thread; but when you are 
dealing with patches where mailman did an SPF header rewrite, it looks 
like your workflow is taking the author's From: out of the headers and 
turning it into an unusual Signed-off-by with the wrong email address.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
