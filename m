Received: from eggs.gnu.org ([2001:4830:134:3::10]:36942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJIMF-0002Ln-DW
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJIME-00033w-My
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:50:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35096 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fJIME-00032p-IF
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:50:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C034818A6B9
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 12:50:10 +0000 (UTC)
References: <1526560782-18732-1-git-send-email-pbonzini@redhat.com>
	<20180517124403.GJ5657@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <feddfb98-318a-d5ca-1aee-76f99fc52ce8@redhat.com>
Date: Thu, 17 May 2018 14:50:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180517124403.GJ5657@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ui: add x_keymap.o to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On 17/05/2018 14:44, Daniel P. Berrang=C3=A9 wrote:
>> +ifeq ($(CONFIG_X11),y)
>> +sdl.mo-objs +=3D x_keymap.o
>> +gtk.mo-objs +=3D x_keymap.o
> Would this cause symbol clash if both sdl & gtk modules are loaded
> at the same time, or have we used linker scripts to limit what symbols
> each module exposes ?
>=20

We don't, but: 1) the file has only functions and no data; 2) in any
case the symbols are the same, so it is not a real clash.

Adding linker scripts would be a nice improvement, but it is not
necessary for this patch.

Another possibility would be to include x_keymap.c in the files that use
it and make qemu_xkeymap_mapping_table static, but I think it would be
the worst.

Paolo
