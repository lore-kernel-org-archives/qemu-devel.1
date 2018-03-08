Received: from eggs.gnu.org ([2001:4830:134:3::10]:48670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=598be321f=ross.lagerwall@citrix.com>)
	id 1etrmf-0000ea-2z
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:24:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=598be321f=ross.lagerwall@citrix.com>)
	id 1etrmb-00065Z-TX
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:24:21 -0500
Received: from smtp.citrix.com ([66.165.176.89]:34817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=598be321f=ross.lagerwall@citrix.com>)
	id 1etrmb-00064o-LF
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:24:17 -0500
References: <20180308073159.1068-1-kraxel@redhat.com>
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <b5acd753-b32c-0175-e413-783f1c64fba2@citrix.com>
Date: Thu, 8 Mar 2018 09:24:12 +0000
MIME-Version: 1.0
In-Reply-To: <20180308073159.1068-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vga: fix region calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: P J P <ppandit@redhat.com>

On 03/08/2018 07:31 AM, Gerd Hoffmann wrote:
> Typically the scanline length and the line offset are identical.  But
> case they are not our calculation for region_end is incorrect.  Using
> line_offset is fine for all scanlines, except the last one where we have
> to use the actual scanline length.
> 
> Fixes: CVE-2018-<to-be-filled>
> Cc: P J P <ppandit@redhat.com>
> Cc: Ross Lagerwall <ross.lagerwall@citrix.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Tested-by: Ross Lagerwall <ross.lagerwall@citrix.com>

Thanks!
-- 
Ross Lagerwall
