Received: from eggs.gnu.org ([2001:4830:134:3::10]:59365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPeT-0002dH-0r
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPeO-0006JV-IA
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:42:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53606 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsPeN-0006Im-MP
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:42:04 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1533128420-2745-1-git-send-email-liq3ea@gmail.com> (Li Qiang's
	message of "Wed, 1 Aug 2018 06:00:20 -0700")
References: <1533128420-2745-1-git-send-email-liq3ea@gmail.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Aug 2018 11:41:55 +0200
Message-ID: <8760027n6k.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migrate/cpu-throttle: Add max-cpu-throttle
 migration parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: dgilbert@redhat.com, eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, liqiang02@corp.netease.com, hzliuyingdong@corp.netease.com

Li Qiang <liq3ea@gmail.com> wrote:
> Currently, the default maximum CPU throttle for migration is
> 99(CPU_THROTTLE_PCT_MAX). This is too big and can make a remarkable
> performance effect for the guest. We see a lot of packets latency
> exceed 500ms when the CPU_THROTTLE_PCT_MAX reached. This patch set
> adds a new max-cpu-throttle parameter to limit the CPU throttle.
>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
