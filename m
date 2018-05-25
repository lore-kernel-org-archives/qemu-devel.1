Received: from eggs.gnu.org ([2001:4830:134:3::10]:50587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fMHO5-0000Xg-Hy
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fMHO4-0004JD-Lo
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:24:25 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1527266793-301361-16-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Fri, 25 May 2018 19:48:04 +0300")
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-16-git-send-email-mst@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 25 May 2018 20:27:03 +0200
Message-ID: <87vabb1thk.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 15/20] migration: use local path for
 local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

"Michael S. Tsirkin" <mst@redhat.com> wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory. Directory based path works more or less by accident.

I don't agree with the comment that they work by accident, it is
"by-design".  But if you want to change the design, I agree with
removing "$ROOT" from the default include path.

>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Later, Juan.
