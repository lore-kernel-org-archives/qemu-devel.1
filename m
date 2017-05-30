Received: from eggs.gnu.org ([2001:4830:134:3::10]:53023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFeBK-0006G2-Bo
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFeBH-0002ye-6s
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:15:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFeBH-0002xo-1K
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:15:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22C953680A
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 10:15:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495649128-10529-9-git-send-email-vyasevic@redhat.com>
	(Vladislav Yasevich's message of "Wed, 24 May 2017 14:05:24 -0400")
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-9-git-send-email-vyasevic@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 12:15:06 +0200
Message-ID: <8737bmhcr9.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 08/12] announce_timer: Add ability to reset
 an existing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladislav Yasevich <vyasevic@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com

Vladislav Yasevich <vyasevic@redhat.com> wrote:
> It is now potentially possible to issue annouce-self command in a tight
> loop.  Instead of doing nother, we can reset the timeout pararameters,

nother?

>  static void qemu_announce_self_once(void *opaque)
>  {
>      AnnounceTimer *timer = (AnnounceTimer *)opaque;
>  
> +    qemu_mutex_lock(&timer->active_lock);
>      qemu_foreach_nic(qemu_announce_self_iter, NULL);
>  
> -    if (--timer->round) {
> +    if (--timer->round ) {

extra space
