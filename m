Received: from eggs.gnu.org ([2001:4830:134:3::10]:55265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cPZ7H-0006AO-SR
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cPZ7G-0000Km-Vt
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:19:51 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cPZ7G-0000I3-PT
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:19:50 -0500
Received: by mail-pg0-x244.google.com with SMTP id 194so204216pgd.0
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 10:19:49 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1483592275-4496-1-git-send-email-jinguojie@loongson.cn>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <959911c8-06b5-a6ff-b12a-06b5a5b58ca2@twiddle.net>
Date: Fri, 6 Jan 2017 10:19:45 -0800
MIME-Version: 1.0
In-Reply-To: <1483592275-4496-1-git-send-email-jinguojie@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 RESEND 00/10] tcg mips64 and mips r6
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jin Guojie <jinguojie@loongson.cn>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, James Hogan <james.hogan@imgtec.com>, YunQiang Su <wzssyqa@gmail.com>

On 01/04/2017 08:57 PM, Jin Guojie wrote:
> Resend for review.  All modifications have been made according to 
> Henderson's review comments, and all tests passed.
> 
> Changes in v6:
>   * Update against master(v2.8.0-rc3)
>   * Fix two bugs according to Richard Henderson's review comments
>     (1) mask: extend TARGET_PAGE_MASK to the proper type
>     (2) zero-extend the guest address, not the address loaded from CMP_OFF
>   * MIPS R6: tested successfully on a qemu mipsel64r6 host (emulating I6400)
>     - Debian amd64 with qemu-system-x86_64

Thanks.  I will send a pull request with this today.


r~
