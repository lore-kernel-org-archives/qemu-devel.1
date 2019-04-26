Received: from eggs.gnu.org ([209.51.188.92]:48618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1hK0Lh-0001eg-AM
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1hK0Lf-0002MZ-34
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:53:04 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:42038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1hK0Le-0002H3-Cg
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:53:03 -0400
References: <4ec13220-0c12-3b87-6a79-49a42a38db01@suse.com>
	<20190426083830.kj7currufo637loa@sirius.home.kraxel.org>
	<ef5b2ec7-f796-becd-f488-bb17538e93bb@suse.com>
	<20190426114857.jrso2nox5tdgtp5k@sirius.home.kraxel.org>
From: Lin Ma <lma@suse.com>
Message-ID: <2fea760f-db60-0edc-889c-7a73c3f15375@suse.com>
Date: Fri, 26 Apr 2019 20:52:45 +0800
MIME-Version: 1.0
In-Reply-To: <20190426114857.jrso2nox5tdgtp5k@sirius.home.kraxel.org>
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


On 4/26/19 7:48 PM, Gerd Hoffmann wrote:
>>> So -k must match the *hosts* keyboard layout.
>> So, that means, If I launch qemu with -k pt-br on a host, I need to ensure
>> the keyboard layout
>> must be pt-br as well onthathypervisorhost,Then when I connected to this vnc
>> server(qemu)
>> throughvncviewer on mylaptop(us keyboard layout), I type shift + 6, I can
>> get¨(diaeresis)
>> character, am I right?
> No.  I've simplified a bit, assuming both vncviewer and qemu run on the
> host machine.  -k $layout must match the keyboard layout of the machine
> running vncviewer.  So, in your case it should be us (the laptops
> layout).
:-)  Thank you very much!
Lin
