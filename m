Received: from eggs.gnu.org ([2001:4830:134:3::10]:49993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.brian@accelerated.com>) id 1dKvY4-0002EP-57
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.brian@accelerated.com>) id 1dKvY1-0004cS-1A
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:48:36 -0400
Received: from mail-dm3nam03on0086.outbound.protection.outlook.com
	([104.47.41.86]:47232
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.brian@accelerated.com>)
	id 1dKvY0-0004cD-PO
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 19:48:32 -0400
References: <dc2d2f2f-0c82-fa8f-9da1-b183fc203110@accelerated.com>
	<1497349375.8068.3.camel@redhat.com>
From: Samuel Brian <sam.brian@accelerated.com>
Message-ID: <c360a817-808e-e913-9e1c-13455ac75656@accelerated.com>
Date: Wed, 14 Jun 2017 09:48:12 +1000
MIME-Version: 1.0
In-Reply-To: <1497349375.8068.3.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] usb-host: support devices with
 sparse/non-sequential USB interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

Done. Had to V3 it to pass the formatting check. Sorry about that.

Sam

On 13/06/17 20:22, Gerd Hoffmann wrote:
> On Tue, 2017-06-13 at 14:17 +1000, Samuel Brian wrote:
>> This change allows sparse USB interface numbering.
>> Instead of only claiming the interfaces in the range reported by the
>> USB
>> device through bNumInterfaces, QEMU attempts to claim all possible
>> interfaces.
> 
> Patch looks good but fails to apply.  Thunderbird wrapped lines and
> corrupted the patch.
> 
> Please resend using "git send-email" to avoid that.
> 
> thanks,
>    Gerd
> 
> 
