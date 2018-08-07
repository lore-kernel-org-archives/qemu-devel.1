Received: from eggs.gnu.org ([2001:4830:134:3::10]:50378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fn3D9-00021O-OZ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:43:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fn3D6-0008AQ-MI
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:43:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fn3D6-0008A6-Fe
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 10:43:44 -0400
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-11-marcandre.lureau@redhat.com>
	<20180807101505.GF7335@redhat.com>
	<CAJ+F1C+=aucconH7EZ8D2g_Wir2wEeq4GMobK+jNPZ8b0LbZKA@mail.gmail.com>
	<20180807143055.pkx7l2ufb36lyq3b@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a227950-7825-e8ee-f6c1-35c6f05d61b3@redhat.com>
Date: Tue, 7 Aug 2018 16:43:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180807143055.pkx7l2ufb36lyq3b@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/10] display: add -display app launching
 external application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 07/08/2018 16:30, Gerd Hoffmann wrote:
>>>
>>>    -display spice,client=yes
>> There is no -display spice, atm.
>>
>> However there is a -display vnc.
> That should not be there.  Now that we have a deprecation process
> I should probably actually deprecate it in favor of -vnc.
> 
>> It's a bit unclear to me the relation between -display and
>> -vnc/-spice/-curses etc. In the end, I tend to think of -display foo
>> as a shortcut for a longer -foo configuration.
> -display is for builtin UIs.  You can have exactly one of these.
> 
> -spice and -vnc is for remote protocols.  They can be used together with
> builtin UIs (even though that isn't a typical use case).  Configuring
> both spice and vnc works too.
> 
> -sdl and -curses are shortcuts for -display sdl and -display curses.
> 

Why not allow multiple -display options, but give an error if more than
one builtin UI is specified?

Paolo
