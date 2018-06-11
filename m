Received: from eggs.gnu.org ([2001:4830:134:3::10]:51548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSHj4-0004re-PX
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSHiz-00072D-Vk
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:58:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSHiz-000724-RH
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:58:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180604080630.10946-1-peterx@redhat.com>
	<87tvqeyfs2.fsf@dusky.pond.sub.org> <20180608044235.GA7736@xz-mi>
	<20180608080446.GH29183@stefanha-x1.localdomain>
	<87a7s5snce.fsf@dusky.pond.sub.org> <20180608091154.GF7736@xz-mi>
	<20180608092457.GG7736@xz-mi>
Date: Mon, 11 Jun 2018 09:58:37 +0200
In-Reply-To: <20180608092457.GG7736@xz-mi> (Peter Xu's message of "Fri, 8 Jun
	2018 17:24:57 +0800")
Message-ID: <87po0xlpoy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] monitor: postpone
 monitor_qmp_cleanup_queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?M?= =?utf-8?Q?arc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Fri, Jun 08, 2018 at 05:11:54PM +0800, Peter Xu wrote:
[...]
> So I think I agree with Markus's solution, we just flush the response
> queue when we get CLOSED (but we don't close the output fd; IMHO
> that's chardev backend's job).  Would that work?

I figure you're right on close() being the chardev backend's job.
