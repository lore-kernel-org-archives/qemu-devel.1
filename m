Received: from eggs.gnu.org ([2001:4830:134:3::10]:50497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ePqUn-0005Mb-1I
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:57:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ePqUk-0006CD-0J
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:57:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ePqUj-0006BT-QC
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:57:45 -0500
Date: Fri, 15 Dec 2017 13:57:38 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171215135738.GF11724@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CABMrAhLV6LLwBR70-P4EnekWHKD4AkaatzxQwuxtOnNYQ3MEqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABMrAhLV6LLwBR70-P4EnekWHKD4AkaatzxQwuxtOnNYQ3MEqQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Key code conflict in keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Miika S <miika9764@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On Fri, Dec 15, 2017 at 03:51:19PM +0200, Miika S wrote:
> Hi
> 
> I tried to add JIS keyboard support to virtio-input-hid but ran
> into a problem with keys that have the "Linux Name" KEY_ISO and
> KEY_KATAKANAHIRAGANA. The problem appears to be that they have
> the same "AT set1 keycode" 0x70. I worked around it by removing
> KEY_ISO from keycodemapdb and got the keys working, but that
> doesn't work for the rest of QEMU. Is it intended that the keys
> have the same "AT set1 keycode"?

It is probably a misake


> @@ -246,7 +246,6 @@
> KEY_STOPCD,166,,,0xe024,0xe03b,0x98,233,VK_MEDIA_STOP,0xb2,,,,,MediaStop,I174,au
>  KEY_RECORD,167,,,0xe031,,0x9e,,,,,,,,,I175,,,
>  KEY_REWIND,168,,,0xe018,,0x9f,,,,,,,,,I176,,,
>  KEY_PHONE,169,,,0x63,,,,,,,,,,,I177,,,
> -KEY_ISO,170,ISO_Section,0xa,0x70,,,,,,,,,,,I178,,,

Instead of deleteing this line entirely, the right fix is probably to just
blank out the 0x70 value here.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
