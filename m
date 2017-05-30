Received: from eggs.gnu.org ([2001:4830:134:3::10]:47643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <everplays@gmail.com>) id 1dFdjL-0003Ql-W4
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:46:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <everplays@gmail.com>) id 1dFdjL-0003Fb-06
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:46:24 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:35680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <everplays@gmail.com>) id 1dFdjK-0003FK-Pf
	for qemu-devel@nongnu.org; Tue, 30 May 2017 05:46:22 -0400
Received: by mail-wm0-x234.google.com with SMTP id b84so84824054wmh.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 02:46:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2d023d00-d42c-ae88-e8d6-1852b1e89ded@tuxfamily.org>
References: <CAKD7DEGotyMPcyptOkfJjJ9fPKqySWLdt20SZDZ16ZHzzovNYw@mail.gmail.com>
	<2d023d00-d42c-ae88-e8d6-1852b1e89ded@tuxfamily.org>
From: Behrooz Shabani <everplays@gmail.com>
Date: Tue, 30 May 2017 11:46:21 +0200
Message-ID: <CAKD7DEGVu=qhGPR0GxQpBmWpGGJW9nR-4U5hH44HLvBGr3HdRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org

Thanks Thomas.

A question though: is it gonna be writable by guest? I'm asking because
what I found about this feature mentioned that it's readonly ATM.

http://events.linuxfoundation.org/sites/events/files/slides/Qemu_USB.pdf
https://lists.gnu.org/archive/html/qemu-devel/2014-04/msg03466.html

On Tue, May 30, 2017 at 9:50 AM, Thomas Huth <huth@tuxfamily.org> wrote:

> On 30.05.2017 08:22, Behrooz Shabani wrote:
> [...]
> > Any information on how to have a shared storage between different running
> > VMs that would not require `-net user` is very much appreciated as well.
>
> If you need the storage just for transferring files, you could also try
> the "-device usb-mtp" ... that emulates a Media Transfer Protocol device
> (similar to a camera / mobile phone).
>
>  Thomas
>
>
>


-- 
regards,
behrooz
