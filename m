Received: from eggs.gnu.org ([209.51.188.92]:33439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hE97d-0002TO-MG
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hE97T-0005Gn-ES
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:02:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hE97Q-0005Di-Ra
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 05:02:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EB97307AD02
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 09:02:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <b991a4d0e6c4253bc08b2794c6084be55fc72e1d.1554851834.git.crobinso@redhat.com>
	(Cole Robinson's message of "Tue, 9 Apr 2019 19:19:57 -0400")
References: <b991a4d0e6c4253bc08b2794c6084be55fc72e1d.1554851834.git.crobinso@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 10 Apr 2019 11:06:35 +0200
Message-ID: <8736mqz0tg.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: savevm: fix error code with
 migration blockers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

Cole Robinson <crobinso@redhat.com> wrote:
> The only caller that checks the error code is looking for != 0,
> so returning false is incorrect.
>
> Fixes: 5aaac467938 "migration: savevm: consult migration blockers"
>
> Signed-off-by: Cole Robinson <crobinso@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
