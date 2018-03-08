Received: from eggs.gnu.org ([2001:4830:134:3::10]:42414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eu00I-0002Mz-8b
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eu00F-0001gR-2w
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:10:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37502 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eu00E-0001g7-Tz
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:10:54 -0500
From: Laszlo Ersek <lersek@redhat.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-6-marcandre.lureau@redhat.com>
	<c0c34117-2ca8-33dc-9aa8-e6e3d0154620@redhat.com>
Message-ID: <281ad76f-cd31-4706-98ae-49ddd8bad22f@redhat.com>
Date: Thu, 8 Mar 2018 19:10:37 +0100
MIME-Version: 1.0
In-Reply-To: <c0c34117-2ca8-33dc-9aa8-e6e3d0154620@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [edk2] [PATCH v2 5/8] ovmf: add OvmfPkg
 Tcg2ConfigPei module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: qemu-devel@nongnu.org, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com

On 03/08/18 18:46, Laszlo Ersek wrote:

> (11a) whatever <Library/...> headers are included in any *.c or *.h file
> are synched with the [LibraryClasses] section in the INF file,

Small correction / clarification: the "entry point" lib classes in the
INF file, such as PeimEntryPoint and UefiDriverEntryPoint, need not be
matched with <Library/...> #includes in the source code.

Thanks
Laszlo
