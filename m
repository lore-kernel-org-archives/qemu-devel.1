Received: from eggs.gnu.org ([209.51.188.92]:32848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1hJzEe-0000pL-4a
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1hJzEc-0000yW-5y
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:41:44 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:40955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1hJzEb-0000pj-Rj
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:41:42 -0400
References: <4ec13220-0c12-3b87-6a79-49a42a38db01@suse.com>
	<20190426083830.kj7currufo637loa@sirius.home.kraxel.org>
From: Lin Ma <lma@suse.com>
Message-ID: <ef5b2ec7-f796-becd-f488-bb17538e93bb@suse.com>
Date: Fri, 26 Apr 2019 19:41:30 +0800
MIME-Version: 1.0
In-Reply-To: <20190426083830.kj7currufo637loa@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] About pt-br keyboard layout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org


On 4/26/19 4:38 PM, Gerd Hoffmann wrote:
> On Fri, Apr 26, 2019 at 04:09:12PM +0800, Lin Ma wrote:
>> Hi all,
>>
>> While I launch qemu with vnc + pt-br keyboard layout on my pc, If I type
>> shift + 6 in iPXE shell or grub shell via my usual 105-key keyboard,
>> shift + 6 would be mapped to "(apostrophe), But IIUC the correct character
>> should be ¨(diaeresis) in pt-br layout.
>>
>> I'm wondering that is it the expected behavior? In other words, Does it make
>> sense if I want to type multi-character characters(say Ç or ¨) without guest
>> os's help?
> No.  -k is for translating keysyms back into the correct scancodes,
> because this is what the (virtual) keyboard passes to the guest.
> So -k must match the *hosts* keyboard layout.
So, that means, If I launch qemu with -k pt-br on a host, I need to 
ensure the keyboard layout
must be pt-br as well onthathypervisorhost,Then when I connected to this 
vnc server(qemu)
throughvncviewer on mylaptop(us keyboard layout), I type shift + 6, I 
can get¨(diaeresis)
character, am I right?
> Translating the scancodes into keysyms again is the job of the guest,
> so that requires the keymapping you want to use being active in the
> guest os.  Typically that would be the same you have on the host, but
> that isn't required.  The guest can work with -- for example -- us
> layout (like it is often the case in boot loaders).  Behavior should be
> identical to physical hardware here.
>
> HTH,
>    Gerd
