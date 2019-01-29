Received: from eggs.gnu.org ([209.51.188.92]:54877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goT3X-0007LY-Nr
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:04:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goT3S-0005j3-3E
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 08:03:59 -0500
References: <1548327184-13416-1-git-send-email-thuth@redhat.com>
	<4aa7084c-3134-ec7b-a3ac-556a5ba9a7b7@oracle.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8766ee08-9bba-cad3-d3a9-fc0468f61b82@redhat.com>
Date: Tue, 29 Jan 2019 14:03:50 +0100
MIME-Version: 1.0
In-Reply-To: <4aa7084c-3134-ec7b-a3ac-556a5ba9a7b7@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Fix LGPL information in the
 file headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>

On 2019-01-29 13:51, Liam Merwick wrote:
> On 24/01/2019 10:53, Thomas Huth wrote:
>> It's either "GNU *Library* General Public version 2" or "GNU Lesser
>> General Public version *2.1*", but there was no "version 2.0" of the
> 
> Should the word "License" be after both instances of "Public" above ?
> 
>> "Lesser" library. So assume that version 2.1 is meant here.
> 
> '"Lesser" library.' -> '"Lesser" license.' ?

Right, thanks a lot for noticing!

Laurent, could you please fix this when you pick this patch up? Or shall
I send a v2?

>> Also some files mentioned the GPL instead of the LGPL after declaring
>> that the files are licensed under the LGPL, so change these spots to
>> use LGPL, too.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> changes below LGTM
> 
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

Thanks!

  Thomas
