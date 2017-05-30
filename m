Received: from eggs.gnu.org ([2001:4830:134:3::10]:52556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFe9V-0005Cl-BE
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFe9S-0002Fs-6w
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:13:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFe9S-0002FU-10
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:13:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B069C83E
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 10:13:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495649128-10529-8-git-send-email-vyasevic@redhat.com>
	(Vladislav Yasevich's message of "Wed, 24 May 2017 14:05:23 -0400")
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
	<1495649128-10529-8-git-send-email-vyasevic@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 12:13:14 +0200
Message-ID: <877f0yhcud.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 07/12] migration: Allow for a limited
 number of announce timers
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
> We currently create a new announcement timer every time
> qemu_announce_self() is called.  Since this is now a qmp
> command, this can lead to abuse.   Limit the number of
> timers that are created.  Give QMP interface and migration
> process 1 timer each.  This way, QMP can't abuse the
> announce_self mechanism.
>
> Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
