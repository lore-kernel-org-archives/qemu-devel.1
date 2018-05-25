Received: from eggs.gnu.org ([2001:4830:134:3::10]:50559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fMHO1-0000O0-6F
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fMHO0-0004A6-DI
	for qemu-devel@nongnu.org; Fri, 25 May 2018 14:24:21 -0400
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-16-git-send-email-mst@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <df745a8b-a48b-3e9a-f44f-ebff27111847@redhat.com>
Date: Fri, 25 May 2018 13:24:08 -0500
MIME-Version: 1.0
In-Reply-To: <1527266793-301361-16-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

On 05/25/2018 11:48 AM, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as

s/as C/as the C/ (here and in many other messages)

> opposed to one in include/), we should use its relative path, without a
> directory. Directory based path works more or less by accident.

Missed trimming this out of your commit message.

Or, if you want, on many of these commits, you could be more explicit 
about intention:

When pulling in headers that are in the same directory as the C file (as 
opposed to one in include/), we prefer to use its relative path without 
a directory, rather than relying on the global -I$(SRC_DIR) that may be 
removed in a later patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
