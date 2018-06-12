Received: from eggs.gnu.org ([2001:4830:134:3::10]:36555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fShyC-0004Qb-5P
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fShy5-0008Da-Se
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:00:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49598 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fShy5-0008D6-OW
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:00:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F197FFD325
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 12:00:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-6-dgilbert@redhat.com>
	<87y3flilan.fsf@dusky.pond.sub.org> <20180611174958.GP2661@work-vm>
	<20180612053720.pp2xvb7r34o6ort7@sirius.home.kraxel.org>
Date: Tue, 12 Jun 2018 14:00:05 +0200
In-Reply-To: <20180612053720.pp2xvb7r34o6ort7@sirius.home.kraxel.org> (Gerd
	Hoffmann's message of "Tue, 12 Jun 2018 07:37:20 +0200")
Message-ID: <87k1r4use2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, imammedo@redhat.com, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>> > Now let's review the three commands:
>> > 
>> > * Gerd, why does "info usbhost" have no QMP equivalent?
>
> Works only when running qemu directly, in the libvirt sandbox qemu
> hasn't the permissions needed to scan the host usb bus so that would be
> rather pointless ...

I don't think this meets either of the two criteria:

* I meets "makes no sense in QMP" only if QMP implies "can't scan host
  USB bus".  Libvirt implies it, but QMP doesn't imply libvirt; it's its
  most important, not its sole user.

* It meets "of use only for human users" only if we're convinced it's of
  no use to programs.

  To avoid speculation and endless arguments about what could or could
  not be of use, we've always stuck to "when in doubt, assume it could
  be of use".

  "Libvirt can't use it" falls short.

  "Any management application worth anything would deny QEMU the
  capability to scan the USB host bus, and thus wouldn't be able to use
  it" is exactly the argument we intended to avoid.

QMP falling short of completeness in relatively unimportant ways like
this one isn't exactly terrible.  The most serious effect is probably
serving as a bad example that leads to further arguments like this one.
These are well worth avoiding, though.
