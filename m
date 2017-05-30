Received: from eggs.gnu.org ([2001:4830:134:3::10]:50594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFhwC-0002OR-SY
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dFhw8-000433-FR
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:15:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dFhw8-00042x-9w
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:15:52 -0400
Message-ID: <1496153741.4100.7.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 30 May 2017 16:15:41 +0200
In-Reply-To: <d59a1024-05c5-a041-4fb3-7e9411aa32a0@redhat.com>
References: <1494430493-23119-1-git-send-email-thuth@redhat.com>
	<40588676-2a57-c17f-1f05-00c017da18ba@redhat.com>
	<1496140501.4100.5.camel@redhat.com>
	<d59a1024-05c5-a041-4fb3-7e9411aa32a0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

  Hi,

> So far we've got deprecation warnings at very different places in the
> code - for command line parameters, for HMP commands, for some few
> devices, ... and this time it's for the first time for old machine
> types. I currently don't see a pattern yet where a "deprecated" flag
> in
> MachineClass or DeviceClass would really help to simplify the code
> right
> now ... maybe later if we deprecate multiple machines at the same
> time?

Advantage would not only be a simpler code, but also to formalize the
deprecation process a bit, especially for cases where we most likely
will continue deprecate stuff (like old, versioned machine types) in
the future.  It would make it easier to grep for deprecated code.  And
optionally we could put some meta info into the source code, such as
planned removal date and removal reason, which could be printed
together with the deprecation message.

cheers,
  Gerd
