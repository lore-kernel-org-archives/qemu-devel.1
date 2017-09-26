Received: from eggs.gnu.org ([2001:4830:134:3::10]:51042)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dwnAD-000326-Bk
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dwnA7-00011L-Kl
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:32:29 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:45538 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dwnA7-00010H-Aw
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:32:23 -0400
References: <1506421015-4737-1-git-send-email-pl@kamp.de>
From: Peter Lieven <pl@kamp.de>
Message-ID: <9b0ceb88-d68e-ca2a-e255-ec0a0951f0fe@kamp.de>
Date: Tue, 26 Sep 2017 12:32:19 +0200
MIME-Version: 1.0
In-Reply-To: <1506421015-4737-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH V2] migration: disable auto-converge during
 bulk block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, famz@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, qemu-stable@nongnu.org

Am 26.09.2017 um 12:16 schrieb Peter Lieven:
> auto-converge and block migration currently do not play well together.
> During block migration the auto-converge logic detects that ram
> migration makes no progress and thus throttles down the vm until
> it nearly stalls completely. Avoid this by disabling the throttling
> logic during the bulk phase of the block migration.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
> V1->V2: add comment why we disable auto-converge during bulk block migration [Stefan]
>
>   migration/block.c | 5 +++++
>   migration/ram.c   | 6 +++++-
>   2 files changed, 10 insertions(+), 1 deletion(-)

Sorry, I missed to include the updated header files. Will send a V3.

Peter
