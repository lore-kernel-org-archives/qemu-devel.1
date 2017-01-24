Received: from eggs.gnu.org ([2001:4830:134:3::10]:48618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cW1K1-0001oT-IX
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cW1Jx-0004YU-G0
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:39:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cW1Jx-0004XS-AN
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 08:39:37 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39C55C0567B3
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 13:39:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20161212125838.14425-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 12 Dec 2016 12:58:38 +0000")
References: <20161212125838.14425-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Jan 2017 14:39:32 +0100
Message-ID: <87r33s8tm3.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [for 2.9] migration/tracing: Add tracing on save
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Add some tracing to vmstate_subsection_save and vmstate_save_state
> to help in debugging when you're not sure if a conditional piece
> of data is being saved.
>
> In vmstate_subsection_save I renamed the inner vmsd to avoid the aliasing
> and be able to print both names.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
