Received: from eggs.gnu.org ([2001:4830:134:3::10]:52034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFe7J-0003NN-EU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFe7G-0001QC-AQ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:11:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFe7G-0001Py-3y
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:11:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1686E61B86
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 10:11:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495649128-10529-4-git-send-email-vyasevic@redhat.com>
	(Vladislav Yasevich's message of "Wed, 24 May 2017 14:05:19 -0400")
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-4-git-send-email-vyasevic@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 12:10:58 +0200
Message-ID: <87d1aqhcy5.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 03/12] migration: Switch to using
 announcement timer
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
> Switch qemu_announce_self and virtio annoucements to use
> the announcement timer framework.  This makes sure that both
> timers use the same timeouts and number of annoucement attempts
>
> Based on work by Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>

>  static void qemu_announce_self_once(void *opaque)
>  {
> -    static int count = SELF_ANNOUNCE_ROUNDS;
> -    QEMUTimer *timer = *(QEMUTimer **)opaque;
> +    AnnounceTimer *timer = (AnnounceTimer *)opaque;

Cast from void * is never needed.
