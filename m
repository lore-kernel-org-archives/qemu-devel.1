Received: from eggs.gnu.org ([2001:4830:134:3::10]:37948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7jnu-0003gl-Vr
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:38:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7jnr-00042E-Or
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:38:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d7jnr-00041r-He
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:38:23 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D98D3DBF7
	for <qemu-devel@nongnu.org>; Mon,  8 May 2017 14:38:22 +0000 (UTC)
References: <1494253073-30622-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00168909-6638-2dee-fcfa-1144f6288b02@redhat.com>
Date: Mon, 8 May 2017 16:38:18 +0200
MIME-Version: 1.0
In-Reply-To: <1494253073-30622-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>



On 08/05/2017 16:17, Thomas Huth wrote:
> +@item usb-braille

I think this should be

@item usb-braille,chardev=@var{id}

>  Braille device.  This will use BrlAPI to display the braille output on a real
>  or fake device.
