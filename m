Received: from eggs.gnu.org ([2001:4830:134:3::10]:52712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6H6z-0002PK-NM
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6H6w-00036K-Lq
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:48:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6H6w-00035c-FM
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:48:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31D72C01C71E
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 13:48:01 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1493888311-30839-1-git-send-email-thuth@redhat.com>
	<87vapgg7vh.fsf@dusky.pond.sub.org>
	<b5440248-708b-780c-791c-451cfdadfef4@redhat.com>
Date: Thu, 04 May 2017 15:47:57 +0200
In-Reply-To: <b5440248-708b-780c-791c-451cfdadfef4@redhat.com> (Thomas Huth's
	message of "Thu, 4 May 2017 14:09:16 +0200")
Message-ID: <87wp9wbunm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: Update to use the new way of
 attaching USB devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Thomas Huth <thuth@redhat.com> writes:

> On 04.05.2017 13:48, Markus Armbruster wrote:
>> Thomas Huth <thuth@redhat.com> writes:
[...]
>>>  For instance, user-mode networking can be used with
>>>  @example
>>> -qemu-system-i386 [...OPTIONS...] -net user,vlan=0 -usbdevice net:vlan=0
>>> -@end example
>>> -Currently this cannot be used in machines that support PCI NICs.
>>> -@item bt[:@var{hci-type}]
>>> -Bluetooth dongle whose type is specified in the same format as with
>>> -the @option{-bt hci} option, @pxref{bt-hcis,,allowed HCI types}.  If
>>> -no type is given, the HCI logic corresponds to @code{-bt hci,vlan=0}.
>>> -This USB device implements the USB Transport Layer of HCI.  Example
>>> -usage:
>>> -@example
>>> -@command{qemu-system-i386} [...@var{OPTIONS}...] @option{-usbdevice} bt:hci,vlan=3 @option{-bt} device:keyboard,vlan=3
>>> +qemu-system-i386 [...OPTIONS...] -netdev user,id=id0 -device usb-net,netdev=id0
>> 
>> Suggest to use net0 instead of id0 here.
>
> Ok.
>
>>>  @end example
>>> +@item usb-bt-dongle
>>> +Bluetooth dongle which implements the USB Transport Layer of HCI.
>>> +It is connected to HCI scatternet 0 by default (corresponds to
>>> +@code{-bt hci,vlan=0}).
>> 
>> The Bluetooth documentation you replace is confusing.  Ignorant
>> question: is -device ... as expressive as -usbdevice bt:...?
>
> I don't really have a clue about bluetooth in QEMU, too, but from what
> I've seen so far, it does not sound as expressive as the old syntax.

In that case, deprecating -usbdevice bt:... is problematic.  However, we
could bring down the big "qdevify or else" hammer: deprecate the
non-qdevified Bluetooth devices with intent to drop unless someone steps
up and does the work they need.

>> docs/qdev-device-use.txt needs an update for this one.
>
> Ok.
[...]
