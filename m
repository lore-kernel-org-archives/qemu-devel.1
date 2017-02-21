Received: from eggs.gnu.org ([2001:4830:134:3::10]:48535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cg7tN-0007I5-GT
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cg7tK-0002eU-AW
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:41:57 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cg7tK-0002eM-3i
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:41:54 -0500
Received: by mail-wr0-x244.google.com with SMTP id z61so13957263wrc.3
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 02:41:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487614915-18710-1-git-send-email-den@openvz.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <102dabf5-8b4a-1ccc-1e33-d01f4085dee4@redhat.com>
Date: Tue, 21 Feb 2017 11:41:52 +0100
MIME-Version: 1.0
In-Reply-To: <1487614915-18710-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.9 0/3] guest panic information
 follow-up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>



On 20/02/2017 19:21, Denis V. Lunev wrote:
> This is a set of followup patches requested by Eric Blake.
> 
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> 
> Anton Nefedov (3):
>   i386/cpu: release GuestPanicInformation memory
>   qapi: flatten GuestPanicInformation union
>   qmp-events: fix GUEST_PANICKED description formatting
> 
>  kvm-all.c         |  5 ++++-
>  qapi-schema.json  | 12 ++++++++++++
>  qapi/event.json   |  4 ++--
>  target/i386/cpu.c | 15 ++++++---------
>  vl.c              | 22 +++++++++-------------
>  5 files changed, 33 insertions(+), 25 deletions(-)
> 

I am queuing patches 2 and 3.  For patch 1, I've just sent an
alternative idea.

Paolo
