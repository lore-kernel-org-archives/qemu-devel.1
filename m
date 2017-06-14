Received: from eggs.gnu.org ([2001:4830:134:3::10]:42476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dL6Jg-00034M-V8
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dL6Jd-00052B-O1
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 07:18:28 -0400
From: Thomas Huth <thuth@redhat.com>
References: <1496931482-29914-1-git-send-email-thuth@redhat.com>
Message-ID: <4b0ebafd-46da-3ec9-7a43-c008ba90b32b@redhat.com>
Date: Wed, 14 Jun 2017 13:18:21 +0200
MIME-Version: 1.0
In-Reply-To: <1496931482-29914-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Makefile: Move balloon.o,
 numa.o and bootdevice.o to common-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>, Juan Quintela <quintela@redhat.com>

On 08.06.2017 16:18, Thomas Huth wrote:
> There does not seem to be any target specific code in these files, so
> we can put them into "common-obj" instead of "obj" to compile them only
> once for all targets.

Self-NACK: balloon.c uses kvm_enabled() which in turn depends on
CONFIG_KVM ... and that flag is target-specific, so balloon.o can not be
moved to common-obj right now.

We should poison CONFIG_KVM for common code ... I'll have a look into
that...

 Thomas
