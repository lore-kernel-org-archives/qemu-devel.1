Received: from eggs.gnu.org ([2001:4830:134:3::10]:34158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZHcp-0006FE-Je
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZHco-0006xU-Mz
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:45:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eZHco-0006wl-GZ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 09:45:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5E88FC01D375
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 14:44:55 +0000 (UTC)
Date: Wed, 10 Jan 2018 14:44:46 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180110144446.GA3205@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
	<1513790098-9815-5-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1513790098-9815-5-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PULL 04/46] contrib: add systemd unit files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Dec 20, 2017 at 06:14:16PM +0100, Paolo Bonzini wrote:
> This lets distros standardize on how QEMU should install systemd
> services for qemu-ga and qemu-pr-helper.
> 
> The qemu-ga unit file comes from Fedora, but I checked that
> Debian is using the same path for the virtio-serisal port.
> 
> I would like to include this in 2.11, so that the qemu-pr-helper
> socket can be standardized across distros.  Note however that
> the files are not installed.  We can add a configure option
> in 2.12 perhaps, but it's too late now; documenting the files
> in the release notes should do.

I see tat despite the commit message, this is actually merged for
2.12 rather than 2.11. We still the make install rules added though.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
