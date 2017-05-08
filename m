Received: from eggs.gnu.org ([2001:4830:134:3::10]:42540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7k3g-0004U4-S1
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7k3e-0001nD-Ap
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:54:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1d7k3e-0001n3-4W
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:54:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0839383F3A
	for <qemu-devel@nongnu.org>; Mon,  8 May 2017 14:54:41 +0000 (UTC)
References: <1494253073-30622-1-git-send-email-thuth@redhat.com>
	<00168909-6638-2dee-fcfa-1144f6288b02@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4a60fee3-6252-12e1-063e-65d17fd57c14@redhat.com>
Date: Mon, 8 May 2017 16:54:36 +0200
MIME-Version: 1.0
In-Reply-To: <00168909-6638-2dee-fcfa-1144f6288b02@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] qemu-doc: Update to use the new way of
 attaching USB devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

On 08.05.2017 16:38, Paolo Bonzini wrote:
> 
> 
> On 08/05/2017 16:17, Thomas Huth wrote:
>> +@item usb-braille
> 
> I think this should be
> 
> @item usb-braille,chardev=@var{id}

Oh, you're right, the chardev parameter is required here. I did not
notice it since the original documentation did not talk about parameters
here as well... I'll send a v4...

 Thomas
