Received: from eggs.gnu.org ([2001:4830:134:3::10]:39108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhunxun@gmail.com>) id 1d15bA-00024x-8K
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhunxun@gmail.com>) id 1d15b5-0001aW-Vw
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:29:44 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhunxun@gmail.com>) id 1d15b5-0001a3-OF
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:29:43 -0400
Received: by mail-wm0-x22b.google.com with SMTP id r190so38923556wme.1
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 23:29:43 -0700 (PDT)
MIME-Version: 1.0
From: "jack.chen" <zhunxun@gmail.com>
Date: Thu, 20 Apr 2017 14:29:41 +0800
Message-ID: <CADUDsAq-qYWkKLWKh3u38y0Fr3TvhYc9cXQz+yUitbDQKdFAjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] question about handling overlapping memory when add
 region in qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu <qemu-devel@nongnu.org>

Hello ,in kvm_set_phys_mem,I am confused about the following codes:
delta = TARGET_PAGE_ALIGN(size) - size;
    if (delta > size) {
        return;
    }
    start_addr += delta;
    size -= delta;
    size &= TARGET_PAGE_MASK;

why start_addr need to add delta,and why size sub delta,in my own
opinion,if size +=delta ,I can understand,but i do not know why
sub??thanks in advance!!
