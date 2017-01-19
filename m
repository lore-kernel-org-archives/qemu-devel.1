Received: from eggs.gnu.org ([2001:4830:134:3::10]:44427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cU9HW-0000nX-78
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:45:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cU9HV-0003OT-9n
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:45:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cU9HV-0003ND-3G
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:45:21 -0500
Date: Thu, 19 Jan 2017 09:45:11 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170119094511.GE10906@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1484759609-264075-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [RFC 00/13] numa: add '-numa cpu' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Dou Liyang <douly.fnst@cn.fujitsu.com>, Andrew Jones <drjones@redhat.com>, ehabkost@redhat.com, peter.maydell@linaro.org, fanc.fnst@cn.fujitsu.com, Thomas Huth <thuth@redhat.com>, caoj.fnst@cn.fujitsu.com, stefanha@redhat.com, izumi.taku@jp.fujitsu.com, vilanova@ac.upc.edu, David Gibson <david@gibson.dropbear.id.au>

On Wed, Jan 18, 2017 at 06:13:16PM +0100, Igor Mammedov wrote:
> 
> Series introduces a new CLI option to allow mapping cpus to numa
> nodes using public properties [socket|core|thread]-ids instead of
> internal cpu-index and moving cpu<->node mapping from global bitmaps
> to PCMachineState struct.

What is the benefit of this change to apps ? Obviously libvirt uses
the current syntax, but I'm not aware of what problems that has - why
would libvirt want to use this new syntax instead ?


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
