Received: from eggs.gnu.org ([2001:4830:134:3::10]:57067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVJpe-0000gr-9Y
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVJpb-0004U9-ME
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:45:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVJpb-0004TU-Ch
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 11:45:39 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1499847753-8513-1-git-send-email-thuth@redhat.com>
	<20170712145121.GF6020@localhost.localdomain>
Date: Wed, 12 Jul 2017 17:45:30 +0200
In-Reply-To: <20170712145121.GF6020@localhost.localdomain> (Eduardo Habkost's
	message of "Wed, 12 Jul 2017 11:51:21 -0300")
Message-ID: <8760ex4q1x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] hw/i386: Deprecate the machines pc-0.10
 to pc-1.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, Jul 12, 2017 at 10:22:33AM +0200, Thomas Huth wrote:
>> We don't want to carry along old machine types forever. If we are able to
>> remove the pc machines up to 0.13 one day for example, this would allow
>> us to eventually kill the code for rombar=0 (i.e. where QEMU copies ROM
>> BARs directly to low memory). Everything up to pc-1.2 is also known to
>> have issues with migration.  So let's start with a deprecation message
>> for the old machine types so that the (hopefully) few users of these old
>> systems start switching over to newer machine types instead.
>> 
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>
> I suggest changing "-machine help" too.  Today it looks like this:
>
>   Supported machines are:
>   pc-i440fx-2.9        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.8        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.7        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.6        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.5        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.4        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.3        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.2        Standard PC (i440FX + PIIX, 1996)
>   pc                   Standard PC (i440FX + PIIX, 1996) (alias of pc-i440fx-2.10)
>   pc-i440fx-2.10       Standard PC (i440FX + PIIX, 1996) (default)
>   pc-i440fx-2.1        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.0        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-1.7        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-1.6        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-1.5        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-1.4        Standard PC (i440FX + PIIX, 1996)
>   pc-1.3               Standard PC (i440FX + PIIX, 1996)
>   pc-1.2               Standard PC (i440FX + PIIX, 1996)
>   pc-1.1               Standard PC (i440FX + PIIX, 1996)
>   pc-1.0               Standard PC (i440FX + PIIX, 1996)
>   pc-0.15              Standard PC (i440FX + PIIX, 1996)
>   pc-0.14              Standard PC (i440FX + PIIX, 1996)
>   pc-0.13              Standard PC (i440FX + PIIX, 1996)
>   pc-0.12              Standard PC (i440FX + PIIX, 1996)
>   pc-0.11              Standard PC (i440FX + PIIX, 1996)
>   pc-0.10              Standard PC (i440FX + PIIX, 1996)
>   pc-q35-2.9           Standard PC (Q35 + ICH9, 2009)
>   pc-q35-2.8           Standard PC (Q35 + ICH9, 2009)
>   pc-q35-2.7           Standard PC (Q35 + ICH9, 2009)
>   pc-q35-2.6           Standard PC (Q35 + ICH9, 2009)
>   pc-q35-2.5           Standard PC (Q35 + ICH9, 2009)
>   pc-q35-2.4           Standard PC (Q35 + ICH9, 2009)
>   q35                  Standard PC (Q35 + ICH9, 2009) (alias of pc-q35-2.10)
>   pc-q35-2.10          Standard PC (Q35 + ICH9, 2009)
>   isapc                ISA-only PC
>   none                 empty machine
>
>
> It could be changed to something like this:
>
>   Supported machines are:
>   pc-i440fx-2.9        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.8        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.7        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.6        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.5        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.4        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.3        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.2        Standard PC (i440FX + PIIX, 1996)
>   pc                   Standard PC (i440FX + PIIX, 1996) (alias of pc-i440fx-2.10)
>   pc-i440fx-2.10       Standard PC (i440FX + PIIX, 1996) (default)
>   pc-i440fx-2.1        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-2.0        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-1.7        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-1.6        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-1.5        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-1.4        Standard PC (i440FX + PIIX, 1996)
>   pc-1.3               Standard PC (i440FX + PIIX, 1996)
>   pc-q35-2.9           Standard PC (Q35 + ICH9, 2009)
>   pc-q35-2.8           Standard PC (Q35 + ICH9, 2009)
>   pc-q35-2.7           Standard PC (Q35 + ICH9, 2009)
>   pc-q35-2.6           Standard PC (Q35 + ICH9, 2009)
>   pc-q35-2.5           Standard PC (Q35 + ICH9, 2009)
>   pc-q35-2.4           Standard PC (Q35 + ICH9, 2009)
>   q35                  Standard PC (Q35 + ICH9, 2009) (alias of pc-q35-2.10)
>   pc-q35-2.10          Standard PC (Q35 + ICH9, 2009)
>   isapc                ISA-only PC
>   none                 empty machine
>
>   Deprecated machines: pc-1.2, pc-1.1, pc-1.0, pc-0.15, pc-0.14, pc-0.13,
>                        pc-0.12, pc-0.11, pc-0.10.

I'd add "(deprecated)" to the existing lines instead.  Probably simpler
to code, because it's consistent with the existing format.
