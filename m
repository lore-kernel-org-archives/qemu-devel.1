Received: from eggs.gnu.org ([2001:4830:134:3::10]:47572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dufKy-0002yx-P1
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dufKv-0001iq-1h
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:46:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dufKu-0001i8-SA
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:46:44 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1505839684-10046-3-git-send-email-a.perevalov@samsung.com>
	(Alexey Perevalov's message of "Tue, 19 Sep 2017 19:47:56 +0300")
References: <1505839684-10046-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170919164821eucas1p2c3d141e6ae576901e95212d1136b0453@eucas1p2.samsung.com>
	<1505839684-10046-3-git-send-email-a.perevalov@samsung.com>
Reply-To: quintela@redhat.com
Date: Wed, 20 Sep 2017 11:01:29 +0200
Message-ID: <87wp4tkal2.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 02/10] migration: pass
 MigrationIncomingState* into migration check functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, peterx@redhat.com, eblake@redhat.com, dgilbert@redhat.com, heetae82.ahn@samsung.com

Alexey Perevalov <a.perevalov@samsung.com> wrote:
> That tiny refactoring is necessary to be able to set
> UFFD_FEATURE_THREAD_ID while requesting features, and then
> to create downtime context in case when kernel supports it.
>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
