Received: from eggs.gnu.org ([2001:4830:134:3::10]:42704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d41ad-0007w7-JK
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d41aZ-00089P-Fs
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:49:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d41aZ-00089F-9c
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:49:19 -0400
Date: Fri, 28 Apr 2017 09:49:06 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170428084906.GB23819@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170428084237.23960-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170428084237.23960-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] input: limit kbd queue depth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Huawei PSIRT <PSIRT@huawei.com>, P J P <ppandit@redhat.com>

On Fri, Apr 28, 2017 at 10:42:37AM +0200, Gerd Hoffmann wrote:
> Apply a limit to the number of items we accept into the keyboard queue.

Is there a need for similar protection fir mouse input events from VNC ?

> Impact: Without this limit vnc clients can exhaust host memory by
> sending keyboard events faster than qemu feeds them to the guest.

Ability for a remote network client to crash a host by exhausting
memory should be considered a security flaw & have a CVE allocated
for it.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
