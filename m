Received: from eggs.gnu.org ([2001:4830:134:3::10]:46263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fexZP-000247-SJ
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fexZP-0003fH-6f
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:05:19 -0400
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-2-git-send-email-thuth@redhat.com>
	<20180713211636.GS31657@localhost.localdomain>
	<0a63f154-ac68-b6f0-ab6a-e0951c6ae8d5@suse.de>
	<20180713214654.GW31657@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d0d67b3e-825d-d7af-37d8-9c568e0a5885@redhat.com>
Date: Mon, 16 Jul 2018 09:05:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180713214654.GW31657@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/16] qom/object: Add a new function
 object_initialize_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 13.07.2018 23:46, Eduardo Habkost wrote:
> On Fri, Jul 13, 2018 at 11:29:17PM +0200, Andreas F=C3=A4rber wrote:
>> Am 13.07.2018 um 23:16 schrieb Eduardo Habkost:
>>> I wonder if we should deprecate object_initialize() and support
>>> only object_initialize_child() later.  Initializing an object
>>> contained inside another one without making it a child of the
>>> parent object is a recipe for trouble.
>>
>> The root container object needs to be initialized, too.
>=20
> If the object is not embedded in another struct, I would expect
> it to be created using object_new() instead of
> object_initialize().

True. So I guess having a closer look at code that calls
object_initialize() only is something for our TODO lists once 3.0 has
been released...

 Thomas
