Received: from eggs.gnu.org ([2001:4830:134:3::10]:52612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cmpKm-0004Wi-Q1
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 17:17:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cmpKj-0008Fb-Lv
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 17:17:56 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cmpKj-0008Ex-Fz
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 17:17:53 -0500
Received: by mail-pf0-x242.google.com with SMTP id v190so14801405pfb.0
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 14:17:53 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170311175019.GA7195@ls3530.fritz.box>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b4ca5292-bee3-1e3b-13ba-7dd6c1f00f8a@twiddle.net>
Date: Sun, 12 Mar 2017 08:17:46 +1000
MIME-Version: 1.0
In-Reply-To: <20170311175019.GA7195@ls3530.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix TARGET_MAP* and
 TARGET_F_??LCK for hppa arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

On 03/12/2017 03:50 AM, Helge Deller wrote:
> TARGET_MAP_TYPE needs to be 0x03 instead of 0x0f on the hppa
> architecture, otherwise it conflicts with MAP_FIXED which is 0x04.
>
> Add missing TARGET_MAP_STACK and TARGET_MAP_HUGETLB values.
>
> Fix TARGET_F_RDLCK, TARGET_F_WRLCK and TARGET_F_UNLCK.
>
> Signed-off-by: Helge Deller <deller@gmx.de>

I applied the MAP_FIXED and TARGET_F_* parts separately in my tree.  I'd like 
to see what others think about the other MAP_* defines before including that.


r~
