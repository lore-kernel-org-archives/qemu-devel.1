Received: from eggs.gnu.org ([2001:4830:134:3::10]:38237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fG1bP-0000nB-LV
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fG1bL-0004Hi-QD
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:20:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fG1bL-0004GN-Mc
	for qemu-devel@nongnu.org; Tue, 08 May 2018 08:20:15 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1525376963-79623-21-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 3 May 2018 22:50:58 +0300")
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-21-git-send-email-mst@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 08 May 2018 14:22:31 +0200
Message-ID: <87sh728hh4.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 20/67] tests: relative include for child
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

"Michael S. Tsirkin" <mst@redhat.com> wrote:
> When pulling in headers that are in the child directory of the C file
> (as opposed to one in include/), we should use its relative path, with
> name of the child directory. Full path including the current directory
> works more or less by accident.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
