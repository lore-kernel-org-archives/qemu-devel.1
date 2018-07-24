Received: from eggs.gnu.org ([2001:4830:134:3::10]:58591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fhxNa-0003tp-5Z
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fhxNW-00059q-5L
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:29:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fhxNW-00059g-0e
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:29:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D0134B8C7
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 13:29:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180724102215.31866-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Tue, 24 Jul 2018 11:22:15 +0100")
References: <20180724102215.31866-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Jul 2018 15:29:18 +0200
Message-ID: <87tvoog3td.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] audio/hda: Fix migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, berrange@redhat.com, marcandre.lureau@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Fix outgoing migration which was crashing in
> vmstate_hda_audio_stream_buf_needed, I think the problem
> is that we have room for upto 4 streams in the array but only
> use 2, when we come to try and save the state of the unused
> streams we hit st->state == NULL.
>
> Fixes: 280c1e1cdb24d80ecdfc
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
