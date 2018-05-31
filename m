Received: from eggs.gnu.org ([2001:4830:134:3::10]:35187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOKkv-00053u-C2
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fOKks-0005MP-4z
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:24:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fOKkr-0005Ky-U1
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:24:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id a67-v6so52845373wmf.3
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 03:24:25 -0700 (PDT)
References: <cover.1526913931.git.mkletzan@redhat.com>
	<85e343de944def6154c599ecda53bc70688ab60a.1526913931.git.mkletzan@redhat.com>
	<dce741fa-6e2d-ab5c-a180-467df9ffe20a@redhat.com>
	<20180530210829.GB18402@wheatley>
	<14132ba4-8fec-6082-f77a-7da69069f4a2@redhat.com>
	<20180531081952.GD24021@wheatley>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0bdff338-e837-eee7-88d9-69304cb546e3@redhat.com>
Date: Thu, 31 May 2018 12:24:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180531081952.GD24021@wheatley>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [PATCH 2/5] qemu: Move checks for SMM
 from command-line creation into validation phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Martin Kletzander <mkletzan@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: libvir-list@redhat.com, John Ferlan <jferlan@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 31/05/2018 10:19, Martin Kletzander wrote:
>> 
> 
> Oh, it definitely helps.  And I always enjoy when someone explains
> low level details of something like you do, it makes me feel very
> smart after I read it =)
> 
> ...something about the shoulders of giants and stuff...
> 
> I'll fix this up according to what you described, that is smm=on/off 
> will be possible to be specified whenever -machine supports smm=.

That sounds like the right thing, thanks!

Paolo
