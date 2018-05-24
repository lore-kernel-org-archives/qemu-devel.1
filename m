Received: from eggs.gnu.org ([2001:4830:134:3::10]:56656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLsfA-0004TC-5g
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLsf7-00043Z-44
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:00:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fLsf6-00042o-Tx
	for qemu-devel@nongnu.org; Thu, 24 May 2018 12:00:20 -0400
References: <1527176250-178968-1-git-send-email-mst@redhat.com>
	<d0edcb79-3dae-c3a5-f9f4-50b3062f8cff@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <70262dde-3b96-b650-f0fb-8143e869c4ab@redhat.com>
Date: Thu, 24 May 2018 11:00:19 -0500
MIME-Version: 1.0
In-Reply-To: <d0edcb79-3dae-c3a5-f9f4-50b3062f8cff@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/1] libqtest: add more exit status
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>

On 05/24/2018 10:52 AM, Eric Blake wrote:

> Also, since waitpid() can only return either s->qemu_pid or -1 as we 
> aren't using WNOHANG, it may also be worth asserting that if pid == -1, 
> we either have EAGAIN (but why aren't we looping in that case?) or ECHILD.

I meant EINTR, not EAGAIN.  But in general, using waitpid() to collect 
process status without doing it in a loop is risky.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
