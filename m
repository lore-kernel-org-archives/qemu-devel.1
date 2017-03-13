Received: from eggs.gnu.org ([2001:4830:134:3::10]:51005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gveitmic@redhat.com>) id 1cnGCx-0002uQ-4O
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 22:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gveitmic@redhat.com>) id 1cnGCt-0004fI-AY
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 22:59:39 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gveitmic@redhat.com>) id 1cnGCt-0004eb-6G
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 22:59:35 -0400
Received: by mail-yw0-f176.google.com with SMTP id p77so51746596ywg.1
	for <qemu-devel@nongnu.org>; Sun, 12 Mar 2017 19:59:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87o9xizhs1.fsf@dusky.pond.sub.org>
References: <CANHSq5DhUak9fVpvjG=VyeetP7VQudHwyEa4VevC21BuieSstw@mail.gmail.com>
	<20170303103919.GA2439@work-vm> <87o9xizhs1.fsf@dusky.pond.sub.org>
From: Germano Veit Michel <germano@redhat.com>
Date: Mon, 13 Mar 2017 12:59:33 +1000
Message-ID: <CANHSq5B4t8g3sDc4m+_Uc9+ya=yCpDK-t3tdd5d=RO-YH5r87w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH V2] migration: expose qemu_announce_self()
 via qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Juan Jose Quintela Carreira <quintela@redhat.com>

On Fri, Mar 3, 2017 at 10:06 PM, Markus Armbruster <armbru@redhat.com> wrote:
>
> Please drop this line.
>
>>> +#
>>> +# Example:
>>> +#
>>> +# -> { "execute": "announce-self" }
>>> +# <- { "return": {} }
>>> +#
>>> +# Since: 2.9
>>> +##
>>> +{ 'command': 'announce-self' }
>>> +
>

Hi Markus,

Are you talking about the whole example section or just the empty line
at the end?

I'm preparing a V3 with hmp commands and g_new0.

Thanks,
Germano
