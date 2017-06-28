Received: from eggs.gnu.org ([2001:4830:134:3::10]:44130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQ8x7-0005vp-0K
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dQ8wz-0004C4-BV
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:07:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dQ8wz-0004Av-5u
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 05:07:53 -0400
Date: Wed, 28 Jun 2017 10:07:46 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170628090746.GF29134@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <cover.1498596157.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1498596157.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [RFC v1 0/3]  Implement a warning_report function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, alistair23@gmail.com

On Tue, Jun 27, 2017 at 01:45:41PM -0700, Alistair Francis wrote:
> QEMU currently has a standard method to report errors with
> error_repot(). This ensure a sane and standard format when printing
> errors. This series is attempting to add the same functionality for
> warnings.

I'm not seeing the obvious benefit in this change. Despite its name
'error_report' is ultimately just a clever way to run printf()
on a text string. It can be used for errors, warnings, information
alike. If anything the current method is simply misnamed, and could
be changed to 'message_report'.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
