Received: from eggs.gnu.org ([2001:4830:134:3::10]:58579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cbpe6-0008Me-AA
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cbpe2-0004Lj-An
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 09:24:26 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170126101827.22378-11-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-11-berrange@redhat.com>
Date: Thu, 09 Feb 2017 15:24:19 +0100
Message-ID: <w51fujn8mss.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 10/18] qcow2: make
 qcow2_encrypt_sectors encrypt in place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu 26 Jan 2017 11:18:19 AM CET, Daniel P. Berrange wrote:
> Instead of requiring separate input/output buffers for
> encrypting data, change qcow2_encrypt_sectors() to assume
> use of a single buffer, encrypting in place. The current
> callers all used the same buffer for input/output already.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
