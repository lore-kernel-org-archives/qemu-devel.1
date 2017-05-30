Received: from eggs.gnu.org ([2001:4830:134:3::10]:46730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dFflg-0000XG-UQ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dFfld-0006hl-Ug
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:56:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1dFfld-0006hY-NW
	for qemu-devel@nongnu.org; Tue, 30 May 2017 07:56:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id g15so24771013wmc.2
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 04:56:53 -0700 (PDT)
References: <CAKD7DEGotyMPcyptOkfJjJ9fPKqySWLdt20SZDZ16ZHzzovNYw@mail.gmail.com>
	<2d023d00-d42c-ae88-e8d6-1852b1e89ded@tuxfamily.org>
	<CAKD7DEGVu=qhGPR0GxQpBmWpGGJW9nR-4U5hH44HLvBGr3HdRQ@mail.gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <814cd375-fa2c-ea02-6820-068d21358ac1@tuxfamily.org>
Date: Tue, 30 May 2017 13:56:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAKD7DEGVu=qhGPR0GxQpBmWpGGJW9nR-4U5hH44HLvBGr3HdRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] sharing directories with Windows guest - virtio
 pci p9 on Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Behrooz Shabani <everplays@gmail.com>
Cc: qemu-devel@nongnu.org

On 30.05.2017 11:46, Behrooz Shabani wrote:
> Thanks Thomas.
> 
> A question though: is it gonna be writable by guest? I'm asking because
> what I found about this feature mentioned that it's readonly ATM.

Oh, sorry, seems like you're right. I though it would support writing,
but looking at the history of that file, it has never been implemented.
So never mind, MTP is likely not a solution for your problem.

 Thomas


> On Tue, May 30, 2017 at 9:50 AM, Thomas Huth <huth@tuxfamily.org> wrote:
> 
>> On 30.05.2017 08:22, Behrooz Shabani wrote:
>> [...]
>>> Any information on how to have a shared storage between different running
>>> VMs that would not require `-net user` is very much appreciated as well.
>>
>> If you need the storage just for transferring files, you could also try
>> the "-device usb-mtp" ... that emulates a Media Transfer Protocol device
>> (similar to a camera / mobile phone).
