Received: from eggs.gnu.org ([2001:4830:134:3::10]:51427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS6Xr-00019w-8x
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS6Xq-00043L-62
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:25:47 -0500
Received: from mail-yb0-x244.google.com ([2607:f8b0:4002:c09::244]:34442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cS6Xq-00043E-1e
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:25:46 -0500
Received: by mail-yb0-x244.google.com with SMTP id w194so2080102ybe.1
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 10:25:45 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484311923-28637-1-git-send-email-laurent@vivier.eu>
	<1484311923-28637-2-git-send-email-laurent@vivier.eu>
	<099ce4bd-8256-c797-16f8-74d3ee5833ff@twiddle.net>
	<520a7576-eb74-0c5d-80bf-ba521dbab29e@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1f002403-e2d8-9ad1-eca2-fe2dc54ba70b@twiddle.net>
Date: Fri, 13 Jan 2017 10:25:41 -0800
MIME-Version: 1.0
In-Reply-To: <520a7576-eb74-0c5d-80bf-ba521dbab29e@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] target-m68k: fix bit operation with
 immediate value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/13/2017 10:23 AM, Laurent Vivier wrote:
> See "BSET Instruction Format:BIT NUMBER STATIC, SPECIFIED AS IMMEDIATE
> DATA", p. 4.58 of "M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL", "BIT
> NUMBER" is bits 0 to 8 of extended word.

Oops, yep.  I misread that.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
