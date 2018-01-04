Received: from eggs.gnu.org ([2001:4830:134:3::10]:33805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX6GY-0001Ct-7E
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:13:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eX6GV-0002fz-EP
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:13:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eX6GV-0002es-8J
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:13:03 -0500
References: <1515071752-22961-1-git-send-email-thuth@redhat.com>
	<20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a78b6f7a-3eb2-6749-ccba-ad1ba4d525ae@redhat.com>
Date: Thu, 4 Jan 2018 15:12:56 +0100
MIME-Version: 1.0
In-Reply-To: <20180104140930.7hbtnen3lw7epmrh@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, kraxel@redhat.com, qemu-devel@nongnu.org

On 04.01.2018 15:09, Samuel Thibault wrote:
> Thomas Huth, on jeu. 04 janv. 2018 14:15:52 +0100, wrote:
>> -@item host:@var{bus}.@var{addr}
>> -Pass through the host device identified by @var{bus}.@var{addr} (Linux only).
>> -
>> -@item host:@var{vendor_id}:@var{product_id}
>> -Pass through the host device identified by @var{vendor_id}:@var{product_id}
>> -(Linux only).
>> -
>> -@item serial:[vendorid=@var{vendor_id}][,productid=@var{product_id}]:@var{dev}
>> -Serial converter to host character device @var{dev}, see @code{-serial} for the
>> -available devices.
> 
> as mentioned in my other mail, I don't find any place in the manpage
> where that is now documented.  I believe this -usbdevice foo
> documentation needs to be converted to -device usb-foo instead of
> removed. Otherwise as it is now there is no way to even know that
> -device usb-mouse, -device usb-disk, etc. are available at all.

I already did convert the chapter that describes the USB devices a
couple of months ago, you can find it in our qemu-doc.html here:

https://qemu.weilnetz.de/doc/qemu-doc.html#usb_005fdevices

 Thomas
